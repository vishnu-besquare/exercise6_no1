import 'dart:async';

import 'counter_event.dart';

class CounterBloc {
  int _counter = 0; //inital value of counter is 0

  final _counterStateController = StreamController<int>(); // counter stream

  StreamSink<int> get _inCounter => _counterStateController.sink;

  Stream<int> get counter => _counterStateController.stream;

  final _counterEventController =
      StreamController<CounterEvent>(); //event Stream

  Sink<CounterEvent> get counterEventSink => _counterEventController
      .sink; // this one we only need sink and not stream because we get info frm UI and not send it put anywhere

  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent)
      _counter++;
    else
      _counter--;

    _inCounter.add(_counter);
  }

  void dispose() {
    _counterEventController.close();
    _counterStateController.close();
  }
}

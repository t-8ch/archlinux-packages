#!/bin/bash

. /etc/rc.conf
. /etc/rc.d/functions

case "$1" in
  start)
    stat_busy "Starting Filetea"
    filetea -D &> /dev/null
    if [ $? -gt 0 ]; then
      stat_fail
    else
      add_daemon filetea
      stat_done
    fi
    ;;
  stop)
    stat_busy "Stopping Filetea"
    PID=$(pidof -o %PPID /usr/sbin/filetea)
    kill $PID &> /dev/null
    if [ $? -gt 0 ]; then
      stat_fail
    else
      rm_daemon filetea
      stat_done
    fi
    ;;
  restart)
    $0 stop
    sleep 1
    $0 start
    ;;
  *)
    echo "usage: $0 {start|stop|restart}"
esac
exit 0

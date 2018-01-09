#!/bin/bash
set -v

DB_USERNAME=system
DB_PASSWORD=oracle
DB_HOST=127.0.0.1:1521/xe

timeCounter=0
timeLimit=300
readyFile=.ready

rm -f $readyFile

function tryConnection {
sql -S -L $DB_USERNAME/$DB_PASSWORD@$DB_HOST <<EOF
spool $readyFile
spool off
exit;
EOF
}

while [ $timeCounter -lt $timeLimit ] && [ ! -f $readyFile ]; do
tryConnection
timeCounter=$((timeCounter + 1))
sleep 1s
done

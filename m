Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261555AbSJYTDa>; Fri, 25 Oct 2002 15:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261557AbSJYTDa>; Fri, 25 Oct 2002 15:03:30 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:35572 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261555AbSJYTDY>;
	Fri, 25 Oct 2002 15:03:24 -0400
Subject: Re: 2.5.44-mm5 - ltp-cvs (current) - 98.74% Pass
From: Paul Larson <plars@linuxtestproject.org>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       ltp-results <ltp-results@lists.sourceforge.net>
In-Reply-To: <3DB8D94B.20D3D5BD@digeo.com>
References: <3DB8D94B.20D3D5BD@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 25 Oct 2002 14:00:08 -0500
Message-Id: <1035572409.3447.205.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.44-mm5 does not have any new or unexpected LTP failures above
2.5.44-vanilla.  These results are the same for both.

These results are on an 8-way PIII-700 16 GB.  Preempt off, PAE on,
HUGETLB on, Shared PTE on

tag=nanosleep02 stime=1035560360 dur=1 exit=exited stat=1 core=no cu=0
cs=0
tag=personality02 stime=1035560367 dur=0 exit=exited stat=1 core=no cu=0
cs=0
tag=pread02 stime=1035560372 dur=0 exit=exited stat=1 core=no cu=1 cs=1
tag=pwrite02 stime=1035560372 dur=0 exit=exited stat=1 core=no cu=0 cs=1
tag=writev01 stime=1035560429 dur=0 exit=exited stat=1 core=no cu=0 cs=1
tag=dio04 stime=1035561857 dur=0 exit=exited stat=1 core=no cu=0 cs=0
tag=dio10 stime=1035561870 dur=400 exit=exited stat=1 core=no cu=124
cs=465
tag=sem02 stime=1035562935 dur=20 exit=exited stat=1 core=no cu=0 cs=0

---test_start---
tag=nanosleep02 stime=1035525897
cmdline="nanosleep02"
contacts=""
analysis=exit
initiation_status="ok"
---test_output---
nanosleep02    1  FAIL  :  Remaining sleep time 4001000 usec doesn't
match with the expected 3998337 usec time
nanosleep02    1  FAIL  :  child process exited abnormally
---execution_status---
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
---test_end---
---test_start---
tag=personality02 stime=1035525903
cmdline="personality02"
contacts=""
analysis=exit
initiation_status="ok"
---test_output---
personality02    1  FAIL  :  call failed - errno = 0 - Success
---execution_status---
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
---test_end---
---test_start---
tag=pread02 stime=1035525908
cmdline="pread02"
contacts=""
analysis=exit
initiation_status="ok"
---test_output---
pread02     1  PASS  :  pread() fails, file descriptor is a PIPE or
FIFO, errno:29
pread02     2  FAIL  :  pread() returned 0, expected -1, errno:22
---execution_status---
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
---test_end---
---test_start---
tag=pwrite02 stime=1035525908
cmdline="pwrite02"
contacts=""
analysis=exit
initiation_status="ok"
---test_output---
pwrite02    1  PASS  :  file descriptor is a PIPE or FIFO, errno:29
caught SIGXFSZ
pwrite02    2  FAIL  :  specified offset is -ve or invalid, unexpected
errno:27, expected:22
pwrite02    3  PASS  :  file descriptor is bad, errno:9
---execution_status---
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
---test_end---
---test_start---
tag=writev01 stime=1035525965
cmdline="writev01"
contacts=""
analysis=exit
initiation_status="ok"
---test_output---
writev01    0  INFO  :  Enter Block 1
writev01    0  INFO  :  Received EINVAL as expected
writev01    0  INFO  :  block 1 PASSED
writev01    0  INFO  :  Exit block 1
writev01    0  INFO  :  Enter block 2
writev01    1  FAIL  :  writev() failed unexpectedly
writev01    0  INFO  :  block 2 FAILED
writev01    0  INFO  :  Exit block 2
writev01    0  INFO  :  Enter block 3
writev01    0  INFO  :  block 3 PASSED
writev01    0  INFO  :  Exit block 3
writev01    0  INFO  :  Enter block 4
writev01    0  INFO  :  Received EBADF as expected
writev01    0  INFO  :  block 4 PASSED
writev01    0  INFO  :  Exit block 4
writev01    0  INFO  :  Enter block 5
writev01    0  INFO  :  Received EINVAL as expected
writev01    0  INFO  :  block 5 PASSED
writev01    0  INFO  :  Exit block 5
writev01    0  INFO  :  Enter block 6
writev01    2  PASS  :  writev() wrote 0 iovectors
writev01    0  INFO  :  block 6 PASSED
writev01    0  INFO  :  Exit block 6
writev01    0  INFO  :  Enter block 7
writev01    3  PASS  :  writev passed writing 64 bytes, followed by two
NULL vectors
writev01    0  INFO  :  block 7 PASSED
writev01    0  INFO  :  Exit block 7
writev01    0  INFO  :  Enter block 8
writev01    0  INFO  :  Received EPIPE as expected
writev01    0  INFO  :  block 8 PASSED
writev01    0  INFO  :  Exit block 8
---execution_status---
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
---test_end---
---test_start---
tag=dio04 stime=1035527610
cmdline="diotest4"
contacts=""
analysis=exit
initiation_status="ok"
---test_output---
[9] open /dev/null:Invalid argument
---execution_status---
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=38
---test_end---
---test_start---
tag=dio10 stime=1035527680
cmdline="diotest4 -b 65536"
contacts=""
analysis=exit
initiation_status="ok"
---test_output---
[9] open /dev/null:Invalid argument
---execution_status---
duration=1444 termination_type=exited termination_id=1 corefile=no
cutime=127 cstime=118842
---test_end---
---test_start---
tag=sem02 stime=1035530115
cmdline="sem02"
contacts=""
analysis=exit
initiation_status="ok"
---test_output---
Waiter, pid = 5116
Poster, pid = 5117, posting
Poster posted
Poster exiting
Waiter waiting, pid = 5116
sem02: FAIL
Waiter done waiting
---execution_status---
duration=20 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
---test_end---

Thanks,
Paul Larson


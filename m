Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314497AbSDRXgY>; Thu, 18 Apr 2002 19:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314498AbSDRXgX>; Thu, 18 Apr 2002 19:36:23 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.181.130.16]:60802 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S314497AbSDRXgV>; Thu, 18 Apr 2002 19:36:21 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam1
Date: Fri, 19 Apr 2002 01:36:15 +0200
X-Mailer: KMail [version 1.4]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>, Andrew Morton <akpm@zip.com.au>,
        Ingo Molnar <mingo@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200204190136.15978.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:

[-]
> Rest as usual, O1-sched-k3 (is any backport of the updates planned ??)
> mini-low-lat, splitted-vm-33, bproc-3.1.9.

Have you ever done any "regression testing" with your -jam patch?

Then you should have found very very bad latency behavior with O(1)-K3 
applied! Even Alan's -ac series (including the latest O(1)-K3 patch) is 
shocked.

No uptodate O(1) patch for 2.4. Very sad.
So there isn't any change to see a current preemption patch on top of vm33 and 
O(1).

No, lowlatency didn't come close to preemption+lock-break (best latency 
numbers for 2.4.17-preX-rml, were ~2.9ms max).

I'm under the impression that "all" development is focused on 2.5.x, now.
Even the VM stuff show no mayor growth ;-(

Additional latencytest0.42-png numbers for both kernels are available.

Thanks,
	Dieter

2.4.19-pre7-dn1
splitted vm33
23-lowlatency-mini
24-lowlatency-fixes-5
25-read-latency-2

SunWave1 dbench/latencytest0.42-png# time ./do_tests none 3 256 0 350000000
x11perf - X11 performance program, version 1.5
The XFree86 Project, Inc server version 40200000 on :0.0
from SunWave1
Thu Apr 18 21:03:48 2002

Sync time adjustment is 0.2185 msecs.

   3000 reps @   2.2690 msec (   441.0/sec): Scroll 500x500 pixels
   3000 reps @   2.2747 msec (   440.0/sec): Scroll 500x500 pixels
   3000 reps @   2.2709 msec (   440.0/sec): Scroll 500x500 pixels
   3000 reps @   2.2697 msec (   441.0/sec): Scroll 500x500 pixels
   3000 reps @   2.2771 msec (   439.0/sec): Scroll 500x500 pixels
  15000 trep @   2.2723 msec (   440.0/sec): Scroll 500x500 pixels

    800 reps @  11.8050 msec (    84.7/sec): ShmPutImage 500x500 square
    800 reps @  11.8099 msec (    84.7/sec): ShmPutImage 500x500 square
    800 reps @  11.9632 msec (    83.6/sec): ShmPutImage 500x500 square
    800 reps @  11.8041 msec (    84.7/sec): ShmPutImage 500x500 square
    800 reps @  11.8199 msec (    84.6/sec): ShmPutImage 500x500 square
   4000 trep @  11.8404 msec (    84.5/sec): ShmPutImage 500x500 square

fragment latency = 1.451247 ms
cpu latency = 1.160998 ms
  4.2ms (  0)|
1MS num_time_samples=64412 num_times_within_1ms=62014 factor=96.277091
2MS num_time_samples=64412 num_times_within_2ms=64403 factor=99.986027
PIXEL_PER_MS=103
fragment latency = 1.451247 ms
cpu latency = 1.160998 ms
  4.2ms (  0)|
1MS num_time_samples=20748 num_times_within_1ms=20050 factor=96.635820
2MS num_time_samples=20748 num_times_within_2ms=20746 factor=99.990361
PIXEL_PER_MS=103
fragment latency = 1.451247 ms
cpu latency = 1.160998 ms
  4.5ms (  1)|
1MS num_time_samples=10451 num_times_within_1ms=10007 factor=95.751603
2MS num_time_samples=10451 num_times_within_2ms=10436 factor=99.856473
PIXEL_PER_MS=103
-rw-r--r--    1 root     root     350000000 Apr 18 21:06 tmpfile
fragment latency = 1.451247 ms
cpu latency = 1.160998 ms
  7.8ms (  4)|
1MS num_time_samples=21423 num_times_within_1ms=20546 factor=95.906269
2MS num_time_samples=21423 num_times_within_2ms=21411 factor=99.943985
PIXEL_PER_MS=103
-rw-r--r--    1 root     root     350000000 Apr 18 21:06 tmpfile
-rw-r--r--    1 root     root     350000000 Apr 18 21:07 tmpfile2
fragment latency = 1.451247 ms
cpu latency = 1.160998 ms
  4.4ms (  1)|
1MS num_time_samples=16340 num_times_within_1ms=15597 factor=95.452876
2MS num_time_samples=16340 num_times_within_2ms=16324 factor=99.902081
PIXEL_PER_MS=103
-rw-r--r--    1 root     root     350000000 Apr 18 21:06 tmpfile
-rw-r--r--    1 root     root     350000000 Apr 18 21:07 tmpfile2
109.610u 17.740s 4:03.41 52.3%  0+0k 0+0io 10444pf+0w

*******************************************************************************

2.4.19-pre7-dn1
splitted vm33
23-lowlatency-mini
24-lowlatency-fixes-5
25-read-latency-2

20-sched-O1-K3
21-sched-balance
22-sched-aa-fixes

SunWave1 dbench/latencytest0.42-png# time ./do_tests none 3 256 0 350000000
x11perf - X11 performance program, version 1.5
The XFree86 Project, Inc server version 40200000 on :0.0
from SunWave1
Fri Apr 19 00:40:11 2002

Sync time adjustment is 0.1351 msecs.

   3000 reps @   1.8390 msec (   544.0/sec): Scroll 500x500 pixels
   3000 reps @   1.6942 msec (   590.0/sec): Scroll 500x500 pixels
   3000 reps @   1.6915 msec (   591.0/sec): Scroll 500x500 pixels
   3000 reps @   1.6962 msec (   590.0/sec): Scroll 500x500 pixels
   3000 reps @   1.6949 msec (   590.0/sec): Scroll 500x500 pixels
  15000 trep @   1.7231 msec (   580.0/sec): Scroll 500x500 pixels

   1200 reps @   5.2230 msec (   191.0/sec): ShmPutImage 500x500 square
   1200 reps @   5.2480 msec (   191.0/sec): ShmPutImage 500x500 square
   1200 reps @   5.2290 msec (   191.0/sec): ShmPutImage 500x500 square
   1200 reps @   5.2355 msec (   191.0/sec): ShmPutImage 500x500 square
   1200 reps @   5.2289 msec (   191.0/sec): ShmPutImage 500x500 square
   6000 trep @   5.2328 msec (   191.0/sec): ShmPutImage 500x500 square

fragment latency = 1.451247 ms
cpu latency = 1.160998 ms
247.4ms (423)|
1MS num_time_samples=6079 num_times_within_1ms=5462 factor=89.850304
2MS num_time_samples=6079 num_times_within_2ms=5646 factor=92.877118
PIXEL_PER_MS=103
fragment latency = 1.451247 ms
cpu latency = 1.160998 ms
351.8ms ( 15)|
1MS num_time_samples=19475 num_times_within_1ms=15437 factor=79.265725
2MS num_time_samples=19475 num_times_within_2ms=19415 factor=99.691913
PIXEL_PER_MS=103
fragment latency = 1.451247 ms
cpu latency = 1.160998 ms
150.7ms ( 24)|
1MS num_time_samples=7052 num_times_within_1ms=6852 factor=97.163925
2MS num_time_samples=7052 num_times_within_2ms=7003 factor=99.305162
PIXEL_PER_MS=103
-rw-r--r--    1 root     root     350000000 Apr 19 00:42 tmpfile
fragment latency = 1.451247 ms
cpu latency = 1.160998 ms
 42.9ms (378)|
1MS num_time_samples=16697 num_times_within_1ms=16021 factor=95.951369
2MS num_time_samples=16697 num_times_within_2ms=16273 factor=97.460622
PIXEL_PER_MS=103
-rw-r--r--    1 root     root     350000000 Apr 19 00:42 tmpfile
-rw-r--r--    1 root     root     350000000 Apr 19 00:43 tmpfile2
fragment latency = 1.451247 ms
cpu latency = 1.160998 ms
525.6ms (551)|
1MS num_time_samples=13764 num_times_within_1ms=12584 factor=91.426911
2MS num_time_samples=13764 num_times_within_2ms=12839 factor=93.279570
PIXEL_PER_MS=103
-rw-r--r--    1 root     root     350000000 Apr 19 00:42 tmpfile
-rw-r--r--    1 root     root     350000000 Apr 19 00:43 tmpfile2
40.610u 16.630s 3:28.57 27.4%   0+0k 0+0io 10796pf+0w

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de

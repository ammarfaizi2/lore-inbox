Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277708AbRJ1ErW>; Sun, 28 Oct 2001 00:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277703AbRJ1ErN>; Sun, 28 Oct 2001 00:47:13 -0400
Received: from gull.mail.pas.earthlink.net ([207.217.121.85]:45797 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S277702AbRJ1ErG>; Sun, 28 Oct 2001 00:47:06 -0400
Date: Sun, 28 Oct 2001 00:49:34 -0400
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: VM tests on 2.4.14-pre3 and 2.4.13-ac3
Message-ID: <20011028004934.A22539@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Summary:

2.4.14-pre3		The greased weasel is back
2.4.13-ac3		Inconsistent results on mtest01
2.4.13-ac3-freeswap	patch for 2.4.12-ac3 makes results consistent in mtest01

Test:	Run mtest01 and mmap001 from Linux Test Project.  
	Listen to long running (50+ minutes) mp3 sampled at 128k.

Default kernel parameters.

Light interactive use: lynx, 2 bitchx (console IRC client) sessions,
vmstat 8, iostat -d 10.  (52k link to net - mostly idle).

2.4.13-pre3 had much better interactive response than 2.4.13-ac3
during these tests.  No X.

Hardware:
AMD 1333 Athlon
512 MB RAM
1024 MB swap

mtest01
=======

2.4.14-pre3

mp3blaster did not skip.  Best time I ever recorded for this test 
without mp3 skipping.  Previous "best" with no mp3 skips was:
2.4.13-pre3aa1-page-cluster=2	
Elapsed (wall clock) time:          47.878

Averages for 10 mtest01 runs
bytes allocated:                    1233859379
User time (seconds):                2.034
System time (seconds):              3.036
Elapsed (wall clock) time:          30.517
Percent of CPU this job got:        16.10
Major (requiring I/O) page faults:  107.0
Minor (reclaiming a frame) faults:  302029.3

2.4.13-ac3

Played about 90 seconds of mp3 during 200 second run.
747634688 - 1181745152 bytes allocated per iteration.  

Averages for 10 mtest01 runs
bytes allocated:                    894120755
User time (seconds):                1.499
System time (seconds):              2.744
Elapsed (wall clock) time:          20.646
Percent of CPU this job got:        20.40
Major (requiring I/O) page faults:  101.9
Minor (reclaiming a frame) faults:  218898.0


2.4.13-ac3-freeswap

Played about 120 seconds of mp3 during 350 second run.

Averages for 10 mtest01 runs
bytes allocated:                    1244449996
User time (seconds):                2.033
System time (seconds):              3.761
Elapsed (wall clock) time:          35.219
Percent of CPU this job got:        16.00
Major (requiring I/O) page faults:  114.1
Minor (reclaiming a frame) faults:  304611.1


mmap001 test
============

2.4.14-pre3

mp3 did not skip.

Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.578
System time (seconds):              17.388
Elapsed (wall clock seconds) time:  171.45
Percent of CPU this job got:        21.20
Major (requiring I/O) page faults:  500158.8
Minor (reclaiming a frame) faults:  41.4

About 2-3 seconds of mp3 skip for entire run.

2.4.13-ac3
Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.412
System time (seconds):              16.974
Elapsed (wall clock seconds) time:  151.49
Percent of CPU this job got:        23.40
Major (requiring I/O) page faults:  500180.2
Minor (reclaiming a frame) faults:  20.0

About 2-3 seconds of mp3 skip for entire run.

2.4.13-ac3-freeswap
Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.260
System time (seconds):              17.456
Elapsed (wall clock seconds) time:  151.44
Percent of CPU this job got:        23.80
Major (requiring I/O) page faults:  500174.0
Minor (reclaiming a frame) faults:  20.0

runalltests.sh
==============

When executing runalltests.sh from LTP, 2.4.14-pre3 returns
FAIL on the personality01 tests (11 FAIL) whereas 2.4.13-ac3
returns PASS on the same tests.

-- 
Randy Hron


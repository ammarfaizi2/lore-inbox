Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274530AbRJAEDW>; Mon, 1 Oct 2001 00:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274533AbRJAEDN>; Mon, 1 Oct 2001 00:03:13 -0400
Received: from robin.mail.pas.earthlink.net ([207.217.120.65]:444 "EHLO
	robin.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S274530AbRJAECz>; Mon, 1 Oct 2001 00:02:55 -0400
From: rwhron@earthlink.net
Date: Mon, 1 Oct 2001 00:05:04 -0400
To: linux-kernel@vger.kernel.org
Subject: [LTP] summary of results on laptop with recent kernels
Message-ID: <20011001000504.A19527@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Test Suite 20010801
2.4.9-ac9   1 run completed without incident
2.4.9-ac10  1 run completed without incident
2.4.9-ac14  1 run completed without incident
2.4.10      1 run terminated with:

cmdline="growfiles -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -T 10 -l -S 2 -f Lgf04_"
contacts=""
analysis=exit
initiation_status="ok"
<<<test_output>>>
growfiles: 307 growfiles.c/1899: 45548 tlibio.c/698 write(3, buf, 1) ret:-1, errno=12 Cannot allocate memory
growfiles: 307 growfiles.c/1899: 45579 tlibio.c/698 write(3, buf, 1) ret:-1, errno=12 Cannot allocate memory
growfiles: 307 growfiles.c/1899: 45653 tlibio.c/698 write(3, buf, 1) ret:-1, errno=12 Cannot allocate memory
growfiles: 307 growfiles.c/1899: 45755 tlibio.c/904 writev(3, iov, 1) nbyte:1 ret:-1, errno=12 Cannot allocate memory
<<<execution_status>>>
duration=-1001273674 termination_type=signaled termination_id=9 corefile=no
cutime=865 cstime=5457
<<<test_end>>>
growfiles: 316 growfiles.c/2085: 191 tlibio.c/706 write(3, buf, 5000) returned=4096
./runalltests.sh: line 14:   122 Killed                  ${LTPROOT}/pan/pan -e -S -a $$ -n $$ -f ${TMP}/alltests
pan reported FAIL

Test Suite 20010925
2.4.9-ac10  2 runs completed without incident
2.4.9-ac17  3 runs completed without incident
2.4.10-ac1  2 runs completed without incident
2.4.11-pre1 1 run completed without incident


Hardware:

Toshiba Tecra 8000
192 Megs RAM
6 Gb IDE disk

Filesystem:	ext3
Distro: Linux From Scratch 3.0

Additional notes:

All runs on 20010801 ltp had 1 FAIL from a ulimit testcase.  
This is a known test/glibc issue.  The testcase was dropped
from the suite in 20010925.

All runs on 20010925 ltp have 34 FAIL tests. The new suite has
over 400 new test cases.

Interactive response during brutal I/O is much slower for processes
like starting vi, "su", "ps aux".  Switching screens is always
fast and keyboard response is good.

Another system where I've run the test suites more frequently
occasionally has a kernel oops.  The console also displays messages
like:

journal-1577: handle trans id 371103 != current trans id 371104

That system runs reiserfs.  These messages during ltp began 
occuring about 2 weeks ago.

-- 
Randy Hron
= Linux - because it's all about freedom =
Linux News at http://lwn.net/


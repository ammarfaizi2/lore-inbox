Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276901AbRJCHnZ>; Wed, 3 Oct 2001 03:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276902AbRJCHnQ>; Wed, 3 Oct 2001 03:43:16 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.121.50]:57274 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S276901AbRJCHm7>; Wed, 3 Oct 2001 03:42:59 -0400
Date: Wed, 3 Oct 2001 03:44:51 -0400
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: ltp on 2.4.11-pre2 and 2.4.10-ac4 (athlon on ext2)
Message-ID: <20011003034451.A2596@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux Test Project suite on 2.4.11-pre2 and 2.4.10-ac4.  

This isn't a duplicate.  This machine recently had reiserfs errors 
during LTP.  Here are tests with ext2.  (I'm re-running ltp on reiserfs too)

Kernel versions: 	2.4.10-ac4 and 2.4.11-pre2
kernel .config:		identical
Filesystem:		ext2
Distro: 		Linux From Scratch 3.0
glibc:			2.2.4
LTP version:		20010925

Hardware:
AMD Athlon 1333 mhz
IWill KK266 motherboard
512 megs RAM
1024 megs swap

Test process:
boot kernel
login 3 console ttys
run "vmstat 8 >logfile" and tail it
run "for" loop to repeat LTP 3 times and log results
tail -f LTP results files
light use of links and irc clients.
no X.

There was a PASS for 10670 to 10676 tests.


LTP isn't a benchmark,  but here are some growfile i/o results:

Linux rushmore 2.4.10-ac4    941824 iterations on 41 files in 760 seconds
Linux rushmore 2.4.10-ac4    939209 iterations on 41 files in 760 seconds
Linux rushmore 2.4.10-ac4    932649 iterations on 41 files in 760 seconds

Linux rushmore 2.4.11-pre2   914028 iterations on 41 files in 760 seconds
Linux rushmore 2.4.11-pre2   920055 iterations on 41 files in 760 seconds
Linux rushmore 2.4.11-pre2   924409 iterations on 41 files in 760 seconds

All growfiles commands completed successfully!


Unique test PASS

1st 2.4.11-pre2 run
recv01      3  PASS  :  invalid recv buffer successful

Unique test failures

1st 2.4.10-ac4
nanosleep02    1  FAIL  :  Child execution not suspended for 5 seconds
nanosleep02    1  FAIL  :  child process exited abnormally



vmstat steady state after the three runs:

2.4.10-ac4

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0 266620  68132 157876  11848   0   0     0     0  104    71   0   0 100

2.4.11-pre2

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0  12808 483932   2188  14368   1   0     1     0  103    71   0   0 100


That is a snippet from the logfile after 3 runs completed.  It is not 
the result of a single iteration of "vmstat".




Here are some earlier results that were not using the same .config file.
In these tests I was playing mp3's, running top, ps, etc watching what
the tests do.  These were all with reiserfs.

Linux rushmore 2.4.9-ac10 756999 iterations on 41 files in 760 seconds
Linux rushmore 2.4.9-ac10 903693 iterations on 41 files in 760 seconds
Linux rushmore 2.4.9-ac10 910502 iterations on 41 files in 760 seconds
Linux rushmore 2.4.9-ac17 728331 iterations on 41 files in 760 seconds
Linux rushmore 2.4.9-ac17 899508 iterations on 41 files in 760 seconds
Linux rushmore 2.4.9-ac17 903786 iterations on 41 files in 760 seconds
Linux rushmore 2.4.9-ac17 908911 iterations on 41 files in 760 seconds
Linux rushmore 2.4.9-ac17 914780 iterations on 41 files in 760 seconds
Linux rushmore 2.4.9-ac18 907163 iterations on 41 files in 760 seconds

-- 
Randy Hron
Linux News at http://lwn.net/
-- 
Randy Hron
= Linux - because it's all about freedom =
Linux News at http://lwn.net/


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262930AbUKXX0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbUKXX0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbUKXXYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:24:33 -0500
Received: from smtp.wp.pl ([212.77.101.160]:13114 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S262943AbUKXXPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:15:51 -0500
Subject: MTRR vesafb and wrong X performance
From: Pawel Fengler <pawfen@wp.pl>
Reply-To: pawfen@wp.pl
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 25 Nov 2004 00:15:39 +0100
Message-Id: <1101338139.1780.9.camel@PC3.dom.pl>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92-1mdk 
Content-Transfer-Encoding: 7bit
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO AS1=NO(Body=1 Fuz1=1 Fuz2=1) AS2=NO(0.603999) AS3=NO AS4=NO                          
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Sirs,

Recenly, I test five big distributions with almost all kernels
from 2.4.21 to 2.6.9 on several slow computers with many different
(not quite new) graphics cards (most of them - nvidia: Riva TNT,
GeForce, GeForce2 and S3Savage).
I observe very wrong Xserver performance on each of kernel 2.6.x
and good performance on every 2.4.x kernel when computer boot
with vesafb
For example, when I try mplayer or xine - CPU utilization
by X process is 30 times larger on 2.6.x kernel then 2.4.x

==> top_2.4.27-0.pre2.1mdk <==
top - 14:27:50 up 7 min,  1 user,  load average: 0.67, 0.25, 0.11
Tasks:  45 total,   3 running,  42 sleeping,   0 stopped,   0 zombie
Cpu(s):  27.4% user,   1.5% system,   0.0% nice,  71.1% idle
Mem:    190780k total,   106124k used,    84656k free,     5864k buffers
Swap:   626452k total,        0k used,   626452k free,    63480k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 1549 pf        25   0 16684  16m  12m R 26.4  8.7   0:16.00 mplayer
 1398 root      25   0 42620 9596 3028 S  0.3  5.0   0:03.33 X
 1561 pf        25   0 13032  12m  12m R  0.3  6.8   0:00.18 mplayer

==> top_2.6.8.1-12mdk <==
top - 20:41:33 up 13 min,  1 user,  load average: 0.93, 0.35, 0.21
Tasks:  48 total,   2 running,  46 sleeping,   0 stopped,   0 zombie
Cpu(s): 61.7% us,  3.5% sy,  0.0% ni, 34.5% id,  0.0% wa,  0.1% hi,
0.0% si
Mem:    191608k total,   113028k used,    78580k free,     6064k buffers
Swap:   626452k total,        0k used,   626452k free,    66712k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 3841 pf        15   0 34320  16m  27m S 36.2  8.7   0:21.94 mplayer
 3655 root      16   0 44448 9708  36m R 26.0  5.1   0:17.99 X
 3715 pf        15   0  3224 1768 2764 S  0.8  0.9   0:00.82 rxvt.bin
 3842 pf        15   0 29932  12m  27m S  0.5  6.8   0:00.28 mplayer

Every time when I use 2.6.x kernel I get warnigs (in xorg.log) similar
this:
(WW) NV(0): Failed to set up write-combining range
(0xe3000000,0x1000000)

When I use boot option "video=vesafb:nomtrr" with any 2.6.x kernel,
Xserver performance is nearly as good as under 2.4.x kernel
and warning (in xorg.log) does not appear.

It seems to be a problem with mtrr and vesafb described several times,
for example Jan 18, 2004 in thread "Overlapping MTRRs in 2.6.1"
but it was a long time ago.

My questions are simple:
1. The problem is because of a kernel bug or because of kernel feature?
2. Is this the same problem all the time not resolved yet
   or I found several different kernel bugs (with the same symptoms)?
   I did not test 2.6.0, 2.6.2 and 2.6.5 kernel yet:-)

Inspite of this problem is not as important as for example kernel panic
I am sure because of it many of trivial users think linux is slowly :-)

Pawel Fengler

P.S.
Sorry for my English. It is not as perfect as I wish it to be.

--




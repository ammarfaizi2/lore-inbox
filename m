Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130779AbRCTVCh>; Tue, 20 Mar 2001 16:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130791AbRCTVC2>; Tue, 20 Mar 2001 16:02:28 -0500
Received: from brauhaus.paderlinx.de ([194.122.103.4]:3778 "EHLO
	imail.paderlinx.de") by vger.kernel.org with ESMTP
	id <S130779AbRCTVCR>; Tue, 20 Mar 2001 16:02:17 -0500
Date: Tue, 20 Mar 2001 22:01:21 +0100 (MET)
From: Matthias Schniedermeyer <ms@citd.de>
To: linux-kernel@vger.kernel.org
Subject: Memory leak in 2.4.2 (+loop-6-patch)???
Message-ID: <Pine.LNX.4.20.0103202155030.3879-100000@citd.owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#Include <hallo.h>


After some days of uptime, i just stopped (nearly) all programs, unmounted
all unnecessary devices.

But top & free say that 1/3 of my RAM is still "used"


Here is what top means:

(Swap is 0K because i don't use Swap at all. Should i use swap?)

  9:54pm  up 11 days, 23 min,  4 users,  load average: 0.00, 0.22, 0.52
30 processes: 29 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:  0.1% user,  0.0% system,  0.0% nice, 99.4% idle
CPU1 states:  0.0% user,  0.2% system,  0.0% nice, 99.3% idle
Mem:  1028648K av,  334624K used,  694024K free,       0K shrd,    3556K buff
Swap:       0K av,       0K used,       0K free                   55136K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    1 root       4   0   100  100    60 S     0.0  0.0   0:17 init
    2 root       9   0     0    0     0 SW    0.0  0.0   0:00 keventd
    3 root       9   0     0    0     0 SW    0.0  0.0   0:53 kswapd
    4 root       9   0     0    0     0 SW    0.0  0.0   0:00 kreclaimd
    5 root       9   0     0    0     0 SW    0.0  0.0   6:21 bdflush
    6 root       9   0     0    0     0 SW    0.0  0.0   0:34 kupdate
    7 root       9   0     0    0     0 SW    0.0  0.0   0:00 khubd
  294 root       8   0   164  164    72 S     0.0  0.0   0:01 cron
  373 root       9   0   508  508   144 S     0.0  0.0   0:00 login
  374 root       9   0   508  508   144 S     0.0  0.0   0:00 login
  375 root       9   0   508  508   144 S     0.0  0.0   0:00 login
  380 root       9   0    84   84     0 S     0.0  0.0   0:00 mingetty
  385 root       9   0   508  508   144 S     0.0  0.0   0:00 login
  386 root       9   0    84   84     0 S     0.0  0.0   0:00 mingetty
  389 ms         8   0  1072 1072   736 S     0.0  0.1   0:00 bash
  396 root       0   0  1264 1264   896 S     0.0  0.1   0:01 bash
  404 root      11   0  1132 1132   732 S     0.0  0.1   0:01 bash
  463 citd       8   0  1192 1192   852 S     0.0  0.1   0:00 bash
 6520 root       9   0   612  612   524 S     0.0  0.0   0:00 mingetty
 6521 root       9   0   612  612   524 S     0.0  0.0   0:00 mingetty
 6522 root       9   0   612  612   524 S     0.0  0.0   0:00 mingetty
 6523 root       9   0   612  612   524 S     0.0  0.0   0:00 mingetty
 6524 root       9   0   612  612   524 S     0.0  0.0   0:00 mingetty
 6525 root       9   0   612  612   524 S     0.0  0.0   0:00 mingetty
 6526 root       9   0   612  612   524 S     0.0  0.0   0:00 mingetty
 6527 root       9   0   612  612   524 S     0.0  0.0   0:00 mingetty
 6528 root       9   0   612  612   524 S     0.0  0.0   0:00 mingetty
 6529 root       9   0   612  612   524 S     0.0  0.0   0:00 mingetty
 6652 root      12   0  1008 1008   804 R     0.0  0.0   0:00 top
 6663 root      17   0   544  544   468 S     0.0  0.0   0:00 gpm

uname -a
Linux leeloo 2.4.2 #18 SMP Fri Feb 23 19:31:03 CET 2001 i686 unknown

gcc --version
2.95.2






Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.



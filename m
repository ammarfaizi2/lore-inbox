Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTH0LG7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 07:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263327AbTH0LG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 07:06:59 -0400
Received: from webmail2.vsnl.net ([203.197.12.44]:17120 "EHLO bom6.vsnl.net.in")
	by vger.kernel.org with ESMTP id S263277AbTH0LG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 07:06:58 -0400
Date: Wed, 27 Aug 2003 16:38:44 -0500 (GMT)
Message-Id: <200308272138.h7RLciK29987@webmail2.vsnl.net>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)
From: warudkar@vsnl.net
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test4-mm1 - kswap hogs cpu OO takes ages to start!
X-Mailer: VSNL, Web based email
X-Sender-Ip: 203.197.141.34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying out 2.6.0-test4-mm1. Inside KDE, I start OpenOffice.org, Rational Rose and Konsole at a time. All of these take extremely long time to startup. (approx > 5 minutes). Kswapd hogs the CPU all the time.
X becomes unusable till all of them startup, although I can telnet and run top.
Same thing run under 2.4.18 starts up in 3 minutes, X stays usable and kswapd never take more than 2% CPU.


Here a snapshot of Top output when running 2.6.0-test4-mm1:
==============================
  4:24pm  up 21:19,  6 users,  load average: 3.47, 2.04, 1.49
96 processes: 88 sleeping, 8 running, 0 zombie, 0 stopped
CPU states: 11.3% user, 88.6% system,  0.0% nice,  0.0% idle
Mem:   124632K av,  122664K used,    1968K free,       0K shrd,     160K buff
Swap: 1052248K av,   71256K used,  980992K free                   43540K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    8 root      15   0     0    0     0 SW   66.6  0.0   4:59 kswapd0
 2087 wipro     17   0 29576  10M 27408 S     4.6  8.9   0:03 kdeinit
 2044 wipro     17   0  118M  22M  103M D     2.7 18.8   0:04 soffice.bin
 2292 wipro     18   0  3856  912  3716 S     1.8  0.7   0:02 top
 2312 wipro     18   0  3852  912  3716 R     1.8  0.7   0:00 top
  540 wipro     15   0 28988 6640 26672 S     0.9  5.3  10:40 kdeinit
 1254 wipro     15   0 26340 4916 24716 S     0.9  3.9   0:17 kdeinit
    1 root      17   0  1320  268  1288 S     0.0  0.2   0:04 init
    2 root      0K   0     0    0     0 SW    0.0  0.0   0:00 migration/0
    3 root      34  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd/0
    4 root       5 -10     0    0     0 SW<   0.0  0.0   0:00 events/0
    5 root       5 -10     0    0     0 SW<   0.0  0.0   0:01 kblockd/0
    6 root      15   0     0    0     0 SW    0.0  0.0   0:00 pdflush
    7 root      15   0     0    0     0 SW    0.0  0.0   0:00 pdflush
    9 root      10 -10     0    0     0 SW<   0.0  0.0   0:00 aio/0
   10 root      10 -10     0    0     0 SW<   0.0  0.0   0:00 aio_fput/0
   11 root      15   0     0    0     0 SW    0.0  0.0   0:00 kseriod
   12 root      15   0     0    0     0 SW    0.0  0.0   0:00 kjournald

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272576AbRIXVbr>; Mon, 24 Sep 2001 17:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272661AbRIXVba>; Mon, 24 Sep 2001 17:31:30 -0400
Received: from NET.WAU.NL ([137.224.10.12]:51983 "EHLO net.wau.nl")
	by vger.kernel.org with ESMTP id <S272576AbRIXVbN>;
	Mon, 24 Sep 2001 17:31:13 -0400
Date: Mon, 24 Sep 2001 23:31:39 +0200
From: Olivier Sessink <olivier@lx.student.wau.nl>
Subject: weird memory related problems,
 negative memory usage or fake memory usage?
To: linux-kernel@vger.kernel.org
Message-id: <20010924233139.A14548@fender.fakenet>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
X-MSMail-priority: High
User-Agent: Mutt/1.2.5i
X-System-Uptime: 11:18pm  up 43 days,  1:39,  1 user,  load average: 0.09,
 0.05, 0.01
X-Reverse-Engineered: High priority for sending SMS messages
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

after upgrade from 2.4.10pre8 to 2.4.10 I have weird problems, Xfree
sometimes shows up with 99.9% memory in top (on a box with 512 mb), and in
ps axl it has 4294989036 in the RSS column. When this happens the box starts
to kill some processes, starts heavily swapping (top reports > 400MB in the
cache, but the machine is heavily swapping!!!) and is completely unusable.

The problems is triggered when I start edonkey, some filesharing program
that creates checksums of large files (a couple of > 700Mb files).

Since this makes the machine completely unusable, and since it is not
happening on 2.4.10pre8 I guess it is a bug ;-)

This is a top snapshot:

46 processes: 43 sleeping, 3 running, 0 zombie, 0 stopped
CPU states:   3.8% user,   1.2% system,  94.6% nice,   0.4% idle
Mem:    514032K total,   511436K used,     2596K free,     1244K buffers
Swap:   358808K total,    10928K used,   347880K free,   466072K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  253 olivier   19  18   300  196   124 R N  52.9  0.0 119:50 dnetc
 1274 root      14   0  5940 5940   872 R    33.7  1.1   0:00 xsetbg
 1262 root       5 -10 50764  -1M  1320 S <   2.7 99.9   0:01 XFree86
 1263 root       9   0  1528 1492  1204 S     2.7  0.2   0:00 xdm
 1267 root      11   0   980  976   776 R     2.7  0.1   0:00 top
 1270 root       9   0  1016 1012   820 S     0.9  0.1   0:00 Xsetup_0
    1 root       8   0   104   56    36 S     0.0  0.0   0:04 init
    2 root       9   0     0    0     0 SW    0.0  0.0   0:00 keventd
    3 root       9   0     0    0     0 SW    0.0  0.0   0:00 kapm-idled
    4 root      19  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU0
    5 root       9   0     0    0     0 SW    0.0  0.0   0:01 kswapd
    6 root       9   0     0    0     0 SW    0.0  0.0   0:00 bdflush
    7 root       9   0     0    0     0 SW    0.0  0.0   0:00 kupdated
    8 root       9   0     0    0     0 SW    0.0  0.0   0:00 kreiserfsd

the ps axl for X then is

100     0  1262  1260   5 -10 52408 4294965424 select S< ?      0:01
/usr/X11R6/bin/X vt7 -dpi 100 -nolisten tcp -auth /var/lib/xdm/authdir

regards,
	Olivier

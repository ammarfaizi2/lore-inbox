Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277686AbRJIB7N>; Mon, 8 Oct 2001 21:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277693AbRJIB7D>; Mon, 8 Oct 2001 21:59:03 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:19626 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S277686AbRJIB6w>; Mon, 8 Oct 2001 21:58:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: kswapd problems with 2.4.{9,10}
Date: Tue, 9 Oct 2001 03:59:16 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011009015901Z277686-760+22367@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Andrea,

could this mlock related, too?
latencytest0.42-png

SunWave1>./latencytest
mlockall() failed, exiting. mlock: Operation not permitted

SunWave1>su
Password:

SunWave1#unlimit coredumpsize
SunWave1#./latencytest
Speicherschutzverletzung (core dumped)

Loaded symbols for /usr/X11R6/lib/libXpm.so.4
Reading symbols from /lib/ld-linux.so.2...done.
Loaded symbols for /lib/ld-linux.so.2
#0  0x8048f91 in main (argc=1, argv=0xbffff344) at latencytest.c:233
233       if(strcmp(argv[1],"none"))
(gdb) bt
#0  0x8048f91 in main (argc=1, argv=0xbffff344) at latencytest.c:233
#1  0x400c1baf in __libc_start_main () from /lib/libc.so.6
(gdb) info registers
eax            0x0      0
ecx            0x5      5
edx            0xf7f    3967
ebx            0x1      1
esp            0xbffff224       0xbffff224
ebp            0xbffff2dc       0xbffff2dc
esi            0x0      0
edi            0x804a761        134522721
eip            0x8048f91        0x8048f91
eflags         0x10246  66118
cs             0x23     35
ss             0x2b     43
ds             0x2b     43
es             0x2b     43
fs             0x2b     43
gs             0x2b     43
fctrl          0x37f    895
fstat          0x0      0
ftag           0x0      0
fiseg          0x0      0
fioff          0x0      0
foseg          0x0      0
fooff          0x0      0
fop            0x0      0

It worked with 2.4.10 (-preX) and 2.4.11-pre1 (I think).
But _NOT_ with 2.4.11-pre2+ (2.4.11-pre5 + preempt :-) currently.

Do you need the coredump file?

Thanks,
	Dieter

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268123AbSIRUZr>; Wed, 18 Sep 2002 16:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268129AbSIRUZr>; Wed, 18 Sep 2002 16:25:47 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:43689 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S268123AbSIRUZq> convert rfc822-to-8bit; Wed, 18 Sep 2002 16:25:46 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: maybe [BUG] 2.5.36 vanilla DRM/XFree issue
Date: Wed, 18 Sep 2002 22:29:49 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209182213.51985.m.c.p@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I've noticed, since 2.5.34 (earlier versions down to 2.5.25 didn't boot for 
me), if I want to start X (XFree 4.2.0) and the "r128" module is _not_ loaded 
and the kernel module loader wants to load it, X don't start up, just a 
blank screen and X process uses 100% cpu time. Manually "kill -9" the X stuff 
gives me my terminal back. Again starting X gives the same behaviour. After 
that all, "modprobe r128", starting X again, all works fine.

I really don't have a clue where to debug what wents wrong. Anything I can do 
to provide more detail?

System:
-------
- Celeron 800MHz
- 256 MB RAM
- 60GB IDE hd
- ATI All-In-Wonder 128pro (Rage128 Chipset)

   same with vga=normal and no ati128fb support in the kernel and also with
   applying ati128fb patches and having console framebuffer with
   video=aty128fb:accel,1024x768-8@75

- XFree 4.2.0
- modutils 2.4.19
    /etc/modutils/aliases has: "alias char-major-226 r128" which is the first
    dri card (0)

works as expected with 2.4 kernel tree.

the XFree86.X.log file does not give any usefull things (for me).

Just stopping here:
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Reloading /usr/X11R6/lib/modules/libddc.a
(II) R128(0): VESA VBE DDC supported
(II) R128(0): VESA VBE DDC Level none
(II) R128(0): VESA VBE DDC transfer in appr. 2 sec.

and for now uses 100% cpu time.

normally there should come up this after the above:

(==) R128(0): Using gamma correction (1.0, 1.0, 1.0)
(II) R128(0): NEC MultiSync FP1370: Using hsync range of 31.00-65.00 kHz
(II) R128(0): NEC MultiSync FP1370: Using vrefresh range of 55.00-80.00 Hz
(II) R128(0): Clock range:  12.50 to 250.00 MHz
....

Please give me some hints what can be helpfull to debug it and I'll do so :)
I think this a 2.5.xx kernel issue or am I wrong?

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbTCAOEa>; Sat, 1 Mar 2003 09:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268548AbTCAOEa>; Sat, 1 Mar 2003 09:04:30 -0500
Received: from science.horizon.com ([192.35.100.1]:34609 "HELO
	science.horizon.com") by vger.kernel.org with SMTP
	id <S265863AbTCAOE1>; Sat, 1 Mar 2003 09:04:27 -0500
Date: 1 Mar 2003 14:14:45 -0000
Message-ID: <20030301141445.12130.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Playing with 2.5.63: APM blanking and "bio too big"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've decided that things appear to have settled down enough to try using
2.5 on my personal "real work" machines.  I generally used development
kernels (1.1, 1.3, 2.1, 2.3) on my personal machines, but early 2.5 was
causing so much disk corruption that I got scared off.

Anyway, a few early observations about the 2.4.20 -> 2.5.63 jump.

* It feels quite peppy!  Disk-intensive operations don't mess up interactive
  response nearly as much as they do in 2.4.

* I'm having some trouble with mouse double-clicks not being recognized
  in X (PS/2 -> /dev/input/mice -> gpm -Rraw -> Xfree86), but I haven't
  chased it enough to blame the kernel yet.

* I had real problems with APM screen blanking enabled.  It reliably
  and repeatedly locked the machine HARD (no keyboard, no SysRq, no ping)
  when the scren blanker kicked in or trying to switch from X.  This is
  an Athlon on a KT133 Motherboard.  No problems in 2.4.  APM can corectly
  power the machine off, however.

* And finally, should I be worried about the following messages?
  Nothing *seems* to be dying horribly, but discussion last December talked
  about corruption and seemed to treat this message as a serious bug in 2.5.50.

bio too big device ide0(3,4) (256 > 255)
bio too big device ide1(22,4) (256 > 255)
bio too big device ide0(3,4) (424 > 255)
bio too big device ide0(3,4) (272 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (512 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (512 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (512 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (512 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (512 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (512 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (512 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (512 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (512 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (328 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (488 > 255)
bio too big device ide1(22,4) (424 > 255)
bio too big device ide0(3,4) (288 > 255)
bio too big device ide0(3,4) (456 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (256 > 255)
bio too big device ide1(22,4) (296 > 255)
bio too big device ide0(3,4) (512 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (376 > 255)
bio too big device ide1(22,4) (336 > 255)
bio too big device ide0(3,4) (384 > 255)
bio too big device ide0(3,4) (512 > 255)
bio too big device ide0(3,4) (376 > 255)
bio too big device ide0(3,4) (272 > 255)
bio too big device ide1(22,4) (344 > 255)
bio too big device ide0(3,4) (424 > 255)
bio too big device ide0(3,4) (272 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (512 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (512 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide1(22,4) (256 > 255)
bio too big device ide0(3,4) (424 > 255)
bio too big device ide0(3,4) (272 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (360 > 255)
bio too big device ide0(3,4) (424 > 255)
bio too big device ide0(3,4) (272 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (360 > 255)
bio too big device ide1(22,4) (456 > 255)
bio too big device ide0(3,4) (424 > 255)
bio too big device ide0(3,4) (272 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (360 > 255)
bio too big device ide0(3,4) (424 > 255)
bio too big device ide0(3,4) (272 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (360 > 255)
bio too big device ide0(3,4) (424 > 255)
bio too big device ide0(3,4) (272 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (360 > 255)
bio too big device ide1(22,4) (256 > 255)
bio too big device ide1(22,4) (256 > 255)
bio too big device ide0(3,4) (424 > 255)
bio too big device ide0(3,4) (272 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (360 > 255)
bio too big device ide1(22,4) (256 > 255)
bio too big device ide0(3,4) (424 > 255)
bio too big device ide0(3,4) (272 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (360 > 255)
bio too big device ide0(3,4) (256 > 255)
bio too big device ide0(3,4) (256 > 255)
bio too big device ide0(3,4) (424 > 255)
bio too big device ide0(3,4) (272 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (360 > 255)
bio too big device ide0(3,4) (424 > 255)
bio too big device ide0(3,4) (272 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (360 > 255)
bio too big device ide0(3,4) (424 > 255)
bio too big device ide0(3,4) (272 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (360 > 255)
bio too big device ide0(3,4) (424 > 255)
bio too big device ide0(3,4) (272 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (512 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (512 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (512 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (512 > 255)
bio too big device ide1(22,4) (512 > 255)
bio too big device ide0(3,4) (512 > 255)

There's a 2-way RAID0 with 256K stripe size, which might have something
to do with the popularity of the number 512.


Thanks for all the hard work and great code!

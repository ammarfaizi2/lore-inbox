Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbTIOXvA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 19:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbTIOXu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 19:50:59 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:56261 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id S261741AbTIOXtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 19:49:31 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200309152346.h8FNklAf015884@wildsau.idv.uni.linz.at>
Subject: sig11 is back: old troubles with new hardware
To: linux-kernel@vger.kernel.org
Date: Tue, 16 Sep 2003 01:46:47 +0200 (MET DST)
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

word of warning: this is more hardware-related, and not much kernel-related. however,
I think this article could probably be helpful to others (and to me ;-) ???

some of you surely remember sig11 when compiling kernels? I feel uncomfortably reminded
of the "old days". sig11 is back :-( but first to some "kernel panics"...

recently, I bought a new machine:

board: asus a7n8x deluxe (the non-deluxe doesnt have fireware).
       the board has 3 memory slots.
       this thing has an nfroce chipset (is that bad?)
cpu: amd 2600+
ram: 2x512MB DDRAM@400Mhz

First, I tried to copy my old disk to the new one, so I had to format the
new partion. The annoying thing here was that I saw 7 out of 10 kernel
panics when trying to "mke2fs /dev/hdc3" (a 60Gb partition). I was tempted
to send a report to this list, but then I noticed, that the crash occured
in various places each kernel-panic. One time it was in ide-dma ("kernel bug
in ide-dma line 289), then it was "kernel bug in highmem.c:151", then it was
in an interrupt-handler, another time the register dump looked impossible
(all register values 00000000 ?) and so on. It appeared rather random as to where
it would crash.

Then I exchanged the DDRAM (I had some spare 333Mhz DDRAM home) and suddenly I
didn't have any panics anymore. So I went to the dealer and asked to exchange
the DDRAMs, but it turned out that all of his DDRAMs failed (he buys from one
manufacturer only). So later he exchanged them to 400Mhz DDRAMs, which *seemed*
to work. However, back at home, the 2nd or 3rd "mke2fs /dev/hdc3" resulted in
a "kernel panic" again. I experimented with the hardware.... and noticed, that,
when setting the speed for the DDRAM to 333 instead of 400, it wouldn't crash.
Then I began wondering what "Single channel mode" means when the computer
boots....and, thanks to a friend on irc, plugged one piece DDRAM into the 3rd
slot, leaving the 2nd slot unplugged. so, I have 512MB in slot1, slot2 is empty,
and the other 512MB in slot3. now, when booting, the machine said
"Dual channel mode" and now even at 400Mhz memory frequency, I saw no kernel-panics
anymore ... or so I thought! (ha!)

For one, does anyone know why I get this panics (which are result of hardware
problems, and not kernel-problems, of course) when in "single channel mode"?

Next, I tried some stress-testing: I did "cp /mnt/RedHat/RH73/valhal*iso ~/temp" about
20 times. /mnt is another hd, not the cdrom. So, the system started copying all these
iso-images ... first image, 2nd image, 3rd image and so on ... it looked pretty okay, but
then again after about ... 10 times copying(?), *booouum* ... kernel panic.


I also wanted to check out the speed of the machine. Most of the time it was
pretty okay, but then ... I got something like "cpp pipe has closed unexpectedly,
gcc got signal11". "Oh no!", I screamed out in thought, "NOT AGAIN! This has last
happened 1995 !"

Of course, this is defintely a hardware-bug. But I wonder what to do about it.
to sum it up:

some 333Mhz DDRAM give kernel panics when operating at 333Mhz.
some 400Mhz DDRAM give lot of kernel panics when operating at 400Mhz in "single channel mode"
some 400Mhz DDRAM give few kernel panics when operating at 400Mhz in "dual channel mode"
the same 400Mhz DDRAM (seems!!) works well when operated at 333Mhz, but then, why
should I buy a expensive 400Mhz DDRAM when I can use it only at 333Mhz.
(I know that this are not all combinations)

what do you think, where is the problem? I doubt that all the RAMs I have tried
are broken. To me, the next suspect is the board.... it seems that the number
of panics increase when the DRAMS are in slot 1 & 2 (single channel mode).
I havent tried if the 400Mhz DDRAM@333Mhz causes crashes in "single channel mode".

well.
I'm curious...do any of you experience problems of that kind with the
nforce chip or the asus a7n8x board?

best regards,
h.rosmanith



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130359AbRAZHXQ>; Fri, 26 Jan 2001 02:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130569AbRAZHXG>; Fri, 26 Jan 2001 02:23:06 -0500
Received: from mdmgrp3-150.accesstoledo.net ([207.43.108.150]:34820 "EHLO
	rosswinds.net") by vger.kernel.org with ESMTP id <S130359AbRAZHW6>;
	Fri, 26 Jan 2001 02:22:58 -0500
Date: Fri, 26 Jan 2001 02:34:20 -0500 (EST)
From: "Michael B. Trausch" <fd0man@crosswinds.net>
To: linux-kernel@vger.kernel.org
cc: Alan Cox <alan@redhat.com>, Zack Brown <zab@redhat.com>
Subject: Possible Bug:  drivers/sound/maestro.c
Message-ID: <Pine.LNX.4.21.0101260220430.11818-100000@fd0man.accesstoledo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I've been using this driver and this hardware since I started running
Kernel 2.2.16.  It _works_, however, whenever I have a program that I
compile that's especially large (the kernel, glibc, etc.), or copy/move
lots of files around, the driver starts to fuzz lots of the sound going to
the card - even after the activity causing the load has stopped.  It
happens in both the left and the right channel, and the only way to
resolve it is to kill the process with /dev/dsp open (typically mpg123),
and then start it again.

I attempted to see if I could get into it and maybe fix it and try things
out myself, however, I got into the driver file and *wow*.  I only know a
little bit of C, and I've never messed with anything that's not an
application program (I was attempting to write an OS for quite some time,
but I gave up... Intel is just too freakin' hard to write for, and I don't
have the money for anything else).

As it sits, I could not even start to make changes, I didn't understand
anything in the file, as to what it was or whatnot.  Otherwise, I'd have
attempted and maybe been successful enough to put a patch in to the list.

I don't know if anyone else here runs with that card, or whatnot.  This
one is brand new, it's PCI ID is as follows, from /proc/pci:

  Bus  0, device  10, function  0:
    Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 16).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=24.
      I/O at 0xec00 [0xecff].

I would be happy to place it in a static bag and small box if anyone cared
to work on it, if someone wanted to borrow it to write for it.  It is my
only sound board right now, I used to have an SB16 (ISA) but I couldn't
use that becuase my video board (ATI, see below) would make weird noises
on it whenever the display had major things going on in X.

Bus  1, device   0, function  0:
  VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X (rev 92).
    Master Capable.  Latency=64.  Min Gnt=8.
    Non-prefetchable 32 bit memory at 0xe0000000 [0xe0ffffff].
    I/O at 0xc000 [0xc0ff].
    Non-prefetchable 32 bit memory at 0xe2000000 [0xe2000fff].

Thank you much!

	- Mike

===========================================================================
Michael B. Trausch                                    fd0man@crosswinds.net
Avid Linux User since April, '96!                           AIM:  ML100Smkr

              Contactable via IRC (DALNet) or AIM as ML100Smkr
===========================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

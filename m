Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAUVHs>; Sun, 21 Jan 2001 16:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbRAUVHi>; Sun, 21 Jan 2001 16:07:38 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:19729 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129401AbRAUVHX>; Sun, 21 Jan 2001 16:07:23 -0500
Date: Sun, 21 Jan 2001 16:07:11 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Urban Widmark <urban@teststation.com>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: more via-rhine problems.
In-Reply-To: <Pine.LNX.4.30.0101211909030.11993-100000@cola.teststation.com>
Message-ID: <Pine.LNX.4.32.0101211602440.7610-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jan 2001, Urban Widmark wrote:

>> I now believe that it is indeed caused by booting to windows 98
>> (by accident).  ;o)
>
>Don't do that then :)

That is a completely sane solution indeed.  ;o)  Unfortunately, I
have to do so occasionally.  Not often thankfully.  ;o)


>> Doesn't matter if a driver is installed in win or not as I've
>> tried both.  Just booting win at all causes the card to go
>> berzerk next boot.  Must be something missing from the card init
>> code that should be resetting something on the card at init time,
>> but which is set by default on power on.
>
>I can't reproduce this, but I only have a 1106:3043 (DFE-530TX revA1) and
>tested this on a rather old P133.

00:07.3 Class 0600: 1106:3050 (rev 30)
        Flags: medium devsel

00:12.0 Class 0200: 1106:3065 (rev 42)
        Subsystem: 1186:1400
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at e800
        Memory at e7000000 (32-bit, non-prefetchable)
        Expansion ROM at e6000000 [disabled]
        Capabilities: [40] Power Management version 2


>I tested 2.2.19pre and not 2.2.18+becker1.08, the biggest difference is
>the detection code so maybe that could be worth trying. 2.4 is again a
>little bit different ...
>
>You could try playing with bios settings. And dumping register contents
>from a working and non-working setup, for example:
>
>% via-diag -aaeemm
>  (ftp://ftp.scyld.com/pub/diag/via-diag.c)

I'll do that if I find time...


>% lspci -vvxxx -d 1106:3065
>
>Maybe CONFIG_PCI_QUIRKS helps?

2 root@asdf:/home/mharris# grep CONFIG_PCI_QUIRKS /boot/K6-2.2.18-1NSRI
CONFIG_PCI_QUIRKS=y

Already there.  ;o)



----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------
VMS is a text-only adventure game. If you win you can use unix.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

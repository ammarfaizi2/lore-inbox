Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131032AbQKRTPe>; Sat, 18 Nov 2000 14:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131058AbQKRTPN>; Sat, 18 Nov 2000 14:15:13 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:5644 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131032AbQKRTPG>; Sat, 18 Nov 2000 14:15:06 -0500
Date: Sat, 18 Nov 2000 10:43:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: adrian <jimbud@lostland.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Markus Schoder <markus_schoder@yahoo.de>
Subject: Re: Freeze on FPU exception with Athlon
In-Reply-To: <Pine.BSO.4.30.0011181332030.1052-100000@getafix.lostland.net>
Message-ID: <Pine.LNX.4.10.10011181039180.919-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Nov 2000, adrian wrote:

> 
> 
> On Sat, 18 Nov 2000, Linus Torvalds wrote:
> 
> > There's almost certainly more than that. I'd love to have a report on my
> > asm-only version, but even so I suspect it also requires the 3dnow stuff,
> 
> I tried all three versions, and no freezes.  I forgot to mention the tests
> were run on a model 2 Athlon (original slot K7, .18 micron).  The kernel
> is compiled with 3dnow support.

Apparently it isn't the stepping, as we have Athlon model 4's both showing
it and not showing it. The motherboard seems to be the only real
difference here, which is why I like the irq13 explanation more and more.

I've been wanting to get rid of irq13 anyway (some boards wire up USB
and/or ACPI to irq13 and the fact that the FPU has claimed it makes those
machines unhappy), so if the solution is to only check for irq13 on old
i386 and i486sx machines and just leave it alone for newer CPU's, I won't
complain.

Markus, can you make the irq13 test the first thing - don't worry about
3dnow as that seems to not be a deciding factor..

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313082AbSDGKnb>; Sun, 7 Apr 2002 06:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313083AbSDGKna>; Sun, 7 Apr 2002 06:43:30 -0400
Received: from mail.sonytel.be ([193.74.243.200]:48118 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S313082AbSDGKna>;
	Sun, 7 Apr 2002 06:43:30 -0400
Date: Sun, 7 Apr 2002 12:42:45 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.8-pre2
In-Reply-To: <20020407112716.A30048@flint.arm.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0204071239310.2567-100000@lisianthus.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Apr 2002, Russell King wrote:
> On Sun, Apr 07, 2002 at 12:17:28PM +0200, Geert Uytterhoeven wrote:
> > Please either add resource management code to anakinfb and clps711xfb,
> > or apply the patch below.
> 
> They're not ISA nor PCI - in fact, they're specific system-on-a-chip
> framebuffers.  I therefore don't see the point of your patch.

Even then, please don't add them to the section marked with the comment
`Chipset specific drivers that use resource management'. My patch just moves
their initialization to the section marked with the comment `Chipset specific
drivers that don't use resource management (yet)'. So it's still valid.

> (Oh, and a bugbear - people go running around adding checks for the
> return value of request_region and friends on embedded devices where
> there can't be the possibility of a clash waste memory needlessly.)

Perhaps you want to modularize the driver later? Resource management also
prevents you from insmoding two drivers for the same hardware.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


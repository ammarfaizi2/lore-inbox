Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312754AbSDGOwY>; Sun, 7 Apr 2002 10:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313332AbSDGOwX>; Sun, 7 Apr 2002 10:52:23 -0400
Received: from mail.sonytel.be ([193.74.243.200]:62093 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S312754AbSDGOwW>;
	Sun, 7 Apr 2002 10:52:22 -0400
Date: Sun, 7 Apr 2002 16:51:33 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.8-pre2
In-Reply-To: <20020407143437.F30048@flint.arm.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0204071648290.2567-100000@lisianthus.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Apr 2002, Russell King wrote:
> On Sun, Apr 07, 2002 at 12:42:45PM +0200, Geert Uytterhoeven wrote:
> > On Sun, 7 Apr 2002, Russell King wrote:
> > > (Oh, and a bugbear - people go running around adding checks for the
> > > return value of request_region and friends on embedded devices where
> > > there can't be the possibility of a clash waste memory needlessly.)
> > 
> > Perhaps you want to modularize the driver later? Resource management also
> > prevents you from insmoding two drivers for the same hardware.
> 
> Point 1: You can't perform resource management on the System RAM since
>  they're already claimed.

Hmmm... Just guessing: perhaps because you created the System RAM resource
using request_mem_region() instead of request_resource()?

On Amiga the Chip RAM allocator uses the resource management system, and both
the whole bunch of Chip RAM (parent) and all allocated blocks (children) show
up in /proc/iomem.

> Point 2: You can't perform resource management on bits in a control
>  register that performs many other random functions; resource management
>  is byte based not bit based.

That's indeed more nasty.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313288AbSDJQQ6>; Wed, 10 Apr 2002 12:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313289AbSDJQQ5>; Wed, 10 Apr 2002 12:16:57 -0400
Received: from mail.sonytel.be ([193.74.243.200]:53214 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S313288AbSDJQQ4>;
	Wed, 10 Apr 2002 12:16:56 -0400
Date: Wed, 10 Apr 2002 18:12:43 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Byron Stanoszek <gandalf@winds.org>
cc: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>,
        "'davidsen@tmr.com'" <davidsen@tmr.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: RE: Using video memory as system memory
In-Reply-To: <Pine.LNX.4.44.0204101146050.13516-100000@winds.org>
Message-ID: <Pine.GSO.4.21.0204101809380.9914-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2002, Byron Stanoszek wrote:
> On Wed, 10 Apr 2002, Holzrichter, Bruce wrote:
> > That is a neat idea, though.  The PCI/AGP bus may be a limiting factor for
> > this as well, correct?  As far as speed, I believe most video cards have
> > fast memory, vram, or sram, but it's only useful transferring between the
> > Video GPU, and Video cards memory, as the bus to the video card is the
> > bottleneck.
> 
> Yeah. In fact in some responses the 'slow speed' consideration was so much that
> they all say I'd be better off writing a block driver and making use of the
> memory more as a swap device rather than as system RAM.
> 
> Has anyone out there done this yet? I figure I'd ask before reinventing
> anything.. :)

drivers/block/z2ram.c does this for RAM in the Amiga Zorro II space.

(Why? Because you cannot use Zorro II RAM as system RAM on machines equipped
 with a Zorro III bus because on those machines Zorro II RAM doesn't support
 read-modify-write cycles.)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


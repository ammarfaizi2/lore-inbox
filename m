Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262046AbSKHORK>; Fri, 8 Nov 2002 09:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262055AbSKHORK>; Fri, 8 Nov 2002 09:17:10 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:61922 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S262046AbSKHORJ>;
	Fri, 8 Nov 2002 09:17:09 -0500
Date: Fri, 8 Nov 2002 15:22:55 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Rusty Trivial Russell <trivial@rustcorp.com.au>
Subject: Re: [PATCH] SCSI on non-ISA systems
In-Reply-To: <20021108135742.A22790@flint.arm.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0211081522050.23267-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2002, Russell King wrote:
> On Fri, Nov 08, 2002 at 02:46:40PM +0100, Geert Uytterhoeven wrote:
> > Since 2.5.31, the compilation of kernel/dma.c is conditional on
> > CONFIG_GENERIC_ISA_DMA. However, drivers/scsi/hosts.c unconditionally calls
> > free_dma(), which breaks machines with SCSI that don't have ISA.
> 
> This isn't actually the original purpose of CONFIG_GENERIC_ISA_DMA (it
> was to allow an architecture to provide ISA-like DMA without having to
> use the ISA DMA request/free functions - eg, they need to claim interrupts
> on request_dma() and free them on free_dma()).

Then what's the correct(TM) fix? Unconditionally #define
CONFIG_GENERIC_ISA_DMA, so it behaves like before?

> However, since this function isn't used on ARM, it doesn't affect me,
> and so I don't have any problem with this patch. 8)

Hehe ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317892AbSHUGhG>; Wed, 21 Aug 2002 02:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317893AbSHUGhG>; Wed, 21 Aug 2002 02:37:06 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:7349 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S317892AbSHUGhF>;
	Wed, 21 Aug 2002 02:37:05 -0400
Date: Wed, 21 Aug 2002 08:36:11 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Andre Hedrick <andre@linux-ide.org>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Padraig Brady'" <padraig.brady@corvil.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "Warner, Bill (IndSys, GEFanuc, VMIC)" <Bill.Warner@gefanuc.com>
Subject: Re: IDE-flash device and hard disk on same controller
In-Reply-To: <3D62C2A3.4070701@mandrakesoft.com>
Message-ID: <Pine.GSO.4.21.0208210832450.3034-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2002, Jeff Garzik wrote:
> Jeff Garzik wrote:
> > Attached is the ATA core...
> 
> Just to give a little bit more information about the previously attached 
> code, it is merely a module that does two things:  (a) demonstrates 
> proper [and sometimes faster-than-current-linus] ATA bus probing, and 
> (b) demonstrates generic registration and initialization of ATA devices 
> and channels.  All other tasks can be left to "personality" (a.k.a. 
> class) drivers, such as 'disk', 'cdrom', 'floppy', ... types.

Looks nice (at first sight)!

But one limitation is that it always assumes the IDE ports are located in I/O
space :-(
What about architectures where IDE ports are located in MMIO space? Or worse,
have some ports in I/O space (e.g. PCI IDE card) and some in MMIO space (e.g.
SOC or mainboard IDE host interface)?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


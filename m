Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317893AbSHUGwd>; Wed, 21 Aug 2002 02:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317898AbSHUGwd>; Wed, 21 Aug 2002 02:52:33 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:31750
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317893AbSHUGwc>; Wed, 21 Aug 2002 02:52:32 -0400
Date: Tue, 20 Aug 2002 23:55:09 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Padraig Brady'" <padraig.brady@corvil.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "Warner, Bill (IndSys, GEFanuc, VMIC)" <Bill.Warner@gefanuc.com>
Subject: Re: IDE-flash device and hard disk on same controller
In-Reply-To: <Pine.GSO.4.21.0208210832450.3034-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.10.10208202354280.3867-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Geert,

Look at 2.4.20-pre2-ac5.

I fixed that problem.

On Wed, 21 Aug 2002, Geert Uytterhoeven wrote:

> On Tue, 20 Aug 2002, Jeff Garzik wrote:
> > Jeff Garzik wrote:
> > > Attached is the ATA core...
> > 
> > Just to give a little bit more information about the previously attached 
> > code, it is merely a module that does two things:  (a) demonstrates 
> > proper [and sometimes faster-than-current-linus] ATA bus probing, and 
> > (b) demonstrates generic registration and initialization of ATA devices 
> > and channels.  All other tasks can be left to "personality" (a.k.a. 
> > class) drivers, such as 'disk', 'cdrom', 'floppy', ... types.
> 
> Looks nice (at first sight)!
> 
> But one limitation is that it always assumes the IDE ports are located in I/O
> space :-(
> What about architectures where IDE ports are located in MMIO space? Or worse,
> have some ports in I/O space (e.g. PCI IDE card) and some in MMIO space (e.g.
> SOC or mainboard IDE host interface)?
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 

Andre Hedrick
LAD Storage Consulting Group


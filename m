Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317898AbSHUGy1>; Wed, 21 Aug 2002 02:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317911AbSHUGy1>; Wed, 21 Aug 2002 02:54:27 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:33030
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317898AbSHUGy0>; Wed, 21 Aug 2002 02:54:26 -0400
Date: Tue, 20 Aug 2002 23:57:27 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Padraig Brady'" <padraig.brady@corvil.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "Warner, Bill (IndSys, GEFanuc, VMIC)" <Bill.Warner@gefanuc.com>
Subject: MMIO {Re: IDE-flash device and hard disk on same controller}
In-Reply-To: <Pine.GSO.4.21.0208210832450.3034-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.10.10208202356390.3867-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Geert,

The proof.


ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SiI680: IDE controller on PCI bus 00 dev 90
SiI680: chipset revision 1
SiI680: not 100% native mode: will probe irqs later
SiI680: BASE CLOCK == 133
    ide0: MMIO-DMA at 0xe080df00-0xe080df07, BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA at 0xe080df08-0xe080df0f, BIOS settings: hdc:pio, hdd:pio
PIIX3: IDE controller on PCI bus 00 dev 39
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xffa0-0xffa7, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdg:pio, hdh:pio
hda: Maxtor 4G160J8, ATA DISK drive
hdb: Maxtor 4G160J8, ATA DISK drive
hdc: Maxtor 4G160J8, ATA DISK drive
hdd: Maxtor 4G160J8, ATA DISK drive
hde: ATAPI 44X CDROM, ATAPI CD/DVD-ROM drive
hdf: CREATIVEDVD5240E-1, ATAPI CD/DVD-ROM drive
ide0 at 0xe080df80-0xe080df87,0xe080df8a on irq 9
ide1 at 0xe080dfc0-0xe080dfc7,0xe080dfca on irq 9
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14

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
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbUCLRza (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 12:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbUCLRza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 12:55:30 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:30457 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262125AbUCLRz1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 12:55:27 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Markus Kossmann <markus.kossmann@inka.de>
Subject: Re: kernelparameter idex=noprobe
Date: Fri, 12 Mar 2004 19:02:44 +0100
User-Agent: KMail/1.5.3
References: <200403121826.21442.markus.kossmann@inka.de>
In-Reply-To: <200403121826.21442.markus.kossmann@inka.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403121902.44371.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 of March 2004 18:26, Markus Kossmann wrote:
> Hallo,
> according to linux-2.6.4/Documentation/ide.txt :
> "idex=noprobe"         : do not attempt to access/use this interface
> SuSEs inofficial 2.6.4-0 kernel ( precompiled from rpm) comes with
> CONFIG_BLK_DEV_SIIMAGE=y
> CONFIG_SCSI_SATA_SIL=m
>
> Trying to use the sata_sil driver for my sil3112 controler I did give
> ide4=noprobe ide5=noprobe hdi=noprobe hdj=noprobe hdk=noprobe hdl=noprobe
> on the kernel commandline
>
> The Bootup- messages show:
> [...]
> 6>Using ACPI (MADT) for SMP configuration information
> <4>Built 1 zonelists
> <4>Kernel command line: root=/dev/hde2 vga=0x317 desktop hdc=ide-scsi
> hdclun=0 splash=silent 3
> ide4=noprobe ide5=noprobe hdi=noprobe hdj=noprobe hdk=noprobe hdl=noprobe
> <6>ide_setup: hdc=ide-scsi
> <6>ide_setup: hdclun=0
> <6>bootsplash: silent mode.
> <6>ide_setup: ide4=noprobe
> <6>ide_setup: ide5=noprobe
> <6>ide_setup: hdi=noprobe
> <6>ide_setup: hdj=noprobe
> <6>ide_setup: hdk=noprobe
> <6>ide_setup: hdl=noprobe
> [...]
> 6>ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx <6>AMD7411: IDE controller at PCI slot 0000:00:07.1
> <6>AMD7411: chipset revision 1
> <6>AMD7411: not 100%% native mode: will probe irqs later
> <6>AMD7411: 0000:00:07.1 (rev 01) UDMA100 controller
> <6>    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
> <6>    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
> <4>hda: DM166D DVD-ROM, ATAPI CD/DVD-ROM drive
> <4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> <4>hdc: PLEXTOR DVDR PX-708A, ATAPI CD/DVD-ROM drive
> <4>ide1 at 0x170-0x177,0x376 on irq 15
> <6>PDC20270: IDE controller at PCI slot 0000:00:09.0
> <6>PDC20270: chipset revision 2
> <6>PDC20270: 100%% native mode on irq 177
> <6>    ide2: BM-DMA at 0x1830-0x1837, BIOS settings: hde:pio, hdf:pio
> <6>    ide3: BM-DMA at 0x1838-0x183f, BIOS settings: hdg:pio, hdh:pio
> <4>hde: SAMSUNG SP0612N, ATA DISK drive
> <4>ide2 at 0x1868-0x186f,0x1862 on irq 177
> <6>SiI3112 Serial ATA: IDE controller at PCI slot 0000:00:0a.0
> <6>SiI3112 Serial ATA: chipset revision 2
> <6>SiI3112 Serial ATA: 100%% native mode on irq 185
> <6>    ide4: MMIO-DMA , BIOS settings: hdi:pio, hdj:pio
> <6>    ide5: MMIO-DMA , BIOS settings: hdk:pio, hdl:pio
> <4>hde: max request size: 1024KiB
> <6>hde: 117304992 sectors (60060 MB) w/2048KiB Cache, CHS=16383/255/63,
> UDMA(100)
> <6> hde: hde1 < hde5 hde6 hde7 hde8 hde9 > hde2 hde3 hde4
> [...]
>
> Why is the SIL3112 taken over by the siimage driver ?
> Did I misinterpret ide.txt, is ide.txt wrong or is this a bug ?

It is not a bug - siimage driver is compiled in and PCI device is detected.
It has nothing to do with "idex=noprobe" or "hdx=noprobe".

> hdi=noprobe seems to work however. The attached SATA disk doesn't show up.
> And it does show up if I leave out hdi=noprobe.
>
> Is there any chance to use sata_sil with that kernel configuration ?
> Or is recompiling with CONFIG_BLK_DEV_SIIMAGE=m or with siimage disabled
> the only option ?

Yep.

Regards,
Bartlomiej


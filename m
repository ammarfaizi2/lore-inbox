Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbUBDKGc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 05:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbUBDKGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 05:06:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:58537 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261492AbUBDKGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 05:06:30 -0500
Date: Wed, 4 Feb 2004 11:06:26 +0100
From: Jens Axboe <axboe@suse.de>
To: Antony Gelberg <antony@antgel.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD-ROMs not working in 2.6
Message-ID: <20040204100625.GP11683@suse.de>
References: <20040204024439.GK25786@brain.pulsesol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040204024439.GK25786@brain.pulsesol.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04 2004, Antony Gelberg wrote:
> Hi all,
> 
> I'd appreciate a CC as I'm not subbed.
> 
> I'm running 2.6.0 from the Debian source packages.  All is good, except
> my CDROM drives don't work.  Here's some relevant output from
> /var/log/dmesg:
> 
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> VP_IDE: IDE controller at PCI slot 0000:00:11.1
> ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using
> IRQ 255
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
>     ide0: BM-DMA at 0x8800-0x8807, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0x8808-0x880f, BIOS settings: hdc:DMA, hdd:pio
> hdc: 54X CD-ROM, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> end_request: I/O error, dev hdc, sector 0
> hdc: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> libata version 0.81 loaded.
> sata_promise version 0.86
> ata1: SATA max UDMA/133 cmd 0xE0824200 ctl 0xE0824238 bmdma 0x0 irq 17
> ata2: SATA max UDMA/133 cmd 0xE0824280 ctl 0xE08242B8 bmdma 0x0 irq 17
> 
> Now lspci:
> 00:11.1 IDE interface: VIA Technologies, Inc.
> VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
> 
> Can anyone shed any light on this?  I've tried a different IDE cable.  I
> disconnected the other drive that was the slave, but no dice.  hdc and
> hdd both reported the I/O error when they were both connected.  The
> system doesn't recognise data or audio discs.

Maybe if you would let us know what doesn't work?! At least post the
full boot messages and make sure you aren't doing anything like passing
hdc/d=ide-scsi through lile/grub.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUBEMtW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 07:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbUBEMtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 07:49:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51386 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261567AbUBEMtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 07:49:18 -0500
Date: Thu, 5 Feb 2004 13:48:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Antony Gelberg <antony@antgel.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD-ROMs not working in 2.6
Message-ID: <20040205124845.GZ11683@suse.de>
References: <20040205120103.GE1952@brain.pulsesol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205120103.GE1952@brain.pulsesol.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05 2004, Antony Gelberg wrote:
> I asked for a CC which is why I didn't see the reply until I looked in
> Google groups and it is also why the thread will now be broken as I had
> to cut and paste the reply as a new message.  Please CC me any replies.

Well you were cc'ed, messages was received at your end at 2004-02-04
11:06:30 CET. So either look harder, or fix your mail setup.

Now, if you would like me to read your mail within a few hours (instead
of days), then you need to CC me.

> Jens Axboe wrote:
> >On Wed, Feb 04 2004, Antony Gelberg wrote:
> >> Hi all,
> >> 
> >> I'd appreciate a CC as I'm not subbed.
> >> 
> >> I'm running 2.6.0 from the Debian source packages.  All is good,
> >> except
> >> my CDROM drives don't work.  Here's some relevant output from
> >> /var/log/dmesg:
> >> 
> >> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> >> ide: Assuming 33MHz system bus speed for PIO modes; override with
> >> idebus=xx
> >> VP_IDE: IDE controller at PCI slot 0000:00:11.1
> >> ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using
> >> IRQ 255
> >> VP_IDE: chipset revision 6
> >> VP_IDE: not 100% native mode: will probe irqs later
> >> ide: Assuming 33MHz system bus speed for PIO modes; override with
> >> idebus=xx
> >> VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
> >>     ide0: BM-DMA at 0x8800-0x8807, BIOS settings: hda:pio, hdb:pio
> >>     ide1: BM-DMA at 0x8808-0x880f, BIOS settings: hdc:DMA, hdd:pio
> >> hdc: 54X CD-ROM, ATAPI CD/DVD-ROM drive
> >> ide1 at 0x170-0x177,0x376 on irq 15
> >> end_request: I/O error, dev hdc, sector 0
> >> hdc: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)
> >> Uniform CD-ROM driver Revision: 3.12
> >> libata version 0.81 loaded.
> >> sata_promise version 0.86
> >> ata1: SATA max UDMA/133 cmd 0xE0824200 ctl 0xE0824238 bmdma 0x0 irq 17
> >> ata2: SATA max UDMA/133 cmd 0xE0824280 ctl 0xE08242B8 bmdma 0x0 irq 17
> >> 
> >> Now lspci:
> >> 00:11.1 IDE interface: VIA Technologies, Inc.
> >> VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev
> >> 06)
> >> 
> >> Can anyone shed any light on this?  I've tried a different IDE cable.
> >> I
> >> disconnected the other drive that was the slave, but no dice.  hdc and
> >> hdd both reported the I/O error when they were both connected.  The
> >> system doesn't recognise data or audio discs.
> >
> >Maybe if you would let us know what doesn't work?! At least post the
> >full boot messages and make sure you aren't doing anything like passing
> >hdc/d=ide-scsi through lile/grub.
> 
> Sorry, I thought it was obvious.  I'll requote:
> 
> >> The system doesn't recognise data or audio discs.

That doesn't contain any sort of real info.

> What I meant was that mounting fails with "no such device", and playing
> audio CD's fails as well.  No error, just no recognition of the CD.

What does cat /proc/sys/dev/cdrom/info contain?

> 
> >> end_request: I/O error, dev hdc, sector 0
> 
> I think that this is the problem, but I don't know what it means.  I
> don't think posting the rest of my bootlog is patricularly helpful, but
> please let me know if it is.  I am not passing any parameters to lilo.

No, it likely has nothing to do with it.

> I have attached my kernel config in the hope that the list doesn't strip
> all attachments.

I don't care for your config, attach the boot messages like I asked.

-- 
Jens Axboe


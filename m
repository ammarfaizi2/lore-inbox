Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWAIMIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWAIMIr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 07:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWAIMIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 07:08:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43742 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751251AbWAIMIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 07:08:46 -0500
Date: Mon, 9 Jan 2006 04:03:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <gregkh@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [GIT PATCH] PCI patches for 2.6.15
Message-Id: <20060109040318.73e522af.akpm@osdl.org>
In-Reply-To: <20060106063716.GA4425@kroah.com>
References: <20060106063716.GA4425@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> wrote:
>
>  Jeff Garzik:
>        x86 PCI domain support: the meat

I have an old ad450nx quad Xeon which I (very) occasionally turn on.  This
patch kills it.

Real Time Clock Driver v1.12
ipmi message handler version 38.0
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 120000K size 1024 blocksize
loop: loaded (max 8 devices)
ACPI: PCI Interrupt 0000:02:04.0[A]: no GSI - using IRQ 11
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:04.0: 3Com PCI 3c980 Cyclone at f8802000. Vers LK1.1.19
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT374: IDE controller at PCI slot 0000:03:08.0
ACPI: PCI Interrupt 0000:03:08.0[A]: no GSI - using IRQ 11
HPT374: chipset revision 7
HPT374: 100% native mode on irq 11
    ide2: BM-DMA at 0x5400-0x5407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x5408-0x540f, BIOS settings: hdg:pio, hdh:pio
ACPI: PCI Interrupt 0000:03:08.1[A]: no GSI - using IRQ 11
    ide4: BM-DMA at 0x5800-0x5807, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x5808-0x580f, BIOS settings: hdk:pio, hdl:pio
PIIX4: IDE controller at PCI slot 0000:00:0f.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2420-0x2427, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x2428-0x242f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 96147H6, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HITACHI CDR-8335, ATAPI CD/DVD-ROM drive
hdc: Disabling (U)DMA for HITACHI CDR-8335 (blacklisted)
ide1 at 0x170-0x177,0x376 on irq 15
PIIX4: IDE controller at PCI slot 0000:00:10.0
PIIX4: device not capable of full native PCI mode
PIIX4: device disabled (BIOS)
PIIX4: IDE controller at PCI slot 0000:00:10.0
PIIX4: device not capable of full native PCI mode
PIIX4: device disabled (BIOS)
hda: max request size: 128KiB
hda: 120064896 sectors (61473 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(33)
hda: cache flushes notsupported
 hda: hda1 hda2 hda3
hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt 0000:03:04.0[A]: no GSI - using IRQ 11
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

 0:0:0:0: Attempting to queue an ABORT message
CDB: 0x12 0x0 0x0 0x0 0x24 0x0
 0:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
 0:0:0:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
------------[ cut here ]------------
kernel BUG at kernel/timer.c:293!


(The timer bug is jejb stuff which I'll take to linux-scsi).

This machine has an old BIOS, from 2000 so the ACPI implementation may not
be great.  But it's worked thus far, and with this patch, the machine is
dead.


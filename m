Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbUKPMrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbUKPMrA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 07:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbUKPMrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 07:47:00 -0500
Received: from web52601.mail.yahoo.com ([206.190.39.139]:59553 "HELO
	web52601.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261964AbUKPMq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 07:46:57 -0500
Message-ID: <20041116124656.82075.qmail@web52601.mail.yahoo.com>
Date: Tue, 16 Nov 2004 23:46:56 +1100 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: [BUG] Kernel disables DMA on RICOH CD-R/RW
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of 2.6.9-rc4 (I have verified this to be case all
the way up to 2.6.10-rc2), kernel displays this
message:

Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level,
low) -> IRQ 20
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on
pci0000:00:0f.1
    ide0: BM-DMA at 0xcc00-0xcc07, BIOS settings:
hda:DMA, hdb:pio
    ide1: BM-DMA at 0xcc08-0xcc0f, BIOS settings:
hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: ST3120026A, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Pioneer DVD-ROM ATAPIModel DVD-113 0113, ATAPI
CD/DVD-ROM drive
hdd: RICOH CD-R/RW MP7083A, ATAPI CD/DVD-ROM drive
hdd: Disabling (U)DMA for RICOH CD-R/RW MP7083A
(blacklisted)

The kernel disables DMA on the CD-R/RW (/dev/hdd) and
of course it would not let me enable it manually
either. Up until 2.6.9-rc3 the drive worked in DMA
mode just fine.

(I have been using this drive for more than 4 years. I
have used it under 2.2.x, 2.4.x, >=2.5.50 in DMA mode
just fine. Although I have changed everything else in
the computer in those long years: CPU, M/B, RAM, HDD
etc., save this great CD-R/RW drive, which has been
working fine.)

So the question is: why?
(And what can I do to enable DMA again?)

Thank you.
Hari.

PS: Please cc me on reply, since I am not subscribed
to LKML.


Find local movie times and trailers on Yahoo! Movies.
http://au.movies.yahoo.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318043AbSGRMlq>; Thu, 18 Jul 2002 08:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318044AbSGRMlq>; Thu, 18 Jul 2002 08:41:46 -0400
Received: from grex.cyberspace.org ([216.93.104.34]:12296 "HELO
	grex.cyberspace.org") by vger.kernel.org with SMTP
	id <S318043AbSGRMlp>; Thu, 18 Jul 2002 08:41:45 -0400
From: Andrew Halliwell <spike1@cyberspace.org>
Message-Id: <200207181245.IAA14216@grex.cyberspace.org>
Subject: Asus P4B533 and resource conflict on IDE
To: linux-kernel@vger.kernel.org
Date: Thu, 18 Jul 2002 08:45:43 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there, 

This is my first time posting to the mailing list, but I've been searching
on google for a solution to this problem for a couple of weeks and so far,
found nothing. Also tried the latest patches from andre and the rc1 and rc2
patches from kernel.org...

The problem is this.

The P4B533 has the intel 801DB IDE controller (stated as supported in rc1)
but in every 2.4 kernel I've seen so far, this appears in the bootup.

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PCI_IDE: unknown IDE controller on PCI bus 00 device f9, VID=8086, DID=24cb
PCI: Device 00:1f.1 not available because of resource collisions
PCI_IDE: (ide_setup_pci_device:) Could not enable device.
hda: Maxtor 2B020H1, ATA DISK drive
hdc: ASUS CD-S520/A, ATAPI CD/DVD-ROM drive

I've tried Redhat 7.2, 7.3, Mandrake 8.2 and SuSE 8 stock kernels.

In the later kernels, this means no DMA is possible, although in the earlier
2.4s (stock redhat 7.2 [2.4.7-10] for example) it's possible to turn on DMA,
at the risk of nuking your filesystem...

I even resorted to trying the 2.2.21 kernel, which didn't report a resource
conflict, but enabling DMA again nuked the filesystem.
(I imagine resource conflict isn't an error message in 2.2?)

Just wondered if this problem had been brought up before, and what causes
it (and of course, if there's a workaround before a patch arrives that fixes
it). I noticed on google that a similar problem with a different
motherboard was fixed in one of andres patches a month or so ago.

Thanks, 

Andrew Halliwell

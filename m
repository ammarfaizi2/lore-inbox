Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbVKJUqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVKJUqa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 15:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbVKJUqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 15:46:15 -0500
Received: from k1.dinoex.de ([80.237.153.113]:28355 "EHLO k1.dinoex.de")
	by vger.kernel.org with ESMTP id S932100AbVKJUqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 15:46:13 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
From: Jochen Hein <jochen@jochen.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.6.14] ATAPI DVD no longer found
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
Date: Thu, 10 Nov 2005 21:39:44 +0100
Message-ID: <87fyq46xv3.fsf@echidna.jochen.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hardware is a Thinkpad R40, Debian sarge with -linus kernel.

2.6.13: works, no parameters for IDE given.  dmesg concerning ide as follows:

Nov 10 21:20:41 hermes kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov 10 21:20:41 hermes kernel: ICH4: IDE controller at PCI slot 0000:00:1f.1
Nov 10 21:20:41 hermes kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Nov 10 21:20:41 hermes kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
Nov 10 21:20:41 hermes kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
Nov 10 21:20:41 hermes kernel: ICH4: chipset revision 1
Nov 10 21:20:41 hermes kernel: ICH4: not 100%% native mode: will probe irqs later
Nov 10 21:20:41 hermes kernel:     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
Nov 10 21:20:41 hermes kernel:     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Nov 10 21:20:41 hermes kernel: Probing IDE interface ide0...
Nov 10 21:20:41 hermes kernel: hda: IC25N040ATMR04-0, ATA DISK drive
Nov 10 21:20:41 hermes kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 10 21:20:41 hermes kernel: Probing IDE interface ide1...
Nov 10 21:20:41 hermes kernel: hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4240N, ATAPI CD/DVD-ROM drive
Nov 10 21:20:41 hermes kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov 10 21:20:41 hermes kernel: hda: max request size: 128KiB
Nov 10 21:20:41 hermes kernel: hda: Host Protected Area detected.
Nov 10 21:20:41 hermes kernel: ^Icurrent capacity is 71711733 sectors (36716 MB)
Nov 10 21:20:41 hermes kernel: ^Inative  capacity is 78140160 sectors (40007 MB)
Nov 10 21:20:41 hermes kernel: hda: Host Protected Area disabled.
Nov 10 21:20:41 hermes kernel: hda: 78140160 sectors (40007 MB) w/1740KiB Cache, CHS=65535/16/63, UDMA(100)
Nov 10 21:20:41 hermes kernel: hda: cache flushes supported
Nov 10 21:20:41 hermes kernel:  hda: hda1 hda2 hda3 hda4
Nov 10 21:20:41 hermes kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Nov 10 21:20:41 hermes kernel: Uniform CD-ROM driver Revision: 3.20

2.6.14-rc3: works 
2.6.14-rc5: works

2.6.14.1: with hdc=cdrom, dmesg concerning ide:

Nov 10 21:14:14 hermes kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Nov 10 21:14:14 hermes kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov 10 21:14:14 hermes kernel: ICH4: IDE controller at PCI slot 0000:00:1f.1
Nov 10 21:14:14 hermes kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Nov 10 21:14:14 hermes kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
Nov 10 21:14:14 hermes kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
Nov 10 21:14:14 hermes kernel: ICH4: chipset revision 1
Nov 10 21:14:14 hermes kernel: ICH4: not 100%% native mode: will probe irqs later
Nov 10 21:14:14 hermes kernel:     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
Nov 10 21:14:14 hermes kernel:     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Nov 10 21:14:14 hermes kernel: Probing IDE interface ide0...
Nov 10 21:14:14 hermes kernel: hda: IC25N040ATMR04-0, ATA DISK drive
Nov 10 21:14:14 hermes kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 10 21:14:14 hermes kernel: Probing IDE interface ide1...
Nov 10 21:14:14 hermes kernel: hdc: ATAPI cdrom (?)
Nov 10 21:14:14 hermes kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov 10 21:14:14 hermes kernel: Probing IDE interface ide2...
Nov 10 21:14:14 hermes kernel: Probing IDE interface ide3...
Nov 10 21:14:14 hermes kernel: Probing IDE interface ide4...
Nov 10 21:14:14 hermes kernel: Probing IDE interface ide5...
Nov 10 21:14:14 hermes kernel: hda: max request size: 128KiB
Nov 10 21:14:14 hermes kernel: hda: Host Protected Area detected.
Nov 10 21:14:14 hermes kernel: ^Icurrent capacity is 71711733 sectors (36716 MB)
Nov 10 21:14:14 hermes kernel: ^Inative  capacity is 78140160 sectors (40007 MB)
Nov 10 21:14:14 hermes kernel: hda: Host Protected Area disabled.
Nov 10 21:14:14 hermes kernel: hda: 78140160 sectors (40007 MB) w/1740KiB Cache, CHS=65535/16/63, UDMA(100)
Nov 10 21:14:14 hermes kernel: hda: cache flushes supported
Nov 10 21:14:14 hermes kernel:  hda: hda1 hda2 hda3 hda4
Nov 10 21:14:14 hermes kernel: ide-cd: cmd 0x5a timed out
Nov 10 21:14:14 hermes kernel: hdc: lost interrupt
Nov 10 21:14:14 hermes kernel: hdc: status error: status=0x00 { }
Nov 10 21:14:14 hermes kernel: ide: failed opcode was: unknown
Nov 10 21:14:14 hermes kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache
Nov 10 21:14:14 hermes kernel: Uniform CD-ROM driver Revision: 3.20

Some time later I get the following messages:

Nov 10 21:14:22 hermes kernel: hdc: status error: status=0x00 { }
Nov 10 21:14:22 hermes kernel: ide: failed opcode was: unknown
Nov 10 21:14:22 hermes kernel: hdc: status error: status=0x20 { DeviceFault }
Nov 10 21:14:22 hermes kernel: ide: failed opcode was: unknown
Nov 10 21:14:23 hermes kernel: hdc: ATAPI reset complete
Nov 10 21:14:23 hermes kernel: hdc: status error: status=0x00 { }
Nov 10 21:14:23 hermes kernel: ide: failed opcode was: unknown
Nov 10 21:14:23 hermes kernel: hdc: status error: status=0x00 { }
Nov 10 21:14:23 hermes kernel: ide: failed opcode was: unknown
Nov 10 21:14:23 hermes kernel: hdc: status error: status=0x00 { }
Nov 10 21:14:23 hermes kernel: ide: failed opcode was: unknown
Nov 10 21:14:23 hermes kernel: hdc: status error: status=0x00 { }
Nov 10 21:14:23 hermes kernel: ide: failed opcode was: unknown
Nov 10 21:14:23 hermes kernel: hdc: ATAPI reset complete

2.6.14.1 without command line parameters:

Nov 10 20:20:25 hermes kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Nov 10 20:20:25 hermes kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov 10 20:20:25 hermes kernel: ICH4: IDE controller at PCI slot 0000:00:1f.1
Nov 10 20:20:25 hermes kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Nov 10 20:20:25 hermes kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
Nov 10 20:20:25 hermes kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
Nov 10 20:20:25 hermes kernel: ICH4: chipset revision 1
Nov 10 20:20:25 hermes kernel: ICH4: not 100%% native mode: will probe irqs later
Nov 10 20:20:25 hermes kernel:     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
Nov 10 20:20:25 hermes kernel:     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Nov 10 20:20:25 hermes kernel: Probing IDE interface ide0...
Nov 10 20:20:25 hermes kernel: hda: IC25N040ATMR04-0, ATA DISK drive
Nov 10 20:20:25 hermes kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 10 20:20:25 hermes kernel: Probing IDE interface ide1...
Nov 10 20:20:25 hermes kernel: Probing IDE interface ide1...
Nov 10 20:20:25 hermes kernel: Probing IDE interface ide2...
Nov 10 20:20:25 hermes kernel: Probing IDE interface ide3...
Nov 10 20:20:25 hermes kernel: Probing IDE interface ide4...
Nov 10 20:20:25 hermes kernel: Probing IDE interface ide5...
Nov 10 20:20:25 hermes kernel: hda: max request size: 128KiB
Nov 10 20:20:25 hermes kernel: hda: Host Protected Area detected.
Nov 10 20:20:25 hermes kernel: ^Icurrent capacity is 71711733 sectors (36716 MB)
Nov 10 20:20:25 hermes kernel: ^Inative  capacity is 78140160 sectors (40007 MB)
Nov 10 20:20:25 hermes kernel: hda: Host Protected Area disabled.
Nov 10 20:20:25 hermes kernel: hda: 78140160 sectors (40007 MB) w/1740KiB Cache, CHS=65535/16/63, UDMA(100)
Nov 10 20:20:25 hermes kernel: hda: cache flushes supported
Nov 10 20:20:25 hermes kernel:  hda: hda1 hda2 hda3 hda4

Somewhere between 2.6.14-rc5 and 2.6.14.1 the DVD gets lost...
Any ideas?

Jochen

-- 
#include <~/.signature>: permission denied

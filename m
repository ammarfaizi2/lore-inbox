Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266020AbUALKCJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 05:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266097AbUALKCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 05:02:09 -0500
Received: from mailgate5.cinetic.de ([217.72.192.165]:19080 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id S266020AbUALKCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 05:02:03 -0500
Date: Mon, 12 Jan 2004 11:02:02 +0100
Message-Id: <200401121002.i0CA22Q13267@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: "Kai Krueger" <kai.a.krueger@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Drive appears confused
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> I have a new notebook with VIA KT400 Chipset and kernel 2.4.25-pre4. I receive many messages with:

>...
>hdc: lost interrupt
>hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x 1)
>...

>The drive is a DVD+RW from RICO ( RW8160 ). This is an OEM device. Latest DVD-Drive Firmware is "burned".

I seem to have the same problem as described here. On bootup I sometimes get the messages

ide_cd: cmd 0x3 timed out
hdc: lost interrupt
hdc: cdrm_pc_intr: The drive appears confused (ireason = 0x1)

I have tried many of the 2.6 kernels upto and including 2.6.1-mm1 with different configurations. All had this problem, that the bootup stopped during the CD initialization code and then repeated the above 3 lines indefinitely with a long timeout period in between, so that only switching off the laptop helped.
The strange thing is, that this problem does not always happen. Sometimes I can boot into Linux without problems.
It seems random to when it happens and when not, as at times I have to retry more than 10 times to get the laptop running and sometimes in works fine the first time repeatedly.
The debian 2.4.22-xfs kernel does not seem to suffer the problem (or at least it is much more seldom, that it didn't occur within the 20 test reboots)

The problem also seems to occur much less often if there is a CD in the drive, but either way it is random to when it does actually work and when not.



here are part of the kernel messages for 2.6.1-mm1 (copied over from the working kernel log, but from what I could see are identical to when bootup fails)

Jan 10 14:04:14 aiputer kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jan 10 14:04:14 aiputer kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jan 10 14:04:14 aiputer kernel: VP_IDE: IDE controller at PCI slot 0000:00:11.1
Jan 10 14:04:14 aiputer kernel: ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using IRQ 255
Jan 10 14:04:14 aiputer kernel: VP_IDE: chipset revision 6
Jan 10 14:04:14 aiputer kernel: VP_IDE: not 100%% native mode: will probe irqs later
Jan 10 14:04:14 aiputer kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jan 10 14:04:14 aiputer kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
Jan 10 14:04:14 aiputer kernel:     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
Jan 10 14:04:14 aiputer kernel:     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Jan 10 14:04:14 aiputer kernel: hda: TOSHIBA MK6021GAS, ATA DISK drive
Jan 10 14:04:14 aiputer kernel: Using anticipatory io scheduler
Jan 10 14:04:14 aiputer kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jan 10 14:04:14 aiputer kernel: hdc: DVD+RW RW8160, ATAPI CD/DVD-ROM drive
Jan 10 14:04:14 aiputer kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jan 10 14:04:14 aiputer kernel: hda: max request size: 128KiB
Jan 10 14:04:14 aiputer kernel: hda: 117210240 sectors (60011 MB), CHS=65535/16/63, UDMA(100)
Jan 10 14:04:14 aiputer kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
Jan 10 14:04:14 aiputer kernel: cdrom: : unknown mrw mode page
Jan 10 14:04:14 aiputer kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 8192kB Cache, UDMA(33)
Jan 10 14:04:14 aiputer kernel: Uniform CD-ROM driver Revision: 3.20

Sometimes (again to my knowledge random) the last 3 lines are not in the logs so that the "ide_cd: cmd 0x3 timed out" comes directly after the hda partition information.


My Hardware is just like the one described in the previous mail. A laptop with a VIA KT400 Chipset and the same DVD+RW from RICOH.

I would be happy to provide any additional information that might help solve the problem and am prepared to test any patches.


Thank you for your help in advance,

Kai
______________________________________________________________________________
Erdbeben im Iran: Zehntausende Kinder brauchen Hilfe. UNICEF hilft den
Kindern - helfen Sie mit! https://www.unicef.de/spe/spe_03.php


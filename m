Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271988AbRIEN0N>; Wed, 5 Sep 2001 09:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272137AbRIENZz>; Wed, 5 Sep 2001 09:25:55 -0400
Received: from AMontpellier-201-1-1-55.abo.wanadoo.fr ([193.252.31.55]:24845
	"EHLO awak") by vger.kernel.org with ESMTP id <S271988AbRIENZt>;
	Wed, 5 Sep 2001 09:25:49 -0400
Subject: hang on disk discovery
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.08.30.16.57 (Preview Release)
Date: 05 Sep 2001 15:21:34 +0200
Message-Id: <999696095.14164.12.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My box hangs during disk discovery.
Here is what I have in dmesg:

VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
HPT370: IDE controller on PCI bus 00 dev 70
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xc800-0xc807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xc808-0xc80f, BIOS settings: hdg:pio, hdh:pio
hd1: C/H/S=0/0/0 from BIOS ignored
hda: ST36531A, ATA DISK drive
hdb: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
hdc: HITACHI DVD-ROM GD-7500, ATAPI CD/DVD-ROM drive
hdd: LG CD-RW CED-8080B, ATAPI CD/DVD-ROM drive

Then it hangs there. If I push the power button, either it continues to
boot normally, or it resets, or nothing happens.

If it continues booting, I have:

hde: ST340824A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xb800-0xb807,0xbc02 on irq 11
hda: 12706470 sectors (6506 MB) w/128KiB Cache, CHS=6204/64/32, UDMA(33)
hde: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, UDMA(100)

etc.

It happens with 2.4.9-ac7 and 2.4.8-ac7, but not with 2.4.5-ac19 and
previous (and not with 2.2 series).
I tried booting with noapic, it doesn't change anything.

I have an ABit VP6 (dual PIII, VIA chipset), ACPI in kernel, I just put
--no-mem-option in grub to see if it changes anything but no.
The only intersting thing in dmesg seems the "unexpected IO-APIC".
How can I help ?

	Xav


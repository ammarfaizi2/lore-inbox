Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276138AbRJKMO6>; Thu, 11 Oct 2001 08:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276190AbRJKMOt>; Thu, 11 Oct 2001 08:14:49 -0400
Received: from mail1.dexterus.com ([212.95.255.99]:11021 "EHLO
	mail1.dexterus.com") by vger.kernel.org with ESMTP
	id <S276138AbRJKMOf>; Thu, 11 Oct 2001 08:14:35 -0400
Message-ID: <3BC58D32.F500422@dexterus.com>
Date: Thu, 11 Oct 2001 13:14:42 +0100
From: Vincent Sweeney <v.sweeney@dexterus.com>
Organization: Dexterus
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Lost Partition
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just upgrade my kernel to 2.4.12 and in the process I've lost a
partition on my secondary IDE drive. Since this is my /usr partition
it's kind of important ;)

Here is the relevant section from my dmesg output and fdisk (note
/dev/hdb5 is the one missing). The output from fdisk in recovery mode
can see the partition and the ID looks correct but the kernel seems to
have an 'issue'.

If you need any more details just ask.

Vince.

---
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:DMA, hdd:pio
hda: SAMSUNG SV1021H, ATA DISK drive
hdb: SAMSUNG SV1021H, ATA DISK drive
hdc: LG CD-ROM CRD-8521B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 19932192 sectors (10205 MB) w/426KiB Cache, CHS=1240/255/63,
UDMA(33)
hdb: 19932192 sectors (10205 MB) w/426KiB Cache, CHS=1240/255/63,
UDMA(33)
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
 hdb: hdb1 hdb2 <  >

---

Disk /dev/hda: 255 heads, 63 sectors, 1240 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1         9     72261   83  Linux
/dev/hda2            10      1240   9888007+   5  Extended
/dev/hda5            10       140   1052226   83  Linux
/dev/hda6           141       271   1052226   83  Linux
/dev/hda7           272       337    530113+  83  Linux
/dev/hda8           338      1240   7253316   83  Linux

Disk /dev/hdb: 255 heads, 63 sectors, 1240 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdb1   *         1        66    530113+  82  Linux swap
/dev/hdb2            67      1240   9430155    5  Extended
/dev/hdb5            67      1240   9430123+  83  Linux

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264006AbTDJIUT (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 04:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264008AbTDJIUT (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 04:20:19 -0400
Received: from [141.56.20.5] ([141.56.20.5]:60032 "EHLO
	iaix5.informatik.htw-dresden.de") by vger.kernel.org with ESMTP
	id S264006AbTDJIUQ convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 04:20:16 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Gregor Jasny <s51213@informatik.htw-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: Two IDE Bugs in 2.5.67
Date: Thu, 10 Apr 2003 10:31:31 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304101031.31400.s51213@informatik.htw-dresden.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First One: Double capacity entries in /proc/ide/hd*/
-r--r--r--    1 root     root            0 Apr 10 08:53 capacity
-r--r--r--    1 root     root            0 Apr 10 08:53 capacity
-r--r--r--    1 root     root            0 Apr 10 08:53 capacity
-r--r--r--    1 root     root            0 Apr 10 08:53 driver
-r--------    1 root     root            0 Apr 10 08:53 identify
-r--r--r--    1 root     root            0 Apr 10 08:53 media
-r--r--r--    1 root     root            0 Apr 10 08:53 model
-rw-------    1 root     root            0 Apr 10 08:53 settings

Second One: TCQ insn't enabled on third (hdg) disk:

hda: IC35L060AVVA07-0
hde,hdg: IC35L040AVER07-0

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L060AVVA07-0, ATA DISK drive
hda: tagged command queueing enabled, command queue depth 32
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: PLEXTOR CD-R PX-W2410A, ATAPI CD/DVD-ROM drive
hdd: Pioneer DVD-ROM ATAPIModel DVD-106S 012, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
HPT370A: IDE controller at PCI slot 00:0b.0
HPT370A: chipset revision 4
HPT370A: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:DMA, hdh:pio
hde: IC35L040AVER07-0, ATA DISK drive
hde: tagged command queueing enabled, command queue depth 32
ide2 at 0xb800-0xb807,0xb402 on irq 10
hdg: IC35L040AVER07-0, ATA DISK drive
ide3 at 0xb000-0xb007,0xa802 on irq 10
hda: host protected area => 1
hda: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, UDMA(33)
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 > hda4
hde: host protected area => 1
hde: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
 hde: hde1 hde4 < hde5 hde6 hde7 hde8 hde9 hde10 hde11 hde12 hde13 >
hdg: host protected area => 1
hdg: 78165360 sectors (40021 MB) w/1916KiB Cache, CHS=77545/16/63, UDMA(100)
 hdg: hdg1
end_request: I/O error, dev hdd, sector 0
hdd: ATAPI 40X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdd, sector 0

Best Regards,
-G. Jasny

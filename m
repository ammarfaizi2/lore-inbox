Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSHMIeQ>; Tue, 13 Aug 2002 04:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313060AbSHMIeQ>; Tue, 13 Aug 2002 04:34:16 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:12722 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S293203AbSHMIeP>; Tue, 13 Aug 2002 04:34:15 -0400
Subject: [BUG] 2.5.31 doesn't boot - looks IDE related
From: Anton Altaparmakov <aia21@cantab.net>
To: Marcin Dalecki <dalecki@evision.ag>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 13 Aug 2002 09:38:02 +0100
Message-Id: <1029227882.6892.90.camel@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin,

2.5.31 dies with the last messages being:
[snip]
ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: VIA Technologies, Inc. Bus Master IDE, PCI slot 00:07.1
ATA: chipset rev.: 6
ATA: non-legacy mode: IRQ probe delayed
VP_IDE: VIA vt82c686b (rev 40) ATA UDMA100 controller on PCI 00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L040AVER07-0, DISK drive
hdc: LITE-ON LTR-12102B, ATAPI CD/DVD-ROM drive 
hdd: Maxtor 90288D2, DISK drive 
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
<it is dead>

2.4.19 at the same place gives:
[snip]
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L040AVER07-0, ATA DISK drive
hdc: LITE-ON LTR-12102B, ATAPI CD/DVD-ROM drive
hdd: Maxtor 90288D2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=5005/255/63,
UDMA(100)
hdd: 5627664 sectors (2881 MB) w/256KiB Cache, CHS=5583/16/63, UDMA(33)
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
 hdd: [PTBL] [697/128/63] hdd1 hdd2 < hdd5 hdd6 hdd7 hdd8 hdd9 hdd10 >
<and continues happily>

Looks like your domain... Any hope for having IDE working again soon?

I've got NTFS write code now and can't test it because I can't boot the
kernel! )-:

Perhaps I should just move all my development to 2.4 and forget 2.5...

-- 
Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

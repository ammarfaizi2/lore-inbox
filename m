Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSGPLNP>; Tue, 16 Jul 2002 07:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314553AbSGPLNO>; Tue, 16 Jul 2002 07:13:14 -0400
Received: from hub-r.franken.de ([194.94.249.2]:32525 "EHLO hub-r.franken.de")
	by vger.kernel.org with ESMTP id <S314548AbSGPLNN>;
	Tue, 16 Jul 2002 07:13:13 -0400
Subject: Problems with Promise PDC 20265 and 2.4.19-rc1
From: Ernst Lehmann <lehmann@acheron.franken.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5.99 
Date: 16 Jul 2002 13:16:02 +0200
Message-Id: <1026818162.1039.19.camel@hadley>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry, if this has been asked before, but I could not find any in the
archives.

I have a Gigabyte GA7DXR with a onboard Promise PDC20265 IDE-Controller.

Attached to this Controller are 4 Maxtor 120 GB Disks.

Booting with 2.4.18 works fine. The partitons of the disk are detecded,
and I can access them.

Booting with 2.4.19-rc1 hangs on bootup.

The Promise is detected correctly.

But when it comes to the partition-check the systems hangs:

looks like this:

------snippel-------
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xc800-0xc807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xc808-0xc80f, BIOS settings: hdg:DMA, hdh:DMA
hda: IBM-DHEA-36481, ATA DISK drive
hde: Maxtor 4G120J6, ATA DISK drive
hdf: Maxtor 4G120J6, ATA DISK drive
hdg: Maxtor 4G120J6, ATA DISK drive
hdh: Maxtor 4G120J6, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xb800-0xb807,0xbc02 on irq 11
ide3 at 0xc000-0xc007,0xc402 on irq 11
hda: 12692736 sectors (6499 MB) w/472KiB Cache, CHS=790/255/63, UDMA(33)
hde: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=238216/16/63,
UDMA(100)
hdf: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=238216/16/63,
UDMA(100)
hdg: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=238216/16/63,
UDMA(100)
hdh: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=238216/16/63,
UDMA(100)
Partition check:
 hda: hda1 hda2 hda3
 hde:

--------------

And here it hangs


Because the patch between 2.4.18 and 2.4.19-rc1 is very big, there seem
to be a lot of changes.


Thanks in andvance for any help.....




-- 

Bye

	Ernst
---------
Ernst Lehmann             Email: lehmann@acheron.franken.de



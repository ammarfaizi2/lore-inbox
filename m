Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265398AbRGCRQL>; Tue, 3 Jul 2001 13:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbRGCRQC>; Tue, 3 Jul 2001 13:16:02 -0400
Received: from athena.intergrafix.net ([206.245.154.69]:42417 "HELO
	athena.intergrafix.net") by vger.kernel.org with SMTP
	id <S265398AbRGCRPo>; Tue, 3 Jul 2001 13:15:44 -0400
Date: Tue, 3 Jul 2001 13:15:39 -0400 (EDT)
From: Admin Mailing Lists <mlist@intergrafix.net>
To: linux-kernel@vger.kernel.org
Subject: ufs on linux question/problem
Message-ID: <Pine.LNX.4.10.10107031309240.20297-100000@athena.intergrafix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trying to mount a solaris x86 drive under linux.
kernel 2.4.5, ufs support and x86 partition support compiled in (no
module)
On boot, linux recognizes the drive, but shows no solaris partitions on
it.
Below, linux drive is hda, solaris is hdb.

Jul  2 19:57:56 stevenjude2 kernel: PIIX4: chipset revision 2
Jul  2 19:57:56 stevenjude2 kernel: PIIX4: not 100%% native mode: will
probe irqs later
Jul  2 19:57:56 stevenjude2 kernel:     ide0: BM-DMA at 0xffa0-0xffa7,
BIOS settings: hda:DMA, hdb:pio
Jul  2 19:57:56 stevenjude2 kernel:     ide1: BM-DMA at 0xffa8-0xffaf,
BIOS settings: hdc:DMA, hdd:pio
Jul  2 19:57:56 stevenjude2 kernel: hda: WDC AC26400B, ATA DISK drive
Jul  2 19:57:56 stevenjude2 kernel: hdb: QUANTUM FIREBALL ST3.2A, ATA DISK
driveJul  2 19:57:56 stevenjude2 kernel: hdc: SAMSUNG SC-140B, ATAPI
CD/DVD-ROM driveJul  2 19:57:56 stevenjude2 kernel: ide0 at
0x1f0-0x1f7,0x3f6 on irq 14
Jul  2 19:57:56 stevenjude2 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul  2 19:57:56 stevenjude2 kernel: hda: 12594960 sectors (6449 MB)
w/512KiB Cache, CHS=784/255/63, UDMA(33)
Jul  2 19:57:56 stevenjude2 kernel: hdb: 6306048 sectors (3229 MB) w/81KiB
Cache, CHS=6256/16/63, UDMA(33)
Jul  2 19:57:56 stevenjude2 kernel: Partition check:
Jul  2 19:57:56 stevenjude2 kernel:  hda: hda1 hda2 hda3 < hda5 >
Jul  2 19:57:56 stevenjude2 kernel:  hdb:


Tried to mount from the command line with:
mount -r -t ufs -o ufstype=sunx86,ro /dev/hdb /mnt
mount -r -t ufs -o ufstype=sunx86,ro /dev/hdb1 /mnt
All failed.

Only relevant log message i saw was:
Jul  2 22:04:02 stevenjude2 kernel: ufs_read_super: bad magic number

a fdisk on /dev/hdb shows no partitions. could the drive or partitions be
corrupted or something? if so, is data salvage likely?

Thanx,

-Tony
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
Anthony J. Biacco                       Network Administrator/Engineer
thelittleprince@asteroid-b612.org       Intergrafix Internet Services

    "Dream as if you'll live forever, live as if you'll die today"
http://www.asteroid-b612.org                http://www.intergrafix.net
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261525AbSJ1VlQ>; Mon, 28 Oct 2002 16:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261517AbSJ1VlQ>; Mon, 28 Oct 2002 16:41:16 -0500
Received: from dsl-212-144-218-082.arcor-ip.net ([212.144.218.82]:26604 "EHLO
	spot.local") by vger.kernel.org with ESMTP id <S261525AbSJ1VlP>;
	Mon, 28 Oct 2002 16:41:15 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: What does "hdX: CHECK for good STATUS" mean?
Date: Mon, 28 Oct 2002 22:47:30 +0100
User-Agent: KMail/1.4.1
X-PGP-Key-Fingerprint: E9DD 32F1 FA8A 0945 6A74  07DE 3A98 9F65 561D 4FD2
X-PGP-Key: http://www.lionking.org/~kiza/pgpkey.shtml
X-Species: Snow Leopard
X-Operating-System: Linux i686
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210282247.37737.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I have a new WDC WD800BB drive running on an ALI15X3 IDE controller. The drive 
comes up with

hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, (U)DMA

at boot and is set to mdma2 mode. If I set UDMA33 with hdparm the following 
message appears in the syslog:

hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete DataRequest 
}
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
hda: CHECK for good STATUS

After that the drive runs happily in udma2 mode. Can somebody tell me what the 
(error) message (CHECK for good STATUS) means? 


Btw, why is the drive not set to UDMA(33) on boot (like the other 80 GB 
Samsung drive)? I haven't found the drive in the ida-dma.c UDMA blacklists. 
Could this be some braindead BIOS thing? I had to flash a beta BIOS (Asus 
P5A-B) to get the board to boot with the 80 GB disks at all.

Regards,
Oliver Feiler


ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using 
pci=biosirq.
ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD800BB-00CAA1, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdc: SAMSUNG SV0813H, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, (U)DMA
hdc: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=155127/16/63, UDMA(33)


- -- 
Oliver Feiler  <kiza@(gmx(pro).net|lionking.org|claws-and-paws.com)>
http://www.lionking.org/~kiza/  <--   homepage
PGP-key ID 0x561D4FD2    --> /pgpkey.shtml
http://www.lionking.org/~kiza/journal/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9vbB5OpifZVYdT9IRAoLrAJ4wusHkTyQ6C40VJFPmM4/p1ktA4ACeL896
2TF5DxFpSHhfZy45zBMiesQ=
=8bo3
-----END PGP SIGNATURE-----


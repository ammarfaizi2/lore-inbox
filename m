Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293041AbSCSWDi>; Tue, 19 Mar 2002 17:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293048AbSCSWD2>; Tue, 19 Mar 2002 17:03:28 -0500
Received: from dsl3-63-249-88-76.cruzio.com ([63.249.88.76]:58789 "EHLO
	athlon.cichlid.com") by vger.kernel.org with ESMTP
	id <S293041AbSCSWDX>; Tue, 19 Mar 2002 17:03:23 -0500
Date: Tue, 19 Mar 2002 14:03:22 -0800
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200203192203.g2JM3M304071@athlon.cichlid.com>
To: linux-kernel@vger.kernel.org
Subject: Promise 20267 hangs with 2.4.19-pre3 and 2.4.19-pre3-ac3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With 2.4.18 everything works fine:

  Mar 13 13:56:13 athlon kernel: PDC20267: IDE controller on PCI bus 00 dev 48
  Mar 13 13:56:13 athlon kernel: PDC20267: chipset revision 2
  Mar 13 13:56:13 athlon kernel: PDC20267: not 100%% native mode: will probe irqs later
  Mar 13 13:56:13 athlon kernel: PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
  Mar 13 13:56:13 athlon kernel:     ide2: BM-DMA at 0x1800-0x1807, BIOS settings: hde:pio, hdf:pio
  Mar 13 13:56:13 athlon kernel:     ide3: BM-DMA at 0x1808-0x180f, BIOS settings: hdg:pio, hdh:pio

  Mar 13 13:56:13 athlon kernel: hde: Maxtor 4G120J6, ATA DISK drive
  Mar 13 13:56:13 athlon kernel: hdf: Maxtor 4G160J8, ATA DISK drive
  Mar 13 13:56:13 athlon kernel: hdg: TOSHIBA CD-ROM XM-6602B, ATAPI CD/DVD-ROM drive

  Mar 13 13:56:14 athlon kernel: hde: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=238216/16/63, UDMA(100)
  Mar 13 13:56:14 athlon kernel: hdf: 268435455 sectors (137439 MB) w/2048KiB Cache, CHS=266305/16/63, UDMA(100)

  Mar 13 13:56:14 athlon kernel: Partition check:
  Mar 13 13:56:14 athlon kernel:  hde: hde1 hde2 hde3 hde4
  Mar 13 13:56:14 athlon kernel:  hdf: hdf1

With 2.4.19-pre3 and pre3-ac3 the disk type and size are reported correctly 
but the systems hangs at the partition check (I couldn't find a copy of the log on 
the disk so I edited the above to match what I remembered on the screen):

  Mar 13 13:56:13 athlon kernel: hde: Maxtor 4G120J6, ATA DISK drive
  Mar 13 13:56:14 athlon kernel: hde: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=238216/16/63, UDMA(100)
  Mar 13 13:56:14 athlon kernel: Partition check:
  Mar 13 13:56:14 athlon kernel:  hde:

I tried the experiental ide timeout workaround and that does print a timeout message 
after a few seconds but the system still hangs there.

Its a Tyan 2462 athlon SMP with real SMP CPUs. There is another disk and a cdrom on
this controller but due to cable lengths I can't switch things around. 

I am willing to try any patch or suggestion...

Andrew


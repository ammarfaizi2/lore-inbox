Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTECJA3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 05:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263280AbTECJA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 05:00:29 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:62982
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263279AbTECJA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 05:00:27 -0400
Date: Sat, 3 May 2003 02:07:48 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: SATA SiI Seagate Alpine Erratium, until patch
Message-ID: <Pine.LNX.4.10.10305030139080.4263-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


SATA users.

If you have SiI SATA3112A and Seagate Alpine drives, in order to avoid
the 0x21 DMA error, issue hdparm -X66 -d1 /dev/hdX

If you have SiI SATA3112 and Seagate drives, don't that is a totally
different erratium.

I do not care and will not listen to any rants about, GEE, my 150 drive is
running at 66 ... the simple fact is you are wrong because SATA is
misleading.

NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SiI3112 Serial ATA: IDE controller at PCI slot 00:04.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide0: MMIO-DMA at 0xe880d000-0xe880d007, BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA at 0xe880d008-0xe880d00f, BIOS settings: hdc:pio, hdd:pio
SvrWks CSB6: IDE controller at PCI slot 00:0e.0
SvrWks CSB6: chipset revision 160
SvrWks CSB6: 100% native mode on irq 11
    ide2: BM-DMA at 0x1450-0x1457, BIOS settings: hde:pio, hdf:DMA
SvrWks CSB6: IDE controller at PCI slot 00:0f.1
SvrWks CSB6: chipset revision 160
SvrWks CSB6: not 100% native mode: will probe irqs later
    ide3: BM-DMA at 0x1460-0x1467, BIOS settings: hdg:DMA, hdh:pio
    ide4: BM-DMA at 0x1468-0x146f, BIOS settings: hdi:pio, hdj:DMA
hda: Maxtor 6Y080M0, ATA DISK drive
hdc: ST3120026AS, ATA DISK drive
hde: LS-120 VER5 00 UHD Floppy, ATAPI FLOPPY drive
hdf: LTN483, ATAPI CD/DVD-ROM drive
ide0 at 0xe880d080-0xe880d087,0xe880d08a on irq 22
ide1 at 0xe880d0c0-0xe880d0c7,0xe880d0ca on irq 22
ide2 at 0x1498-0x149f,0x148e on irq 11
hda: host protected area => 1
hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=158816/16/63
hdc: host protected area => 1
hdc: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=14593/255/63
ide-floppy driver 0.99.newide


[root@svwks root]# hdparm -it /dev/hdc

/dev/hdc:

 Model=ST3120026AS, FwRev=3.05, SerialNo=3JT00Y2B
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=65535/1/63, CurSects=4128705, LBA=yes, LBAsects=234441648
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2:  1 2 3 4 5 6

 Timing buffered disk reads:  64 MB in  1.25 seconds = 51.20 MB/sec

Like I said, I do not want to hear any rants, you have your erratium until
I resolve a patch.

If you are installing on RH9 or SuSE, you may need to issue hdparm -Xxx
-d1 /dev/hdX to invoke DMA on the SATA3112A, I do not know why it fails to
setup DMA but logically the driver is functional.

Regards,

Andre Hedrick
LAD Storage Consulting Group


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129165AbQKTVSI>; Mon, 20 Nov 2000 16:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129189AbQKTVR6>; Mon, 20 Nov 2000 16:17:58 -0500
Received: from day.its.uiowa.edu ([128.255.56.107]:7153 "EHLO
	day.its.uiowa.edu") by vger.kernel.org with ESMTP
	id <S129165AbQKTVRv>; Mon, 20 Nov 2000 16:17:51 -0500
Date: Mon, 20 Nov 2000 14:47:58 -0600
From: "Brian 'fief' De Smet" <fief@io.com>
To: linux-kernel@vger.kernel.org
Subject: Promise Ultra66 boot troubles (lost interrupt and waiting for DMA
 timeout)
Message-ID: <4069069214.974731678@[10.0.42.23]>
X-Mailer: Mulberry/2.0.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; FORMAT=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just installed a Promise Ultra66 in my computer.  It is running kernel 
2.2.17 with the unified ide patch (20001118) from Andre Hedrick.  When I 
boot the machine with drives plugged into this device the machine will hang 
during the partition check of the first drive connected to this controller. 
The error is
	hdf:hdf lost interrupt
	hdf: lost interrupt
	Waiting for DMA timeout
It will sit at that state for at least 10 minutes.  The machine will boot 
properly with no drives connected to the controller.  Part of the output 
from dmesg is included.

  Any suggestions?  I can of course provide further info and details if 
needed or desired.

--Brian



##################################
output from dmesg with the Promise Ultra66 controller installed but with no 
drives connected

Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc90-0xfc97, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc98-0xfc9f, BIOS settings: hdc:DMA, hdd:DMA
PDC20262: IDE controller on PCI bus 00 dev 68
PDC20262: chipset revision 1
PDC20262: not 100% native mode: will probe irqs later
PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xfcc0-0xfcc7, BIOS settings: hde:pio, hdf:DMA
    ide3: BM-DMA at 0xfcc8-0xfccf, BIOS settings: hdg:DMA, hdh:pio
hda: WDC AC25100L, ATA DISK drive
hdb: WDC WD307AA, ATA DISK drive
hdc: NEC CD-ROM DRIVE:28B, ATAPI CDROM drive
hdd: WDC WD408AA-00BAA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: WDC AC25100L, 4924MB w/256kB Cache, CHS=627/255/63, UDMA(33)
hdb: WDC WD307AA, 29333MB w/2048kB Cache, CHS=3739/255/63, UDMA(33)
hdd: WDC WD408AA-00BAA0, 38913MB w/2048kB Cache, CHS=79062/16/63, UDMA(33)
hdc: ATAPI 32X CD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.11
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
pcnet32.c: PCI bios is present, checking for devices...
tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov
eth0: Lite-On 82c168 PNIC rev 32 at 0xf800, 00:A0:CC:D1:AC:EB, IRQ 9.
eth0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth1: Lite-On 82c168 PNIC rev 33 at 0xf400, 00:A0:CC:3D:0C:77, IRQ 3.
eth1:  MII transceiver #1 config 1000 status 782d advertising 01e1.
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
 hdb: hdb1
 hdd: hdd1


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbRBAOMS>; Thu, 1 Feb 2001 09:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129249AbRBAOMI>; Thu, 1 Feb 2001 09:12:08 -0500
Received: from picard.csihq.com ([204.17.222.1]:40600 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S129150AbRBAOL6>;
	Thu, 1 Feb 2001 09:11:58 -0500
Message-ID: <03b401c08c58$ef72e930$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: IDE timeouts 2.4.1
Date: Thu, 1 Feb 2001 09:11:56 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Happens every night on both hda and hdc -- no sure yet what triggers it but
it is repeatable.  Has happened since I've installed this machine with all
the 2.4.x series.
Jan 31 00:34:16  kernel: hdc: timeout waiting for DMA
Jan 31 00:34:16  kernel: ide_dmaproc: chipset supported ide_dma_timeout func
only: 14
Jan 31 00:34:16  kernel: hdc: irq timeout: status=0x58 { DriveReady
SeekComplete DataRequest }
Jan 31 00:34:26  kernel: hdc: timeout waiting for DMA
Jan 31 00:34:26  kernel: ide_dmaproc: chipset supported ide_dma_timeout func
only: 14
Jan 31 00:34:26  kernel: hdc: irq timeout: status=0x58 { DriveReady
SeekComplete DataRequest }
Jan 31 00:34:36  kernel: hdc: timeout waiting for DMA
Jan 31 00:34:36  kernel: ide_dmaproc: chipset supported ide_dma_timeout func
only: 14
Jan 31 00:34:36  kernel: hdc: irq timeout: status=0x58 { DriveReady
SeekComplete DataRequest }
Jan 31 00:34:46  kernel: hdc: timeout waiting for DMA
Jan 31 00:34:46  kernel: ide_dmaproc: chipset supported ide_dma_timeout func
only: 14
Jan 31 00:34:46  kernel: hdc: irq timeout: status=0x58 { DriveReady
SeekComplete DataRequest }
Jan 31 00:34:46  kernel: hdc: DMA disabled
Jan 31 00:34:46 i kernel: ide1: reset: success

2.4.1 on Dual PIII/1G, 4G RAM,
WDC WD450AA-00BAA0
/dev/hda:

 Model=WDC WD450AA-00BAA0, FwRev=10.09K11, SerialNo=WD-WMA2E1605263
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=87930864
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4

00:0f.1 IDE interface: ServerWorks: Unknown device 0211 (prog-if 8a [Master
SecP PriP])
        Flags: bus master, medium devsel, latency 64
        I/O ports at ffa0 [size=16]

BIOS Vendor: American Megatrends Inc.
BIOS Version: 0700xx
BIOS Release: 12/12/00
System Vendor: Supermicro.
Product Name: 370DL3/370DLE.
Version 1234567890.
Serial Number 1234567890.
Board Vendor: Supermicro.
Board Name: 370DL3/370DLE.
Board Version: PCB Version.

ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD450AA-00BAA0, ATA DISK drive
hdc: WDC WD450AA-60BAA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 87930864 sectors (45021 MB) w/2048KiB Cache, CHS=5473/255/63, UDMA(33)
hdc: 87930864 sectors (45021 MB) w/2048KiB Cache, CHS=87233/16/63, UDMA(33)

________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

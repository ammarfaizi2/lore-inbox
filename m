Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129096AbRBCEvf>; Fri, 2 Feb 2001 23:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129161AbRBCEvP>; Fri, 2 Feb 2001 23:51:15 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:14085
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129096AbRBCEvA>; Fri, 2 Feb 2001 23:51:00 -0500
Date: Fri, 2 Feb 2001 20:50:42 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Dunlap, Randy" <randy.dunlap@intel.com>
cc: "'lkml'" <linux-kernel@vger.kernel.org>,
        "'mblack@csihq.com'" <mblack@csihq.com>
Subject: RE: IDE timeouts 2.4.1
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDFEE@orsmsx31.jf.intel.com>
Message-ID: <Pine.LNX.4.10.10102022048410.22591-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Do not trust the second channel to ATA devices.
Only ATAPI can live there.
I watch it all day long eat my second drives.
The OSB4 is not a pretty thing to play with, and I will have the chance to
fix the CSB5 before it goes final.

Cheers,

On Fri, 2 Feb 2001, Dunlap, Randy wrote:

> I'm also getting a ton of these, along with lots of
> file corruption.  I could handle the timeouts and
> rebooting every once in awhile if I didn't also have
> the corruption.
> 
> Do I have some incorrect IDE parameters?
> 
> (using 2.4.0, not 2.4.1)
> dual Pentium III 933 MHz (STL2 board)
> SAMSUNG 20 GB IDE hard drive
> ServerWorks chipset
> 
> details----------------------------------
> 
> Feb  2 19:34:51 localhost kernel: Linux version 2.4.0
> (rdunlap@localhost.localdomain) (gcc version 2.95.3 19991030 (prerelease))
> #34 SMP Tue Jan 30 17:49:24 PST 2001 
> Feb  2 19:35:00 localhost kernel: DMI table at 0x000EF5C0. 
> Feb  2 19:35:00 localhost kernel: BIOS Vendor: Intel Corporation 
> Feb  2 19:35:01 localhost kernel: BIOS Version:
> STL20.86B.0016.P01.0010111108 
> Feb  2 19:35:01 localhost kernel: BIOS Release: 10/11/2000 
> Feb  2 19:35:01 localhost kernel: System Vendor: Intel. 
> Feb  2 19:35:01 localhost kernel: Product Name: STL2. 
> Feb  2 19:35:01 localhost kernel: Version  . 
> Feb  2 19:35:01 localhost kernel: Serial Number  . 
> Feb  2 19:35:01 localhost kernel: Board Vendor: Intel. 
> Feb  2 19:35:01 localhost kernel: Board Name: STL2. 
> Feb  2 19:35:01 localhost kernel: Board Version: 133-639718. 
> Feb  2 19:35:01 localhost kernel: Asset Tag: 0000000000000000. 
> Feb  2 19:35:01 localhost kernel: Uniform Multi-Platform E-IDE driver
> Revision: 6.31 
> Feb  2 19:35:02 localhost kernel: ide: Assuming 33MHz system bus speed for
> PIO modes; override with idebus=xx 
> Feb  2 19:35:02 localhost kernel: ServerWorks OSB4: IDE controller on PCI
> bus 00 dev 79 
> Feb  2 19:35:02 localhost kernel: ServerWorks OSB4: chipset revision 0 
> Feb  2 19:35:02 localhost kernel: ServerWorks OSB4: not 100% native mode:
> will probe irqs later 
> Feb  2 19:35:02 localhost kernel: hda: SAMSUNG SV2006D fc2_17, ATA DISK
> drive 
> Feb  2 19:35:02 localhost kernel: hdb: TOSHIBA CD-ROM XM-6402B, ATAPI CDROM
> drive 
> Feb  2 19:35:02 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14 
> Feb  2 19:35:02 localhost kernel: hda: 40142592 sectors (20553 MB) w/480KiB
> Cache, CHS=2498/255/63 
> Feb  2 19:35:02 localhost kernel: hdb: ATAPI 32X CD-ROM drive, 256kB Cache 
> Feb  2 19:35:02 localhost kernel: Uniform CD-ROM driver Revision: 3.12 
> Feb  2 19:35:02 localhost kernel: Partition check: 
> Feb  2 19:35:02 localhost kernel:  hda: hda1 hda2 hda3 < hda5 hda6 hda7 > 
> 
> /dev/hda:
>  Model=SAMSUNG SV2006D fc2_17, FwRev=LS100, SerialNo=V7**BT0521
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=32256, SectSize=512, ECCbytes=4
>  BuffType=DualPortCache, BuffSize=480kB, MaxMultSect=16, MultSect=off
>  CurCHS=17475/15/63, CurSects=16513875, LBA=yes, LBAsects=40142592
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes: pio0 pio1 pio2 pio3 pio4 
>  DMA modes: sdma0 sdma1 sdma2 *mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3
> udma4 
> 
> /dev/hda:
>  I/O support  =  0 (default 16-bit)
> 
>            CPU0       CPU1       
>   0:      15519       9063    IO-APIC-edge  timer
>   1:        404        289    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>  12:          0          0    IO-APIC-edge  PS/2 Mouse
>  14:      21517      20366    IO-APIC-edge  ide0
>  18:        138        121   IO-APIC-level  eth0
> NMI:      24511      24512 
> LOC:      24491      24492 
> ERR:          0
> 
> 00:0f.1 IDE interface: Relience Computer: Unknown device 0211 (prog-if 8a
> [Master SecP PriP])
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 set
> 	Region 4: I/O ports at 5440 [size=16]
> 
> 
> ~Randy_________________________________________
> ________________________________________ 
> Michael D. Black wrote:
> Happens every night on both hda and hdc -- no sure yet what triggers it but 
> it is repeatable. Has happened since I've installed this machine with all 
> the 2.4.x series. 
> Jan 31 00:34:16 kernel: hdc: timeout waiting for DMA 
> Jan 31 00:34:16 kernel: ide_dmaproc: chipset supported ide_dma_timeout func 
> only: 14 
> Jan 31 00:34:16 kernel: hdc: irq timeout: status=0x58 { DriveReady 
> SeekComplete DataRequest } 
> Jan 31 00:34:26 kernel: hdc: timeout waiting for DMA 
> Jan 31 00:34:26 kernel: ide_dmaproc: chipset supported ide_dma_timeout func 
> only: 14 
> Jan 31 00:34:26 kernel: hdc: irq timeout: status=0x58 { DriveReady 
> SeekComplete DataRequest } 
> Jan 31 00:34:36 kernel: hdc: timeout waiting for DMA 
> Jan 31 00:34:36 kernel: ide_dmaproc: chipset supported ide_dma_timeout func 
> only: 14 
> Jan 31 00:34:36 kernel: hdc: irq timeout: status=0x58 { DriveReady 
> SeekComplete DataRequest } 
> Jan 31 00:34:46 kernel: hdc: timeout waiting for DMA 
> Jan 31 00:34:46 kernel: ide_dmaproc: chipset supported ide_dma_timeout func 
> only: 14 
> Jan 31 00:34:46 kernel: hdc: irq timeout: status=0x58 { DriveReady 
> SeekComplete DataRequest } 
> Jan 31 00:34:46 kernel: hdc: DMA disabled 
> Jan 31 00:34:46 i kernel: ide1: reset: success 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

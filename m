Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132491AbRCaTu7>; Sat, 31 Mar 2001 14:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132488AbRCaTut>; Sat, 31 Mar 2001 14:50:49 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:39672 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S132485AbRCaTul> convert rfc822-to-8bit; Sat, 31 Mar 2001 14:50:41 -0500
Date: Sat, 31 Mar 2001 21:49:56 +0200 (CEST)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
To: linux-kernel@vger.kernel.org
Subject: via busmaster driver 
Message-ID: <Pine.LNX.4.21.0103312140310.6125-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

when i enable the ultra dma 33 mode on my computer, the disk
performance goes down by around 30 % compared to normal pio mode 4. is
this a bug, or is there any solution to get this ultra dma working
correctly ? this happens with 2.4.2 and 2.4.3 ...
i have a shuttle hot-603 motherboard with the amd640 aka Via Apollo  
VP2/97 chipset. the diskdrive is an Maxtor 33073U4, ATA DISK drive (ultra
dma 66 possible).

any suggestions ?

daniel

lspci output:
00:00.0 Host bridge: VIA Technologies, Inc. VT82C595/97 [Apollo VP2/97]
(rev 03)
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo
VP] (rev 31)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
06)
00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 01)

hdparm -i /dev/hda :

 Model=Maxtor 33073U4, FwRev=BAC51KJ0, SerialNo=N40SZZ8C
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=512kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=60030432
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 

cat /proc/ide/via :

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.20
South Bridge:                       VIA vt82c586b
Revision:                           ISA 0x31 IDE 0x6
BM-DMA base:                        0x6300
PCI clock:                          33MHz
Master Read  Cycle IRDY:            1ws
Master Write Cycle IRDY:            1ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO      UDMA       PIO
Address Setup:       30ns     120ns      30ns      90ns
Cmd Active:          90ns      90ns     330ns     330ns
Cmd Recovery:        30ns      30ns     270ns     270ns
Data Active:         90ns     330ns      90ns     300ns
Data Recovery:       30ns     270ns      30ns     300ns
Cycle Time:          60ns     600ns      60ns     600ns
Transfer Rate:   33.0MB/s   3.3MB/s  33.0MB/s   3.3MB/s

other devices conneted:

Mar 31 19:50:31 hyperion kernel: hda: Maxtor 33073U4, ATA DISK drive
Mar 31 19:50:31 hyperion kernel: hdc: TOSHIBA CD-ROM XM-6702B, ATAPI
CD/DVD-ROM drive
Mar 31 19:50:31 hyperion kernel: hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY
drive

driveroutput during boottime:
Mar 31 19:50:31 hyperion kernel: Uniform Multi-Platform E-IDE driver
Revision: 6.31
Mar 31 19:50:31 hyperion kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx
Mar 31 19:50:31 hyperion kernel: VP_IDE: IDE controller on PCI bus 00 dev
39
Mar 31 19:50:31 hyperion kernel: VP_IDE: chipset revision 6
Mar 31 19:50:31 hyperion kernel: VP_IDE: not 100%% native mode: will probe
irqs later
Mar 31 19:50:31 hyperion kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx
Mar 31 19:50:31 hyperion kernel: VP_IDE: VIA vt82c586b (rev 31) IDE UDMA33
controller on pci00:07.1
Mar 31 19:50:31 hyperion kernel:     ide0: BM-DMA at 0x6300-0x6307, BIOS
settings: hda:pio, hdb:pio
Mar 31 19:50:31 hyperion kernel:     ide1: BM-DMA at 0x6308-0x630f, BIOS
settings: hdc:pio, hdd:pio


***************************************************
Daniel Nofftz
Sysadmin CIP Pool der Informatik 
Universität Trier, V 103
Mail: daniel@nofftz.de
***************************************************

"One World, One Web, One Program" - Microsoft Promotional Ad 
"Ein Volk, Ein Reich, Ein Fuhrer" - Third Reich Promotional Ad


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136126AbRAUMes>; Sun, 21 Jan 2001 07:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136246AbRAUMei>; Sun, 21 Jan 2001 07:34:38 -0500
Received: from KMLinux.fjfi.cvut.cz ([147.32.8.9]:33808 "EHLO
	KMLinux.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id <S136126AbRAUMe1>; Sun, 21 Jan 2001 07:34:27 -0500
Date: Sun, 21 Jan 2001 13:34:09 +0100 (CET)
From: Henryk Paluch <paluch@KMLinux.fjfi.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: kernel hangs on CD-R HP8100i if compiled w/ VIA IDE support.
Message-ID: <Pine.LNX.4.10.10101211333300.17469-100000@KMLinux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks!

The Problem:
  Kernel hangs when accessing CD-R HP8100i if VIA IDE chipset support
  is compiled in.  If VIA IDE is not compiled in kernel, it works.

Tested kernels:
  2.2.16, RedHat 7.0's 2.2.16-22, 2.2.18, 2.2.18 + Andre's IDE patch,
  2.4.0. All tested kernels behave as described. Compiled using kgcc on
  RedHat 7. No other problems.

Hardware:
  MB Microstar K7T Pro2-A (MS-6330) - ATA 100 capable, VIA KT133.
  hda: ATA-100 30GB IBM drive
  hdc: CD-R HP8100i (does not support UDMA modes).
BIOS reports following status:
  "hda" ATA100 mode
  "hdc" PIO3 mode

Kernel 2.4.0 w/ VIA IDE support messages:

 Linux version 2.4.0-via (root@henryk.domain.cz) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Sun Jan 21 11:54:55 CET 2001
 BIOS-provided physical RAM map:
  BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
  BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
  BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
  BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
  BIOS-e820: 0000000007ef0000 @ 0000000000100000 (usable)
  BIOS-e820: 000000000000d000 @ 0000000007ff3000 (ACPI data)
  BIOS-e820: 0000000000003000 @ 0000000007ff0000 (ACPI NVS)
 On node 0 totalpages: 32752
 zone(0): 4096 pages.
 zone(1): 28656 pages.
 zone(2): 0 pages.
 Kernel command line: BOOT_IMAGE=linux.240via ro root=306 BOOT_FILE=/boot/vmlinuz-2.4.0-via
 Initializing CPU#0
 Detected 699.692 MHz processor.
 Console: colour VGA+ 80x25
 Calibrating delay loop... 1395.91 BogoMIPS
 Memory: 126760k/131008k available (917k kernel code, 3860k reserved, 359k data, 192k init, 0k highmem)
 Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
 Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
 Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
 Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
 CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
 CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
 CPU: L2 Cache: 64K (64 bytes/line)
 CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
 CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
 CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000
 CPU: AMD Duron(tm) Processor stepping 01
 Checking 'hlt' instruction... OK.
 POSIX conformance testing by UNIFIX
 mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
 mtrr: detected mtrr type: Intel
 PCI: PCI BIOS revision 2.10 entry at 0xfb250, last bus=1
 PCI: Using configuration type 1
 PCI: Probing PCI hardware
 Linux NET4.0 for Linux 2.4
 Based upon Swansea University Computer Society NET3.039
 DMI 2.2 present.
 38 structures occupying 1029 bytes.
 DMI table at 0x000F0800.
 BIOS Vendor: Award Software International, Inc.
 BIOS Version: 6.00 PG
 BIOS Release: 11/13/00
 System Vendor: MICRO-STAR INTERNATIONAL CO., LTD.
 Product Name: MS-6330.
 Version  .
 Serial Number  .
 Board Vendor: MICRO-STAR INTERNATIONAL CO., LTD.
 Board Name: MS-6330.
 Board Version:  .
 Starting kswapd v1.8
 Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
 SMSC Super-IO detection, now testing Ports 2F0, 370 ...
 parport0: PC-style at 0x378, irq 7 [PCSPP,EPP]
 parport_pc: Via 686A parallel port: io=0x378, irq=7
 pty: 256 Unix98 ptys configured
 Uniform Multi-Platform E-IDE driver Revision: 6.31
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 VP_IDE: IDE controller on PCI bus 00 dev 39
 VP_IDE: chipset revision 6
 VP_IDE: not 100%% native mode: will probe irqs later
 VP_IDE: VIA vt82c686a IDE UDMA66 controller on pci0:7.1
     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
 hda: IBM-DTLA-307030, ATA DISK drive
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 hdc: Hewlett-Packard CD-Writer Plus 8100, ATAPI CDROM drive
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 ide1 at 0x170-0x177,0x376 on irq 15
 hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(33)
 Partition check:
  hda: hda1 hda2 < hda5 hda6 > hda3
  hda3: <solaris: [s0] hda7 [s1] hda8 [s2] hda9 [s7] hda10 >
 Floppy drive(s): fd0 is 1.44M
 FDC 0 is a post-1991 82077
 Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
 ttyS00 at 0x03f8 (irq = 4) is a 16550A
 ttyS01 at 0x02f8 (irq = 3) is a 16550A
 SCSI subsystem driver Revision: 1.00
 NET4: Linux TCP/IP 1.0 for NET4.0
 IP Protocols: ICMP, UDP, TCP, IGMP
 IP: routing cache hash table of 512 buckets, 4Kbytes
 TCP: Hash tables configured (established 8192 bind 8192)
 NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
 ACPI: System description tables found
 ACPI: System description tables loaded
 ACPI: Subsystem enabled
 ACPI: System firmware supports: C2
 ACPI: System firmware supports: S0 S1 S5
 VFS: Mounted root (ext2 filesystem) readonly.
 Freeing unused kernel memory: 192k freed
 Adding Swap: 265032k swap-space (priority -1)
 Via 686a audio driver 1.1.14
 ac97_codec: AC97 Audio codec, id: 0x4943:0x4511 (Unknown)
 via82cxxx: board #1 at 0xDC00, IRQ 11
 MSDOS FS: IO charset iso8859-2
 MSDOS FS: Using codepage 852
 Linux agpgart interface v0.99 (c) Jeff Hartmann
 agpgart: Maximum main memory to use for agp memory: 94M
 agpgart: Detected Via Apollo Pro KT133 chipset
 agpgart: AGP aperture is 64M @ 0xd0000000
 ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
   http://www.scyld.com/network/ne2k-pci.html
 eth0: RealTek RTL-8029 found at 0xe800, IRQ 11, 00:60:52:08:BE:A8.
-------------------------------------------------------------------------
After issuing mount /dev/hdc:

 hdc: lost interrupt
 hdc: ATAPI 24X CD-ROM CD-R/RW drive, 1024kB Cache, DMA
 Uniform CD-ROM driver Revision: 3.12
 hdc: lost interrupt
  
Kernel hangs (num lock not responding, console switching does not work,
no disk activity).

cat /proc/ide/via:

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     2.1e
South Bridge:                       VIA vt82c686a rev 0x40
Command register:                   0x7
Latency timer:                      32
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
FIFO Output Data 1/2 Clock Advance: on
BM IDE Status Register Read Retry:  on
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:           on                  on
End Sect. FIFO flush:          on                  on
Prefetch Buffer:               on                  on
Post Write Buffer:             on                  on
FIFO size:                      8                   8
Threshold Prim.:              1/2                 1/2
Bytes Per Sector:             512                 512
Both channels togth:          yes                 yes
-------------------drive0----drive1----drive2----drive3-----
BMDMA enabled:        yes        no        no        no
Transfer Mode:       UDMA   DMA/PIO   DMA/PIO   DMA/PIO
Address Setup:       30ns     120ns      30ns     120ns
Active Pulse:        90ns     330ns      90ns     330ns
Recovery Time:       30ns     270ns      90ns     270ns
Cycle Time:         120ns     600ns     180ns     600ns
Transfer Rate:   16.5MB/s   3.3MB/s  11.0MB/s   3.3MB/s
------------------------------------------------------------------------------
cat /proc/pci:
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 2).
      Prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 64).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=32.  
      I/O at 0xd000 [0xd00f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 22).
      IRQ 9.
      Master Capable.  Latency=32.  
      I/O at 0xd400 [0xd41f].
  Bus  0, device   7, function  3:
    USB Controller: VIA Technologies, Inc. UHCI USB (#2) (rev 22).
      IRQ 9.
      Master Capable.  Latency=32.  
      I/O at 0xd800 [0xd81f].
  Bus  0, device   7, function  4:
    Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 64).
  Bus  0, device   7, function  5:
    Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 80).
      IRQ 11.
      I/O at 0xdc00 [0xdcff].
      I/O at 0xe000 [0xe003].
      I/O at 0xe400 [0xe403].
  Bus  0, device   9, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS) (rev 0).
      IRQ 11.
      I/O at 0xe800 [0xe81f].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc Rage 128 RF (rev 0).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xd4000000 [0xd7ffffff].
      I/O at 0xc000 [0xc0ff].
      Non-prefetchable 32 bit memory at 0xd9000000 [0xd9003fff].
---------------------------------------------------------------------------

hdparm -i /dev/hda:
/dev/hda:

 Model=IBM-DTLA-307030, FwRev=TX4OA50C, SerialNo=YKDYKTDN632
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=60036480
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 

------------------------------------------------------------------------------
Kernel 2.4.0 without VIA IDE support:

 Linux version 2.4.0-novia (root@henryk.domain.cz) (gcc version
egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #1 Sat Jan 20 11:12:06 CET 2001
 BIOS-provided physical RAM map:
  BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
  BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
  BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
  BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
  BIOS-e820: 0000000007ef0000 @ 0000000000100000 (usable)
  BIOS-e820: 000000000000d000 @ 0000000007ff3000 (ACPI data)
  BIOS-e820: 0000000000003000 @ 0000000007ff0000 (ACPI NVS)
 On node 0 totalpages: 32752
 zone(0): 4096 pages.
 zone(1): 28656 pages.
 zone(2): 0 pages.
 Kernel command line: BOOT_IMAGE=linux.240novia ro root=306 BOOT_FILE=/boot/vmlinuz-2.4.0-novia
 Initializing CPU#0
 Detected 699.676 MHz processor.
 Console: colour VGA+ 80x25
 Calibrating delay loop... 1395.91 BogoMIPS
 Memory: 126772k/131008k available (912k kernel code, 3848k reserved, 355k data, 188k init, 0k highmem)
 Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
 Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
 Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
 Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
 CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
 CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
 CPU: L2 Cache: 64K (64 bytes/line)
 CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
 CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
 CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000
 CPU: AMD Duron(tm) Processor stepping 01
 Checking 'hlt' instruction... OK.
 POSIX conformance testing by UNIFIX
 mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
 mtrr: detected mtrr type: Intel
 PCI: PCI BIOS revision 2.10 entry at 0xfb250, last bus=1
 PCI: Using configuration type 1
 PCI: Probing PCI hardware
 Linux NET4.0 for Linux 2.4
 Based upon Swansea University Computer Society NET3.039
 DMI 2.2 present.
 38 structures occupying 1029 bytes.
 DMI table at 0x000F0800.
 BIOS Vendor: Award Software International, Inc.
 BIOS Version: 6.00 PG
 BIOS Release: 11/13/00
 System Vendor: MICRO-STAR INTERNATIONAL CO., LTD.
 Product Name: MS-6330.
 Version  .
 Serial Number  .
 Board Vendor: MICRO-STAR INTERNATIONAL CO., LTD.
 Board Name: MS-6330.
 Board Version:  .
 Starting kswapd v1.8
 Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
 SMSC Super-IO detection, now testing Ports 2F0, 370 ...
 parport0: PC-style at 0x378, irq 7 [PCSPP,EPP]
 parport_pc: Via 686A parallel port: io=0x378, irq=7
 pty: 256 Unix98 ptys configured
 Uniform Multi-Platform E-IDE driver Revision: 6.31
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 VP_IDE: IDE controller on PCI bus 00 dev 39
 VP_IDE: chipset revision 6
 VP_IDE: not 100%% native mode: will probe irqs later
     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
 hda: IBM-DTLA-307030, ATA DISK drive
 hdc: Hewlett-Packard CD-Writer Plus 8100, ATAPI CDROM drive
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 ide1 at 0x170-0x177,0x376 on irq 15
 hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63
 Partition check:
  hda: hda1 hda2 < hda5 hda6 > hda3
  hda3: <solaris: [s0] hda7 [s1] hda8 [s2] hda9 [s7] hda10 >
 Floppy drive(s): fd0 is 1.44M
 FDC 0 is a post-1991 82077
 Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
 ttyS00 at 0x03f8 (irq = 4) is a 16550A
 ttyS01 at 0x02f8 (irq = 3) is a 16550A
 SCSI subsystem driver Revision: 1.00
 NET4: Linux TCP/IP 1.0 for NET4.0
 IP Protocols: ICMP, UDP, TCP, IGMP
 IP: routing cache hash table of 512 buckets, 4Kbytes
 TCP: Hash tables configured (established 8192 bind 8192)
 NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
 ACPI: System description tables found
 ACPI: System description tables loaded
 ACPI: Subsystem enabled
 ACPI: System firmware supports: C2
 ACPI: System firmware supports: S0 S1 S5
 VFS: Mounted root (ext2 filesystem) readonly.
 Freeing unused kernel memory: 188k freed
 Adding Swap: 265032k swap-space (priority -1)
 MSDOS FS: IO charset iso8859-2
 MSDOS FS: Using codepage 852
 Linux agpgart interface v0.99 (c) Jeff Hartmann
 agpgart: Maximum main memory to use for agp memory: 94M
 agpgart: Detected Via Apollo Pro KT133 chipset
 agpgart: AGP aperture is 64M @ 0xd0000000
 ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
   http://www.scyld.com/network/ne2k-pci.html
 eth0: RealTek RTL-8029 found at 0xe800, IRQ 11, 00:60:52:08:BE:A8.
 hdc: ATAPI 24X CD-ROM CD-R/RW drive, 1024kB Cache
 Uniform CD-ROM driver Revision: 3.12
 Via 686a audio driver 1.1.14
 ac97_codec: AC97 Audio codec, id: 0x4943:0x4511 (Unknown)
 via82cxxx: board #1 at 0xDC00, IRQ 11

hdparm -i /dev/hdc:
/dev/hdc:

 Model=Hewlett-Packard CD-Writer Plus 8100, FwRev=1.0g, SerialNo=PJY1R1N1CG
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:180,w/IORDY:180}, tDMA={min:150,rec:150}
 PIO modes: pio0 pio1 pio2 pio3 
 DMA modes: sdma0 sdma1 sdma2 mdma0 *mdma1 

mount /dev/hdc works without problems.

Notes:
  Kernel reports that BIOS settings for hdc: is DMA,
         however BIOS really reports PIO3.
  Kernel reports hda: UDMA(33) however BIOS reports ATA 100.
  I tried most of other tricks (ide1=noautotune, hdc=nodma etc. but
  it did not help).


Sincerely
    Henryk Paluch, paluch@KMLinux.fjfi.cvut.cz



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

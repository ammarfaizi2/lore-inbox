Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131467AbRBJO11>; Sat, 10 Feb 2001 09:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131468AbRBJO1S>; Sat, 10 Feb 2001 09:27:18 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:50184 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131451AbRBJO1I>; Sat, 10 Feb 2001 09:27:08 -0500
Subject: Easy Way to FS-corruption
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sat, 10 Feb 2001 15:24:06 +0100 (CET)
Reply-To: Tim Krieglstein <tstone@rbg.informatik.tu-darmstadt.de>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=ELM981815046-1008-0_
Content-Transfer-Encoding: 7bit
Message-Id: <E14RawY-0000HB-00@TimeKeeper>
From: Tim Krieglstein <tstone@t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ELM981815046-1008-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII

Hi 

I found a way which seems to lead to an "easy" way of fs-corruption:
Install two sound-cards, use the newest ALSA-Drivers 0.5.10b 
(the standard sound drivers don't work to good with sf) and
talk with speak-freely (7.2) with full-duplex enabled and playing
sound on the first card using xmms.
I nearly get a Message to check the fs on the largest partition by hand
on every boot. Any hints or ideas (please, it's so annoying of "loosing" files
every n-th reboot)?
My configuration:
MSI K7T Pro (VIA KT133) with AMD TB 700
Sound Card #1: Leadtek WinFast 4Xsound (cmi-chipset)
Sound Card #2: Onboard Sound Via Southbridge
Graphics: Geforce 256 DDR
Kernel: 2.4.2-pre1 (I didn't manage to get 2.4.2-pre[23] properly patched)
I didn't touch the ide settings with hdparm but the kernel seems to use
DMA by default:
/dev/hda:
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 3737/255/63, sectors = 60036480, start = 0

Thanks in advance for any hints!
Tim
-- 
It's a damn poor mind that can only think of one way to spell a word. - Andrew Jackson

--ELM981815046-1008-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: attachment; filename=dmesg

Linux version 2.4.2-pre1 (root@TimeKeeper) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #6 Sun Feb 4 13:05:26 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 000000000fef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 000000000fff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 000000000fff0000 (ACPI NVS)
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hdb5 mem=262080K
Initializing CPU#0
Detected 700.038 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1395.91 BogoMIPS
Memory: 255892k/262080k available (754k kernel code, 5800k reserved, 267k data, 188k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb250, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.2 present.
38 structures occupying 1029 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 6.00 PG
BIOS Release: 08/01/00
System Vendor: MICRO-STAR INTERNATIONAL CO., LTD.
Product Name: MS-6330.
Version  .
Serial Number  .
Board Vendor: MICRO-STAR INTERNATIONAL CO., LTD.
Board Name: MS-6330.
Board Version:  .
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 170026kB/56675kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DTLA-307030, ATA DISK drive
hdb: IBM-DTLA-307030, ATA DISK drive
hdc: CD-540E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(66)
hdb: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(66)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >
 hdb: hdb1 < hdb5 hdb6 hdb7 >
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
8139too Fast Ethernet driver 0.9.13 loaded
eth0: RealTek RTL8139 Fast Ethernet at 0xd0800000, 00:50:bf:07:06:ae, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139B'
eth1: RealTek RTL8139 Fast Ethernet at 0xd0802000, 00:30:84:0b:1b:f3, IRQ 10
eth1:  Identified 8139 chip type 'RTL-8139B'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 64M @ 0xd8000000
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 188k freed
Adding Swap: 128484k swap-space (priority -1)
usb.c: registered new driver hub
usb.c: registered new driver usbscanner
scanner.c: USB Scanner support registered.
uhci.c: USB UHCI at I/O 0xc400, IRQ 10
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
uhci.c: USB UHCI at I/O 0xc800, IRQ 10
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
ip_tables: (c)2000 Netfilter core team
ip_conntrack (2047 buckets, 16376 max)
uhci.c: root-hub INT complete: port1: 58a port2: 49b data: 6
hub.c: USB new device connect on bus1/2, assigned device number 3
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
scanner.c: probe_scanner: User specified USB scanner -- Vendor:Product - 4b8:10b
uhci.c: root-hub INT complete: port1: 588 port2: 495 data: 2
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 588 port2: 588 data: 6
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
Real Time Clock Driver v1.10d
parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
parport_pc: Via 686A parallel port: io=0x378, irq=7
lp0: using parport0 (interrupt-driven).
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.1
NVRM: loading NVIDIA kernel module version 1.0-6
NVRM: not using NVAGP, AGPGART is loaded!!

--ELM981815046-1008-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: attachment; filename=pci

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 2).
      Prefetchable 32 bit memory at 0xd8000000 [0xdbffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 34).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 16).
      Master Capable.  Latency=32.  
      I/O at 0xc000 [0xc00f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 16).
      IRQ 10.
      Master Capable.  Latency=32.  
      I/O at 0xc400 [0xc41f].
  Bus  0, device   7, function  3:
    USB Controller: VIA Technologies, Inc. UHCI USB (#2) (rev 16).
      IRQ 10.
      Master Capable.  Latency=32.  
      I/O at 0xc800 [0xc81f].
  Bus  0, device   7, function  4:
    Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 48).
  Bus  0, device   7, function  5:
    Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 32).
      IRQ 9.
      I/O at 0xcc00 [0xccff].
      I/O at 0xd000 [0xd003].
      I/O at 0xd400 [0xd403].
  Bus  0, device   8, function  0:
    SCSI storage controller: Adaptec AIC-7861 (rev 1).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=4.
      I/O at 0xdc00 [0xdcff].
      Non-prefetchable 32 bit memory at 0xdf000000 [0xdf000fff].
  Bus  0, device   9, function  0:
    Multimedia video controller: Brooktree Corporation Bt878 (rev 17).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xdf001000 [0xdf001fff].
  Bus  0, device   9, function  1:
    Multimedia controller: Brooktree Corporation Bt878 (rev 17).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=255.
      Prefetchable 32 bit memory at 0xdf002000 [0xdf002fff].
  Bus  0, device  10, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xe000 [0xe0ff].
      Non-prefetchable 32 bit memory at 0xdf003000 [0xdf0030ff].
  Bus  0, device  14, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (#2) (rev 16).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xe800 [0xe8ff].
      Non-prefetchable 32 bit memory at 0xdf004000 [0xdf0040ff].
  Bus  0, device  12, function  0:
    Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 16).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=24.
      I/O at 0xe400 [0xe4ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation GeForce 256 DDR (rev 16).
      IRQ 5.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xdc000000 [0xdcffffff].
      Prefetchable 32 bit memory at 0xd0000000 [0xd7ffffff].

--ELM981815046-1008-0_--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAIAxd>; Mon, 8 Jan 2001 19:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRAIAxX>; Mon, 8 Jan 2001 19:53:23 -0500
Received: from cd168990-a.ctjams1.mb.wave.home.com ([24.108.112.42]:37761 "EHLO
	cd168990-a.ctjams1.mb.wave.home.com") by vger.kernel.org with ESMTP
	id <S129383AbRAIAxR>; Mon, 8 Jan 2001 19:53:17 -0500
Date: Mon, 8 Jan 2001 18:53:09 -0600
From: Evan Thompson <evaner@bigfoot.com>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Related VIA PCI crazyness?
Message-ID: <20010108185309.A3289@evaner.penguinpowered.com>
Reply-To: evaner@bigfoot.com
Mail-Followup-To: Evan Thompson <evaner@bigfoot.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010107122800.A636@kantaka.co.uk> <93avg9$rlk$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <93avg9$rlk$1@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Jan 07, 2001 at 03:52:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

LINUS:

>  - enable DEBUG in arch/i386/kernel/pci-i386.h
>  - do a "/sbin/lspci -xxvvv" on the interrupt routing chip (it's the
>    "ISA bridge" chip - the VIA numbers are 82c586, 82c596, the PCI
>    numbers for them are 1106:0586 and 1106:0596, I think)
>  - do a cat /proc/pci

Okay, I've attached the following files:

dmesg -> dmesg output of Linux 2.4.0-ac4 (w/extra DEBUG info)
lspci -> output of /sbin/lspci -xxvvv (I'm just attaching the whole
         output, in case I might have selected the wrong device.
         If you still need something, just ask)

procpci -> output of cat /proc/pci

Does this help?

(Like my signature?  It updates itself with the current Linux kernel
version I have installed.  It's quite clever, just a 44 line Perl
script that tries to squeese a uname -a into that...)
-- 
+----------------------------------+-----------------------------------+
| Evan Thompson                    |            POWERED BY:            |
| evaner@bigfoot.com               | Linux cd168990-a 2.4.0-ac4 #1 Sun |
| Freelance Computer Nerd          |  Jan 7 21:25:16 CST 2001 i686     |
| http://evaner.penguinpowered.com |   unknown (w/extra DEBUG info)    |
+----------------------------------+-----------------------------------+

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.4.0-ac4 (root@cd168990-a) (gcc version 2.95.3 20001229 (prerelease)) #1 Sun Jan 7 21:25:16 CST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000009f00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
On node 0 totalpages: 40960
zone(0): 4096 pages.
zone(1): 36864 pages.
zone(2): 0 pages.
Kernel command line: mem=160M ide1=0x170,0x376,15 hdd=ide-scsi root=/dev/hdb5
ide_setup: ide1=0x170,0x376,15

ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 400.939 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 799.53 BogoMIPS
Memory: 158904k/163840k available (1002k kernel code, 4548k reserved, 391k data, 200k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU: Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Celeron (Covington) stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: BIOS32 Service Directory structure at 0xc00fdb40
PCI: BIOS32 Service Directory entry at 0xfdb50
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xfdb71, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: IDE base address fixup for 00:07.1
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00f85f0
00:07 slot=00 0:fe/4000 1:ff/8000 2:00/0000 3:04/deb8
00:08 slot=01 0:01/deb8 1:02/deb8 2:03/deb8 3:04/deb8
00:09 slot=02 0:02/deb8 1:03/deb8 2:04/deb8 3:01/deb8
00:0a slot=03 0:03/deb8 1:04/deb8 2:01/deb8 3:02/deb8
c3:00 slot=72 0:60/0e1e 1:1f/e852 2:93/8b00 3:fa/1f5a
0a:18 slot=05 0:74/3c27 1:f0/0c73 2:e8/feb9 3:0a/74c0
PCI: Scanning for ghost devices on bus 10
PCI: Discovered primary peer bus 0a [IRQ]
PCI: Scanning for ghost devices on bus 195
PCI: Discovered primary peer bus c3 [IRQ]
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
PCI: IRQ fixup
PCI: Allocating resources
PCI: Resource e8000000-ebffffff (f=1208, d=0, p=0)
PCI: Resource 000001f0-000001f7 (f=101, d=0, p=0)
PCI: Resource 000003f6-000003f6 (f=105, d=0, p=0)
PCI: Resource 00000170-00000177 (f=101, d=0, p=0)
PCI: Resource 00000376-00000376 (f=105, d=0, p=0)
PCI: Resource 0000ffa0-0000ffaf (f=101, d=0, p=0)
PCI: Resource 0000df00-0000df1f (f=101, d=0, p=0)
PCI: Resource 0000de80-0000de9f (f=101, d=0, p=0)
PCI: Resource e7000000-e77fffff (f=1208, d=0, p=0)
PCI: Resource efef0000-efefffff (f=200, d=0, p=0)
PCI: Resource 0000cc80-0000ccff (f=101, d=0, p=0)
PCI: Sorting device list...
Activating ISA DMA hang workarounds.
isapnp: Scanning for Pnp cards...
isapnp: Calling quirk for 01:03
isapnp: CMI8330 quirk - fixing interrupts and dma
isapnp: Card 'CMI8330/C3D Audio Adapter'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.0 present.
0 structures occupying 0 bytes.
DMI table at 0x000F0000.
Starting kswapd v1.8
parport0: PC-style at 0x378 [PCSPP(,...)]
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
lp0: console ready
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
IRQ for 00:07.1:0 -> PIRQ fe, mask 4000, excl 0000 -> newirq=14 -> hardcoded IRQ 14
PCI: Hardcoded IRQ 14 for device 00:07.1
VP_IDE: chipset revision 6
VP_IDE: VIA vt82c586b IDE UDMA33 controller on pci0:7.1
VP_IDE: 100% native mode on irq 14
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 83500 A8, ATA DISK drive
hdb: Maxtor 92049U6, ATA DISK drive
hdc: ATAPI CDROM, ATAPI CDROM drive
hdd: ZIPCD 4x650, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 6856072 sectors (3510 MB) w/128KiB Cache, CHS=850/128/63, DMA
hdb: 40026672 sectors (20494 MB) w/2048KiB Cache, CHS=2491/255/63, UDMA(33)
hdc: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p4 < p5 p6 >
 /dev/ide/host0/bus0/target1/lun0: p1 p2 < p5 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
IRQ for 00:09.0:0 -> PIRQ 02, mask deb8, excl 0000 -> newirq=10 -> got IRQ 10
PCI: Found IRQ 10 for device 00:09.0
eth0: RealTek RTL-8029 found at 0xde80, IRQ 10, 52:54:05:F2:1C:84.
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: IOMEGA    Model: ZIPCD 4x650       Rev: 1.04
  Type:   CD-ROM                             ANSI SCSI revision: 02
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: CMI8330/C3D Audio Adapter detected
sb: ISAPnP reports 'CMI8330/C3D Audio Adapter' at i/o 0x220, irq 5, dma 1, 5
sb: 1 Soundblaster PnP card(s) found.
YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft 1993-1996
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 200k freed
Adding Swap: 124952k swap-space (priority -1)
Adding Swap: 40280k swap-space (priority -2)

-- snip of a bunch of UDP transfer errors.  Not of importance --

* This appeared right at the end.  After I made a print job,
  I believe...you might want to look into this as well:

spurious 8259A interrupt: IRQ7.

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 16
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
00: 06 11 91 06 06 00 90 a2 01 00 00 06 00 10 00 00
10: 08 00 00 e8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: efe00000-efefffff
	Prefetchable memory behind bridge: e6c00000-e7cfffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
00: 06 11 98 85 07 00 20 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 c0 c0 00 00
20: e0 ef e0 ef c0 e6 c0 e7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 08 00

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 41)
	Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 06 11 86 05 87 00 00 02 41 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8f [Master SecP SecO PriP PriO])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 14
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374
	Region 4: I/O ports at ffa0 [size=16]
00: 06 11 71 05 05 00 80 02 06 8f 01 01 00 20 00 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0e 01 00 00

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at df00 [size=32]
00: 06 11 38 30 17 01 00 02 02 00 03 0c 08 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 df 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 04 00 00

00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 06 11 40 30 00 00 80 02 10 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at de80 [size=32]
00: ec 10 29 80 03 00 00 02 00 00 00 02 00 00 00 00
10: 81 de 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 (rev 0b) (prog-if 00 [VGA])
	Subsystem: Silicon Integrated Systems [SiS] SiS6326 GUI Accelerator
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min)
	Region 0: Memory at e7000000 (32-bit, prefetchable) [size=8M]
	Region 1: Memory at efef0000 (32-bit, non-prefetchable) [size=64K]
	Region 2: I/O ports at cc80 [size=128]
	Expansion ROM at efee0000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 1.0
		Status: RQ=1 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
00: 39 10 26 63 07 00 30 02 0b 00 00 03 00 40 00 00
10: 08 00 00 e7 00 00 ef ef 81 cc 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 39 10 26 63
30: 00 00 ee ef 40 00 00 00 00 00 00 00 00 00 02 00


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=procpci

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 1).
      Master Capable.  Latency=16.  
      Prefetchable 32 bit memory at 0xe8000000 [0xebffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=8.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 65).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      IRQ 14.
      Master Capable.  Latency=32.  
      I/O at 0x1f0 [0x1f7].
      I/O at 0x3f6 [0x3f6].
      I/O at 0x170 [0x177].
      I/O at 0x376 [0x376].
      I/O at 0xffa0 [0xffaf].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 2).
      IRQ 10.
      Master Capable.  Latency=64.  
      I/O at 0xdf00 [0xdf1f].
  Bus  0, device   7, function  3:
    Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 16).
  Bus  0, device   9, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS) (rev 0).
      IRQ 10.
      I/O at 0xde80 [0xde9f].
  Bus  1, device   0, function  0:
    VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 (rev 11).
      Master Capable.  Latency=64.  Min Gnt=2.
      Prefetchable 32 bit memory at 0xe7000000 [0xe77fffff].
      Non-prefetchable 32 bit memory at 0xefef0000 [0xefefffff].
      I/O at 0xcc80 [0xccff].

--ikeVEW9yuYc//A+q--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

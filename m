Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316629AbSHGBpE>; Tue, 6 Aug 2002 21:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316662AbSHGBpD>; Tue, 6 Aug 2002 21:45:03 -0400
Received: from mirapoint3.brutele.be ([212.68.203.242]:29282 "EHLO
	mirapoint3.brutele.be") by vger.kernel.org with ESMTP
	id <S316629AbSHGBo6>; Tue, 6 Aug 2002 21:44:58 -0400
Date: Wed, 7 Aug 2002 03:48:31 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at page_alloc.c:113!
Message-Id: <20020807034831.2fa1823f.stephane.wirtel@belgacom.net>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi !

i have a small bug with 2.4.19-ac4, i did'nt test with 2.4.19 only

there are many logs, dmesg.log, lspci.log and lsmod.log

the bug is in linux/mm/page_alloc at line 113

stéphane wirtel 

Linux version 2.4.19-ac4 (root@stargate.lan) (version gcc 2.95.3 20010315 (release)) #1 lun aoû 5 14:19:34 Local time zone must be set--see zic manua
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fffc000 (usable)
 BIOS-e820: 000000000fffc000 - 000000000ffff000 (ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65532
zone(0): 4096 pages.
zone(1): 61436 pages.
zone(2): 0 pages.
Kernel command line: vga=791 hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 1732.890 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 3460.30 BogoMIPS
Memory: 256264k/262128k available (1272k kernel code, 5476k reserved, 388k data, 236k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=32033 max_file_pages=0 max_inodes=0 max_dentries=32033
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383fbff c1c3fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1c3fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(TM) XP 2100+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1aa0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/3147] at 00:11.0
PnPBIOS: Found PnP BIOS installation structure at 0xc00f9c60
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9c90, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
PnPBIOS: PNP0c02: ioport range 0x290-0x297 has been reserved
PnPBIOS: PNP0c02: ioport range 0x3f0-0x3f1 has been reserved
PnPBIOS: PNP0c02: ioport range 0xe400-0xe47f has been reserved
PnPBIOS: PNP0c02: ioport range 0xec00-0xec3f has been reserved
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
devfs: v1.12a (20020514) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
 tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:...............................................................................................
95 Control Methods found and parsed (277 nodes total)
ACPI Namespace successfully loaded at root c02ec460
ACPI: Core Subsystem version [20011018]
evxfevnt-0081 [02] Acpi_enable           : Transition to ACPI mode successful
Executing device _INI methods:.........................................
41 Devices found: 41 _STA, 0 _INI
Completing Region and Field initialization:....
4/9 Regions, 0/0 Fields initialized (277 nodes total)
ACPI: Subsystem enabled
vesafb: framebuffer at 0xd8000000, mapped to 0xd0809000, size 32768k
vesafb: mode is 1024x768x16, linelength=2048, pages=0
vesafb: protected mode interface info at c000:0f3e
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 512 Unix98 ptys configured
Real Time Clock Driver v1.10e
block: 496 slots per queue, batch=124
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using pci=biosirq.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD800BB-00CCB0, ATA DISK drive
hdb: TOSHIBA DVD-ROM SD-M1502, ATAPI CD/DVD-ROM drive
hdc: PLEXTOR CD-R PX-W2410A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, UDMA(100)
hdb: ATAPI 48X DVD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Via Apollo Pro KT266 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
ide-floppy driver 0.99.newide
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PLEXTOR   Model: CD-R   PX-W2410A  Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
arp_tables: (C) 2002 David S. Miller
reiserfs: checking transaction log (device 03:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 236k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 1461904k swap-space (priority -1)
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS 2.4-0.9.18, 14 May 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
via-rhine.c:v1.10-LK1.1.14  May-3-2002  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
PCI: Found IRQ 11 for device 00:0d.0
PCI: Sharing IRQ 11 with 00:09.1
PCI: Sharing IRQ 11 with 01:00.0
eth0: VIA VT6102 Rhine-II at 0xd5000000, 00:50:ba:2e:ee:62, IRQ 11.
eth0: MII PHY found at address 8, status 0x782d advertising 01e1 Link 45e1.
eth0: Setting full-duplex based on MII #8 link partner capability of 45e1.
nvidia: loading NVIDIA NVdriver Kernel Module  1.0-2960  Tue May 14 07:41:42 PDT 2002
NVRM: AGPGART: VIA Apollo KT133 chipset
NVRM: AGPGART: aperture: 64M @ 0xe0000000
NVRM: AGPGART: aperture mapped from 0xe0000000 to 0xd3b05000
NVRM: AGPGART: mode 4x
NVRM: AGPGART: allocated 16 pages
ISO 9660 Extensions: Microsoft Joliet Level 1
ISO 9660 Extensions: RRIP_1991A
spurious 8259A interrupt: IRQ7.
NVRM: AGPGART: freed 16 pages
NVRM: AGPGART: backend released
NVRM: AGPGART: VIA Apollo KT133 chipset
NVRM: AGPGART: aperture: 64M @ 0xe0000000
NVRM: AGPGART: aperture mapped from 0xe0000000 to 0xd3aed000
NVRM: AGPGART: mode 4x
NVRM: AGPGART: allocated 16 pages
NVRM: AGPGART: freed 16 pages
NVRM: AGPGART: backend released
NVRM: AGPGART: VIA Apollo KT133 chipset
NVRM: AGPGART: aperture: 64M @ 0xe0000000
NVRM: AGPGART: aperture mapped from 0xe0000000 to 0xd3b05000
NVRM: AGPGART: mode 4x
NVRM: AGPGART: allocated 16 pages
NVRM: AGPGART: freed 16 pages
NVRM: AGPGART: backend released
kernel BUG at page_alloc.c:113!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012ed6e>]    Tainted: P 
EFLAGS: 00013286
eax: 0100001c   ebx: c11c30e0   ecx: c0291d5c   edx: 00000000
esi: 00000000   edi: 00007000   ebp: cac7def8   esp: cac7dec4
ds: 0018   es: 0018   ss: 0018
Process X (pid: 5360, stackpage=cac7d000)
Stack: c11c30e0 00008000 00007000 c02e8140 cac7defc c013004c 0009ae00 c11c30e0 
       00000000 00000001 c11c30e0 00008000 c11c30e0 cac7df00 c012f5be cac7df0c 
       c012fa95 c11c30e0 cac7df1c c0122f32 c11c30e0 c5ce8894 cac7df60 c012337b 
Call Trace:    [<c013004c>] [<c012f5be>] [<c012fa95>] [<c0122f32>] [<c012337b>]
  [<c01256ee>] [<c01257bd>] [<c0108933>]

Code: 0f 0b 71 00 87 da 24 c0 8b 43 18 24 eb 89 43 18 c6 43 24 05 


Module                  Size  Used by    Tainted: P  
isofs                  24832   1  (autoclean)
zlib_inflate           18368   0  (autoclean) [isofs]
NVdriver              989184   2  (autoclean)
af_packet              11848   1  (autoclean)
via-rhine              14696   1 
mii                     1152   0  [via-rhine]
usbcore                61504   1 
ext3                   58080   1  (autoclean)
jbd                    36272   1  (autoclean) [ext3]
unix                   13764   3  (autoclean)

 
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
	Subsystem: Asustek Computer, Inc. A7V333
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x4
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT333 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: d6000000-d7dfffff
	Prefetchable memory behind bridge: d7f00000-dfffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: Asustek Computer, Inc. CMI8738 6ch-MX
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at d800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at d5800000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 43)
	Subsystem: D-Link System Inc DFE-530TX rev A
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at b800 [size=256]
	Region 1: Memory at d5000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at b400 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 6
	Region 4: I/O ports at b000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 6
	Region 4: I/O ports at a800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX] (rev b2) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at d7ff0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=x4



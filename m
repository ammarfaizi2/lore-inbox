Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbUL0RNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbUL0RNF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 12:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUL0RNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 12:13:05 -0500
Received: from rekin10.go2.pl ([193.17.41.30]:24216 "EHLO r10.go2.pl")
	by vger.kernel.org with ESMTP id S261930AbUL0RMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 12:12:00 -0500
From: =?iso-8859-2?Q?Fryderyk_Mazurek?= <dedyk@go2.pl>
To: linux-kernel@vger.kernel.org
Subject: =?iso-8859-2?Q?Problems_with_2.6.10?=
Date: Mon, 27 Dec 2004 18:11:59 +0100
Content-Type: text/plain; charset="iso-8859-2";
Content-Transfer-Encoding: 8bit
X-Mailer: o2.pl WebMail v5.27
X-Originator: 83.31.183.111
Message-Id: <20041227171159.51454193BFA@r10.go2.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone!

I have so strange problem with kernel 2.6.10. Kernel works good, but
problem starts when I do reboot. On boot screen my bios can't detect
my disk. Bios stops and nothing. So without end. Button reset on my
towel can't fix it. To fix this situation I must turn off and turn
on my computer. Only it helps. With kernel 2.6.9 wasn't so problem.
How to fix it?

I send my /proc/cpuinfo (all these informations from kernel 2.6.9):
-------------------------
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 5
model		: 8
model name	: AMD-K6(tm) 3D processor
stepping	: 12
cpu MHz		: 451.145
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips	: 886.78
-------------------------

/proc/iomem
-------------------------
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03feffff : System RAM
  00100000-0035096c : Kernel code
  0035096d-004426ff : Kernel data
03ff0000-03ff07ff : ACPI Non-volatile Storage
03ff0800-03ffffff : ACPI Tables
e0000000-e3ffffff : 0000:00:00.0
e4000000-e5ffffff : PCI Bus #01
  e5000000-e5000fff : 0000:01:00.0
e6000000-e6ffffff : PCI Bus #01
  e6000000-e6ffffff : 0000:01:00.0
e7000000-e70000ff : 0000:00:09.0
ffff0000-ffffffff : reserved
-------------------------

/proc/ioports:
-------------------------
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : ISAPnP
0300-0301 : MPU401 UART
0376-0376 : ide1
0388-0389 : OPL2/3 (left)
038a-038b : OPL2/3 (right)
03c0-03df : vga+
03f6-03f6 : ide0
0500-050f : AD1816A
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
6000-60ff : 0000:00:07.3
  6000-6003 : PM1a_EVT_BLK
  6004-6005 : PM1a_CNT_BLK
  6008-600b : PM_TMR
  6020-6023 : GPE0_BLK
c000-cfff : PCI Bus #01
  c000-c0ff : 0000:01:00.0
e000-e01f : 0000:00:07.2
  e000-e01f : uhci_hcd
e400-e40f : 0000:00:07.1
  e400-e407 : ide0
  e408-e40f : ide1
-------------------------

Command lspci -vvv:
-------------------------
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3]
(rev 04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
	Latency: 16
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=8 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e4000000-e5ffffff
	Prefetchable memory behind bridge: e6000000-e6ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA
[Apollo VP] (rev 41)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev
06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at e400 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 02) (prog-if
00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at e000 [size=32]

00:07.3 PCI bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
(prog-if 00 [Normal decode])
	!!! Invalid class 0604 for header type 00
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:09.0 Communication controller: Analog Devices SM56 PCI modem
	Subsystem: Analog Devices SM56 PCI modem
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
	Latency: 64 (250ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e7000000 (32-bit, prefetchable) [size=256]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0+,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC
AGP (rev 3a) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0088
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Region 0: Memory at e6000000 (32-bit, prefetchable) [size=16M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
-------------------------

And at the end a part from log file (kernel 2.6.10):
-------------------------
Dec 27 17:13:15 frycek kernel: Linux version 2.6.10
(root@frycek.com.pl) (gcc version 3.4.3 (Mandrakelinux 10.2
3.4.3-1mdk)) #2 Mon Dec 27 16:56:31 CET 2004
Dec 27 17:13:15 frycek kernel: BIOS-provided physical RAM map:
Dec 27 17:13:15 frycek kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00 (usable)
Dec 27 17:13:15 frycek kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000 (reserved)
Dec 27 17:13:15 frycek kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved)
Dec 27 17:13:15 frycek kernel:  BIOS-e820: 0000000000100000 -
0000000003ff0000 (usable)
Dec 27 17:13:15 frycek kernel:  BIOS-e820: 0000000003ff0000 -
0000000003ff0800 (ACPI NVS)
Dec 27 17:13:15 frycek kernel:  BIOS-e820: 0000000003ff0800 -
0000000004000000 (ACPI data)
Dec 27 17:13:15 frycek kernel:  BIOS-e820: 00000000ffff0000 -
0000000100000000 (reserved)
Dec 27 17:13:15 frycek kernel: 63MB LOWMEM available.
Dec 27 17:13:15 frycek kernel: On node 0 totalpages: 16368
Dec 27 17:13:15 frycek kernel:   DMA zone: 4096 pages, LIFO batch:1
Dec 27 17:13:15 frycek kernel:   Normal zone: 12272 pages, LIFO batch:2
Dec 27 17:13:15 frycek kernel:   HighMem zone: 0 pages, LIFO batch:1
Dec 27 17:13:15 frycek kernel: DMI 2.1 present.
Dec 27 17:13:15 frycek kernel: Built 1 zonelists
Dec 27 17:13:15 frycek kernel: Kernel command line:
BOOT_IMAGE=Linux-2.6.10 ro root=341
Dec 27 17:13:15 frycek kernel: No local APIC present or hardware
disabled
Dec 27 17:13:15 frycek kernel: mapped APIC to ffffd000 (01081000)
Dec 27 17:13:15 frycek kernel: Initializing CPU#0
Dec 27 17:13:15 frycek kernel: PID hash table entries: 256 (order:
8, 4096 bytes)
Dec 27 17:13:15 frycek kernel: Detected 451.131 MHz processor.
Dec 27 17:13:15 frycek kernel: Using tsc for high-res timesource
Dec 27 17:13:15 frycek kernel: Console: colour VGA+ 80x25
Dec 27 17:13:15 frycek kernel: Dentry cache hash table entries:
16384 (order: 4, 65536 bytes)
Dec 27 17:13:15 frycek kernel: Inode-cache hash table entries: 8192
(order: 3, 32768 bytes)
Dec 27 17:13:15 frycek kernel: Memory: 60956k/65472k available
(2217k kernel code, 4060k reserved, 872k data, 156k init, 0k highmem)
Dec 27 17:13:15 frycek kernel: Checking if this processor honours
the WP bit even in supervisor mode... Ok.
Dec 27 17:13:15 frycek kernel: Calibrating delay loop... 888.83
BogoMIPS (lpj=444416)
Dec 27 17:13:15 frycek kernel: Mount-cache hash table entries: 512
(order: 0, 4096 bytes)
Dec 27 17:13:15 frycek kernel: CPU: After generic identify, caps:
008021bf 808029bf 00000000 00000000
Dec 27 17:13:15 frycek kernel: CPU: After vendor identify, caps: 
008021bf 808029bf 00000000 00000000
Dec 27 17:13:15 frycek kernel: CPU: L1 I Cache: 32K (32 bytes/line),
D cache 32K (32 bytes/line)
Dec 27 17:13:15 frycek kernel: CPU: After all inits, caps:       
008021bf 808029bf 00000000 00000002
Dec 27 17:13:15 frycek kernel: CPU: AMD-K6(tm) 3D processor stepping 0c
Dec 27 17:13:15 frycek kernel: Checking 'hlt' instruction... OK.
Dec 27 17:13:15 frycek kernel: NET: Registered protocol family 16
Dec 27 17:13:15 frycek kernel: PCI: PCI BIOS revision 2.10 entry at
0xfb360, last bus=2
Dec 27 17:13:15 frycek kernel: PCI: Using configuration type 1
Dec 27 17:13:15 frycek kernel: mtrr: v2.0 (20020519)
Dec 27 17:13:15 frycek kernel: Linux Plug and Play Support v0.97 (c)
Adam Belay
Dec 27 17:13:15 frycek kernel: PnPBIOS: Scanning system for PnP BIOS
support...
Dec 27 17:13:15 frycek kernel: PnPBIOS: Found PnP BIOS installation
structure at 0xc00fbf90
Dec 27 17:13:15 frycek kernel: PnPBIOS: PnP BIOS version 1.0, entry
0xf0000:0xbfb8, dseg 0xf0000
Dec 27 17:13:15 frycek kernel: PnPBIOS: 16 nodes reported by PnP
BIOS; 16 recorded by driver
Dec 27 17:13:15 frycek kernel: PCI: Probing PCI hardware
Dec 27 17:13:15 frycek kernel: PCI: Probing PCI hardware (bus 00)
Dec 27 17:13:15 frycek kernel: PCI: 0000:00:07.3: class 604 doesn't
match header type 00. Ignoring class.
Dec 27 17:13:15 frycek kernel: PCI: Using IRQ router VIA [1106/0586]
at 0000:00:07.0
Dec 27 17:13:15 frycek kernel: pnp: the driver 'system' has been
registered
Dec 27 17:13:15 frycek kernel: pnp: match found with the PnP device
'00:07' and the driver 'system'
Dec 27 17:13:15 frycek kernel: pnp: match found with the PnP device
'00:08' and the driver 'system'
Dec 27 17:13:15 frycek kernel: pnp: match found with the PnP device
'00:0b' and the driver 'system'
Dec 27 17:13:15 frycek kernel: pnp: 00:0b: ioport range 0x208-0x20f
has been reserved
Dec 27 17:13:15 frycek kernel: Total HugeTLB memory allocated, 0
Dec 27 17:13:15 frycek kernel: VFS: Disk quotas dquot_6.5.1
Dec 27 17:13:15 frycek kernel: Dquot-cache hash table entries: 1024
(order 0, 4096 bytes)
Dec 27 17:13:15 frycek kernel: devfs: 2004-01-31 Richard Gooch
(rgooch@atnf.csiro.au)
Dec 27 17:13:15 frycek kernel: devfs: boot_options: 0x1
Dec 27 17:13:15 frycek kernel: NTFS driver 2.1.22 [Flags: R/O DEBUG].
Dec 27 17:13:15 frycek kernel: Initializing Cryptographic API
Dec 27 17:13:15 frycek kernel: Activating ISA DMA hang workarounds.
Dec 27 17:13:15 frycek kernel: pci_hotplug: PCI Hot Plug PCI Core
version: 0.5
Dec 27 17:13:15 frycek kernel: vesafb: probe of vesafb0 failed with
error -6
Dec 27 17:13:15 frycek kernel: vga16fb: initializing
Dec 27 17:13:15 frycek kernel: vga16fb: mapped to 0xc00a0000
Dec 27 17:13:15 frycek kernel: fb0: VGA16 VGA frame buffer device
Dec 27 17:13:15 frycek kernel: isapnp: Scanning for PnP cards...
Dec 27 17:13:15 frycek kernel: isapnp: Card 'Analog Devices AD1816A'
Dec 27 17:13:15 frycek kernel: isapnp: 1 Plug & Play card detected total
Dec 27 17:13:15 frycek kernel: HDLC line discipline: version
$Revision: 4.8 $, maxframe=4096
Dec 27 17:13:15 frycek kernel: N_HDLC line discipline registered.
Dec 27 17:13:15 frycek kernel: Linux agpgart interface v0.100 (c)
Dave Jones
Dec 27 17:13:15 frycek kernel: agpgart: Detected VIA Apollo MVP3 chipset
Dec 27 17:13:15 frycek kernel: agpgart: Maximum main memory to use
for agp memory: 27M
Dec 27 17:13:15 frycek kernel: agpgart: AGP aperture is 64M @ 0xe0000000
Dec 27 17:13:15 frycek kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Dec 27 17:13:15 frycek kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Dec 27 17:13:15 frycek kernel: io scheduler noop registered
Dec 27 17:13:15 frycek kernel: divert: not allocating divert_blk for
non-ethernet device lo
Dec 27 17:13:15 frycek kernel: PPP generic driver version 2.4.2
Dec 27 17:13:15 frycek kernel: PPP Deflate Compression module registered
Dec 27 17:13:15 frycek kernel: PPP BSD Compression module registered
Dec 27 17:13:15 frycek kernel: NET: Registered protocol family 24
Dec 27 17:13:15 frycek kernel: Uniform Multi-Platform E-IDE driver
Revision: 7.00alpha2
Dec 27 17:13:15 frycek kernel: ide: Assuming 33MHz system bus speed
for PIO modes; override with idebus=xx
Dec 27 17:13:15 frycek kernel: VP_IDE: IDE controller at PCI slot
0000:00:07.1
Dec 27 17:13:15 frycek kernel: VP_IDE: chipset revision 6
Dec 27 17:13:15 frycek kernel: VP_IDE: not 100%% native mode: will
probe irqs later
Dec 27 17:13:15 frycek kernel: VP_IDE: VIA vt82c586b (rev 41) IDE
UDMA33 controller on pci0000:00:07.1
Dec 27 17:13:15 frycek kernel:     ide0: BM-DMA at 0xe400-0xe407,
BIOS settings: hda:DMA, hdb:DMA
Dec 27 17:13:15 frycek kernel:     ide1: BM-DMA at 0xe408-0xe40f,
BIOS settings: hdc:DMA, hdd:DMA
Dec 27 17:13:15 frycek kernel: Probing IDE interface ide0...
Dec 27 17:13:15 frycek kernel: hda: ST320413A, ATA DISK drive
Dec 27 17:13:15 frycek kernel: hdb: ST340810A, ATA DISK drive
Dec 27 17:13:15 frycek kernel: elevator: using noop as default io
scheduler
Dec 27 17:13:15 frycek kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec 27 17:13:15 frycek kernel: Probing IDE interface ide1...
Dec 27 17:13:15 frycek kernel: ide1: Wait for ready failed before
probe !
Dec 27 17:13:15 frycek kernel: hdc: ATAPI CD-ROM DRIVE 32X MAXIMUM,
ATAPI CD/DVD-ROM drive
Dec 27 17:13:15 frycek kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec 27 17:13:15 frycek kernel: Probing IDE interface ide2...
Dec 27 17:13:15 frycek kernel: ide2: Wait for ready failed before
probe !
Dec 27 17:13:15 frycek kernel: Probing IDE interface ide3...
Dec 27 17:13:15 frycek kernel: ide3: Wait for ready failed before
probe !
Dec 27 17:13:15 frycek kernel: Probing IDE interface ide4...
Dec 27 17:13:15 frycek kernel: ide4: Wait for ready failed before
probe !
Dec 27 17:13:15 frycek kernel: Probing IDE interface ide5...
Dec 27 17:13:15 frycek kernel: ide5: Wait for ready failed before
probe !
Dec 27 17:13:15 frycek kernel: hda: max request size: 128KiB
Dec 27 17:13:15 frycek kernel: hda: 39102336 sectors (20020 MB)
w/512KiB Cache, CHS=38792/16/63, UDMA(33)
Dec 27 17:13:15 frycek kernel: hda: cache flushes not supported
Dec 27 17:13:15 frycek kernel:  /dev/ide/host0/bus0/target0/lun0: p1
p2 p3 p4
Dec 27 17:13:15 frycek kernel: hdb: max request size: 128KiB
Dec 27 17:13:15 frycek kernel: hdb: Host Protected Area detected.
Dec 27 17:13:15 frycek kernel: ^Icurrent capacity is 66055248
sectors (33820 MB)
Dec 27 17:13:15 frycek kernel: ^Inative  capacity is 78165360
sectors (40020 MB)
Dec 27 17:13:15 frycek kernel: hdb: Host Protected Area disabled.
Dec 27 17:13:15 frycek kernel: hdb: 78165360 sectors (40020 MB)
w/2048KiB Cache, CHS=65535/16/63, UDMA(33)
Dec 27 17:13:15 frycek kernel: hdb: cache flushes not supported
Dec 27 17:13:15 frycek kernel:  /dev/ide/host0/bus0/target1/lun0: p1
p2 p3 p4 < p5 p6 p7 p8 >
Dec 27 17:13:15 frycek kernel: hdc: ATAPI 27X CD-ROM drive, 120kB Cache
Dec 27 17:13:15 frycek kernel: Uniform CD-ROM driver Revision: 3.20
Dec 27 17:13:15 frycek kernel: mice: PS/2 mouse device common for
all mice
Dec 27 17:13:15 frycek kernel: input: AT Translated Set 2 keyboard
on isa0060/serio0
Dec 27 17:13:15 frycek kernel: input: PS/2 Generic Mouse on
isa0060/serio1
Dec 27 17:13:15 frycek kernel: input: PC Speaker
Dec 27 17:13:15 frycek kernel: NET: Registered protocol family 2
Dec 27 17:13:15 frycek kernel: IP: routing cache hash table of 512
buckets, 4Kbytes
Dec 27 17:13:15 frycek kernel: TCP: Hash tables configured
(established 4096 bind 8192)
Dec 27 17:13:15 frycek kernel: ip_tables: (C) 2000-2002 Netfilter
core team
Dec 27 17:13:15 frycek kernel: NET: Registered protocol family 1
Dec 27 17:13:15 frycek kernel: NET: Registered protocol family 10
Dec 27 17:13:15 frycek kernel: IPv6 over IPv4 tunneling driver
Dec 27 17:13:15 frycek kernel: divert: not allocating divert_blk for
non-ethernet device sit0
Dec 27 17:13:15 frycek kernel: NET: Registered protocol family 17
Dec 27 17:13:15 frycek kernel: NET: Registered protocol family 15
Dec 27 17:13:15 frycek kernel: NET: Registered protocol family 8
Dec 27 17:13:15 frycek kernel: NET: Registered protocol family 20
Dec 27 17:13:15 frycek kernel: EXT3-fs: mounted filesystem with
ordered data mode.
Dec 27 17:13:15 frycek kernel: VFS: Mounted root (ext3 filesystem)
readonly.
Dec 27 17:13:15 frycek kernel: kjournald starting.  Commit interval
5 seconds
Dec 27 17:13:15 frycek kernel: Mounted devfs on /dev
Dec 27 17:13:15 frycek kernel: Freeing unused kernel memory: 156k freed
Dec 27 17:13:15 frycek kernel: Real Time Clock Driver v1.12
Dec 27 17:13:15 frycek kernel: EXT3 FS on hdb1, internal journal
Dec 27 17:13:15 frycek kernel: Adding 122968k swap on /dev/hdb2. 
Priority:-1 extents:1
Dec 27 17:13:15 frycek kernel: EXT3 FS on hdb1, internal journal
Dec 27 17:13:15 frycek kernel: kjournald starting.  Commit interval
5 seconds
Dec 27 17:13:15 frycek kernel: EXT3 FS on hda4, internal journal
Dec 27 17:13:15 frycek kernel: EXT3-fs: mounted filesystem with
ordered data mode.
Dec 27 17:13:15 frycek kernel: kjournald starting.  Commit interval
5 seconds
Dec 27 17:13:15 frycek kernel: EXT3 FS on hda2, internal journal
Dec 27 17:13:15 frycek kernel: EXT3-fs: mounted filesystem with
ordered data mode.
Dec 27 17:13:15 frycek kernel: kjournald starting.  Commit interval
5 seconds
Dec 27 17:13:15 frycek kernel: EXT3 FS on hda3, internal journal
Dec 27 17:13:15 frycek kernel: EXT3-fs: mounted filesystem with
ordered data mode.
Dec 27 17:13:15 frycek kernel: NTFS volume version 3.0.
Dec 27 17:13:15 frycek kernel: ReiserFS: hdb5: found reiserfs format
"3.6" with standard journal
Dec 27 17:13:15 frycek kernel: ReiserFS: hdb5: using ordered data mode
Dec 27 17:13:15 frycek kernel: ReiserFS: hdb5: journal params:
device hdb5, size 8192, journal first block 18, max trans len 1024,
max batch 900, max commit age 30, max trans age 30
Dec 27 17:13:15 frycek kernel: ReiserFS: hdb5: checking transaction
log (hdb5)
Dec 27 17:13:15 frycek kernel: ReiserFS: hdb5: Using r5 hash to sort
names
Dec 27 17:13:15 frycek kernel: kjournald starting.  Commit interval
5 seconds
Dec 27 17:13:15 frycek kernel: EXT3 FS on hdb6, internal journal
Dec 27 17:13:15 frycek kernel: EXT3-fs: mounted filesystem with
ordered data mode.
Dec 27 17:13:15 frycek kernel: kjournald starting.  Commit interval
5 seconds
Dec 27 17:13:15 frycek kernel: EXT3 FS on hdb7, internal journal
Dec 27 17:13:15 frycek kernel: EXT3-fs: mounted filesystem with
ordered data mode.
Dec 27 17:13:15 frycek kernel: EXT3 FS on hdb1, internal journal
Dec 27 17:13:15 frycek kernel: Disabled Privacy Extensions on device
c03d1ac0(lo)
-------------------------

Fryderyk.

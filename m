Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285165AbRLMUpE>; Thu, 13 Dec 2001 15:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285166AbRLMUoz>; Thu, 13 Dec 2001 15:44:55 -0500
Received: from relais.videotron.ca ([24.201.245.36]:16824 "EHLO
	VL-MS-MR001.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S285165AbRLMUom> convert rfc822-to-8bit; Thu, 13 Dec 2001 15:44:42 -0500
Date: Thu, 13 Dec 2001 15:43:56 -0500 (EST)
From: Denis Pelletier <denis.pelletier@umontreal.ca>
X-X-Sender: dpel@maniwaki.dyndns.org
To: linux-kernel@vger.kernel.org
Subject: IRQ routing conflict with Presario 700
Message-ID: <Pine.LNX.4.40.0112131538090.8256-100000@maniwaki.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A few weeks ago there was a discussion about an irq routing conflict with
a Compaq Presario 700 laptop (Via integrated chipset KN133). As a
by-product, the sound on this laptop is non-operational (with both the
kernel module via82cxxx_audio and ALSA snd-card-via686a). The BIOS of
this machine does not have a "non-pnp OS" option. At that time Jeff Garzik
asked for 'dmesg -s 16384' output with #define DEBUG 1 in pci-i386.h. I
bought the same laptop and that problem still exist with kernel 2.4.16 so
I'm providing the information asked:

Linux version 2.4.16denis (root@mobile.dyndns.org) (gcc version 2.96 20000731
(Mandrake Linux 8.2 2.96-0.69mdk)) #1 Thu Dec 13 14:34:02 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eef0000 (usable)
 BIOS-e820: 000000000eef0000 - 000000000eeff000 (ACPI data)
 BIOS-e820: 000000000eeff000 - 000000000ef00000 (ACPI NVS)
 BIOS-e820: 000000000ef00000 - 000000000f000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
On node 0 totalpages: 61440
zone(0): 4096 pages.
zone(1): 57344 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: 3 root=/dev/hda6  devfs=mount acpi=off vga=791
Initializing CPU#0
Detected 896.901 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1789.13 BogoMIPS
Memory: 239636k/245760k available (1050k kernel code, 5668k reserved, 316k data, 216k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383fbff c1c7fbff 00000000, vendor = 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1c7fbff 00000000 00000000
CPU:     After generic, caps: 0383fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c7fbff 00000000 00000000
CPU: AMD Mobile AMD Duron(tm) Processor stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 896.8554 MHz.
..... host bus clock speed is 199.3012 MHz.
cpu: 0, clocks: 1993012, slice: 996506
CPU0<T0:1993008,T1:996496,D:6,S:996506,C:1993012>
PCI: BIOS32 Service Directory structure at 0xc00f6d90
PCI: BIOS32 Service Directory entry at 0xfd690
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xfd7ae, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: IDE base address fixup for 00:07.1
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
Unknown bridge resource 0: assuming transparent
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00fdf50
00:09 slot=00 0:55/0010 1:57/0200 2:00/def8 3:00/def8
00:0b slot=00 0:56/0800 1:00/def8 2:00/def8 3:00/def8
00:0a slot=00 0:56/0800 1:00/def8 2:00/def8 3:00/def8
00:13 slot=00 0:55/0010 1:00/def8 2:00/def8 3:00/def8
00:00 slot=00 0:56/0020 1:00/def8 2:00/def8 3:00/def8
00:07 slot=00 0:55/0010 1:56/0800 2:56/0020 3:57/0200
00:01 slot=00 0:56/0020 1:00/def8 2:00/def8 3:00/def8
PCI: Attempting to find IRQ router for 1106:0596
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: IRQ fixup
00:0a.0: ignoring bogus IRQ 255
IRQ for 00:0a.0:0 -> PIRQ 56, mask 0800, excl 0000 -> newirq=0 ... failed
PCI: Allocating resources
PCI: Resource ec000000-efffffff (f=1208, d=0, p=0)
PCI: Resource 00001840-0000184f (f=101, d=0, p=0)
PCI: Resource 00001800-0000181f (f=101, d=0, p=0)
PCI: Resource 00001000-000010ff (f=101, d=0, p=0)
PCI: Resource 00001854-00001857 (f=105, d=0, p=0)
PCI: Resource 00001850-00001853 (f=101, d=0, p=0)
PCI: Resource e8000000-e800ffff (f=200, d=0, p=0)
PCI: Resource 00001858-0000185f (f=109, d=0, p=0)
PCI: Resource ffbfe000-ffbfefff (f=200, d=0, p=0)
PCI: Resource 00001400-000014ff (f=101, d=0, p=0)
PCI: Resource e8010000-e80100ff (f=200, d=0, p=0)
PCI: Resource e8100000-e817ffff (f=200, d=0, p=0)
PCI: Resource f0000000-f7ffffff (f=1208, d=0, p=0)
PCI: Sorting device list...
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v0.120 (20011103) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
ACPI: disabled by cmdline, exiting
vesafb: framebuffer at 0xf0000000, mapped to 0xcf800000, size 15296k
vesafb: mode is 1024x768x16, linelength=2048, pages=8
vesafb: protected mode interface info at c000:7e56
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb1: VGA16 VGA frame buffer device
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 42) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0x1840-0x1847, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1848-0x184f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23CA-20, ATA DISK drive
hdc: LG DVD-ROM DRN-8080B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=2432/255/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 216k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Real Time Clock Driver v1.10e
Adding Swap: 682720k swap-space (priority -1)
MSDOS FS: IO charset iso8859-1
MSDOS FS: Using codepage 850
FAT: freeing iocharset=iso8859-1
8139too Fast Ethernet driver 0.9.22
IRQ for 00:0b.0:0 -> PIRQ 56, mask 0800, excl 0000 -> newirq=11 -> assigning IRQ 11 ... OK
PCI: Assigned IRQ 11 for device 00:0b.0
IRQ routing conflict for 00:07.5, have irq 5, want irq 11
PCI: Sharing IRQ 11 with 00:0a.0
eth0: RealTek RTL8139 Fast Ethernet at 0x1400, 00:08:02:02:34:06, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.268 $ time 14:50:19 Dec 13 2001
usb-uhci.c: High bandwidth mode enabled
IRQ for 00:07.2:3 -> PIRQ 57, mask 0200, excl 0000 -> newirq=9 -> assigning IRQ 9 ... OK
PCI: Assigned IRQ 9 for device 00:07.2
usb-uhci.c: USB UHCI at I/O 0x1800, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
devfs: devfs_register(): device already registered: "sequencer"
devfs: devfs_register(): device already registered: "sequencer2"
devfs: devfs_register(): device already registered: "sound/dspW"
devfs: devfs_register(): device already registered: "sound/audio"
Via 686a audio driver 1.9.1
IRQ for 00:07.5:2 -> PIRQ 56, mask 0020, excl 0000 -> newirq=5 -> got IRQ 11
PCI: Found IRQ 11 for device 00:07.5
IRQ routing conflict for 00:07.5, have irq 5, want irq 11
PCI: Sharing IRQ 11 with 00:0a.0
PCI: Sharing IRQ 11 with 00:0b.0
devfs: devfs_register(): device already registered: "mixer"
ac97_codec: AC97 Audio codec, id: 0x4144:0x5361 (Unknown)
devfs: devfs_register(): device already registered: "dsp"
via82cxxx: board #1 at 0x1000, IRQ 5
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
devfs: devfs_register(): device already registered: "cd"
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00


The output of lspci -vv :

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 80)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: e8100000-e81fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 42)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <available only to root>

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586 IDE [Apollo]
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1840 [size=16]
	Capabilities: <available only to root>

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 1a) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at 1800 [size=32]
	Capabilities: <available only to root>

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: <available only to root>

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo Super AC97/Audio] (rev 50)
	Subsystem: Compaq Computer Corporation: Unknown device 0097
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at 1000 [size=256]
	Region 1: I/O ports at 1854 [size=4]
	Region 2: I/O ports at 1850 [size=4]
	Capabilities: <available only to root>

00:09.0 Communication controller: CONEXANT: Unknown device 2f00 (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device 8d88
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 4
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64K]
	Region 1: I/O ports at 1858 [size=8]
	Capabilities: <available only to root>

00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ffbfe000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
	Memory window 1: fbbfd000-ffbfc000 (prefetchable)
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1400 [size=256]
	Region 1: Memory at e8010000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8d02 (rev 01) (prog-if 00 [VGA])
	Subsystem: Compaq Computer Corporation: Unknown device 0086
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e8100000 (32-bit, non-prefetchable) [size=512K]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

please cc me, I'm not on the list.

Thanks.

Denis
_______________________________________________
Denis Pelletier
Étudiant au doctorat
sciences économiques, Université de Montréal




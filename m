Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262346AbSJ2Vec>; Tue, 29 Oct 2002 16:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262357AbSJ2Vec>; Tue, 29 Oct 2002 16:34:32 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:36100 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP
	id <S262346AbSJ2VeY>; Tue, 29 Oct 2002 16:34:24 -0500
Date: Tue, 29 Oct 2002 22:40:43 +0100
From: Michal Rokos <m.rokos@sh.cvut.cz>
To: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Alsa vs ALi5451
Message-ID: <20021029214043.GA28410@nightmare.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Crypto: GnuPG/1.0.6 http://www.gnupg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

    I'm having problem with ALi5451 audio chipset.

    Insmod segfaults and lsmod says that initializing the snd-ali5451. The wierd is the OSS trident module is working just fine (with some limitation - I can't make it work throught the phones), but it's workin'. So I guess it's alsa problem.
    
    All that come to my mind that could be helpfull i attached. (syslog entry, alsa config, dmesg, lspci --v).

    Please, keep me in CC - I'm not on list.

    Thanks

	Michal

-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Ing. Michal Rokos                    Czech Technical University, Prague
e-mail: m.rokos@sh.cvut.cz    icq: 36118339     jabber: majkl@jabber.cz
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=alsa

# ALSA portion
alias snd-card-0 snd-ali5451
# OSS/Free portion
alias sound-slot-0 snd-card-0

# OSS/Free portion - card #1
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.5.44-ac4 (root@nb15) (gcc version 3.2.1 20021020 (Debian prerelease)) #5 Mon Oct 28 00:36:59 CET 2002
Video mode to be used for restore is 305
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
 BIOS-e820: 000000001fef0000 - 000000001feff000 (ACPI data)
 BIOS-e820: 000000001feff000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
510MB LOWMEM available.
On node 0 totalpages: 130800
  DMA zone: 4096 pages
  Normal zone: 126704 pages
  HighMem zone: 0 pages
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6eb0
ACPI: RSDT (v001 PTLTD  EGRSDT   00528.00000) @ 0x1fef5e8c
ACPI: FADT (v001 ALI    EG533    00528.00000) @ 0x1fefef64
ACPI: BOOT (v001 PTLTD  EGBFTBL$ 00528.00000) @ 0x1fefefd8
ACPI: DSDT (v001    ALI    EG533 00528.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: root=/dev/hda6 ro vga=0x305 panicblink=3
No local APIC present or hardware disabled
Initializing CPU#0
Detected 1699.259 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 3342.33 BogoMIPS
Memory: 514372k/523200k available (1587k kernel code, 8440k reserved, 1142k data, 128k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 3febf9ff 00000000 00000000, vendor = 0
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 3febf9ff 00000000 00000000 00000000
CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000
CPU:             Common caps: 3febf9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.70GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.9 (c) Adam Belay
PCI: PCI BIOS revision 2.10 entry at 0xfd88b, last bus=1
PCI: Using configuration type 1
Registering system device cpu0
adding '' to cpu class interfaces
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20021022
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: Embedded Controller [EC0] (gpe 24)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 11 12, disabled)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 11 12, enabled at IRQ 10)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *10 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *10 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 12, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 12, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 6 7 10 12, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 11 12, enabled at IRQ 7)
ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 6 7 *10 12)
PnPBIOS: Found PnP BIOS installation structure at 0xc00f6ee0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9abb, dseg 0x400
pnp: 00:01: ioport range 0x370-0x371 has been reserved
pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0b: ioport range 0x40b-0x40b has been reserved
pnp: 00:0b: ioport range 0x480-0x48f has been reserved
pnp: 00:0b: ioport range 0x4d6-0x4d6 has been reserved
pnp: 00:0b: ioport range 0x8000-0x803f has been reserved
pnp: 00:0b: ioport range 0x8040-0x805f has been reserved
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
ACPI: No IRQ known for interrupt pin A of device 00:0f.0 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Registering system device pic0
Registering system device rtc0
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
Starting kswapd
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
Capability LSM initialized
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
vesafb: framebuffer at 0xe8000000, mapped to 0xe080f000, size 32768k
vesafb: mode is 1024x768x8, linelength=1024, pages=41
vesafb: protected mode interface info at c000:5265
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 438M
agpgart: Detected Ali M1671 chipset
agpgart: AGP aperture is 128M @ 0xf0000000
[drm] AGP 0.99 on Unknown @ 0xf0000000 128MB
[drm] Initialized radeon 1.6.0 20020828 on minor 0
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 00:0f.0
ACPI: No IRQ known for interrupt pin A of device 00:0f.0 - using IRQ 255
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK3018GAP, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: UJDA730 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 58605120 sectors (30006 MB), CHS=3648/255/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 >
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
input: PS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.06 2002-Oct-09, 1 devices found
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 128k freed
Adding 514040k swap on /dev/hda5.  Priority:-1 extents:1
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xe2880000, 00:c0:9f:16:0e:55, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version 0.14.10f, 19:08:09 Oct 27 2002
trident: ALi Audio Accelerator found at IO 0x1000, IRQ 7
ac97_codec: AC97 Audio codec, id: 0x414c:0x4710 (ALC200/200P)
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1671 Northbridge [Aladdin-P4] (rev 02)
	Subsystem: Hewlett-Packard Company: Unknown device 0027
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [b0] AGP version 2.0
		Status: RQ=27 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [a4] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] PCI to AGP Controller (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: e0100000-e01fffff
	Prefetchable memory behind bridge: e8000000-efffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0027
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 PCI AC-Link Controller Audio Device (rev 02)
	Subsystem: Hewlett-Packard Company: Unknown device 0027
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 7
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at e0001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: Hewlett-Packard Company: Unknown device 0027
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: Hewlett-Packard Company: Unknown device 0027
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
	Subsystem: Hewlett-Packard Company: Unknown device 0027
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1400 [size=256]
	Region 1: Memory at e0002000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Network controller: Harris Semiconductor: Unknown device 3873 (rev 01)
	Subsystem: Action Tec Electronics Inc: Unknown device 1406
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e0003000 (32-bit, prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
	Subsystem: Hewlett-Packard Company: Unknown device 0027
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 20000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=64
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001

00:0b.0 Communication controller: ESS Technology ES2838/2839 SuperLink Modem (rev 01)
	Subsystem: Hewlett-Packard Company: Unknown device 0020
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=55mA PME(D0+,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4) (prog-if fa)
	Subsystem: Hewlett-Packard Company: Unknown device 0027
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 255
	Region 4: I/O ports at 1810 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 0027
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at e0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=oops

 ali create: chip init error.
 Trying to free free IRQ7
  printing eip:
 c0123f50
 Oops: 0000
 snd-ali5451 snd-pcm snd-timer snd-ac97-codec snd soundcore nls_iso8859-2 nls_cp852 vfat fat 8139too mii crc32  
 CPU:    0
 EIP:    0060:[__release_resource+16/64]    Not tainted
 EFLAGS: 00010206
 EIP is at __release_resource+0x10/0x40
 eax: dd362ac0   ebx: dcdd2000   ecx: 00000018   edx: 00000001
 esi: df392540   edi: 00002fff   ebp: df392400   esp: dcdd3dfc
 ds: 0068   es: 0068   ss: 0068
 Process modprobe (pid: 666, threadinfo=dcdd2000 task=dda15300)
 Stack: dcdd2000 c0124001 dd362ac0 dd695000 df392540 e28d82e8 dd362ac0 dd695000 
        dd362b40 e28d8592 dd695000 e288970d dd362b40 00002000 e288985a df392400 
        dd695000 dcdd2000 df392400 00000000 dfd0c000 e2885b1d df392400 00000002 
 Call Trace:
  [release_resource+33/80] release_resource+0x21/0x50
  [<e28d82e8>] snd_ali_free+0x58/0x70 [snd-ali5451]
  [<e28d8592>] snd_ali_dev_free+0x12/0x20 [snd-ali5451]
  [<e288970d>] snd_device_free_R9382eaab+0x5d/0x90 [snd]
  [<e288985a>] snd_device_free_all_R7b406a36+0x5a/0x60 [snd]
  [<e2885b1d>] snd_card_free_R492cef33+0x9d/0x180 [snd]
  [<e28d89ae>] snd_ali_probe+0x15e/0x170 [snd-ali5451]
  [<e28da080>] driver+0x0/0x7c [snd-ali5451]
  [<e28da0a8>] driver+0x28/0x7c [snd-ali5451]
  [pci_device_probe+94/112] pci_device_probe+0x5e/0x70
  [<e28d9ea0>] snd_ali_ids+0x0/0x38 [snd-ali5451]
  [<e28da0a8>] driver+0x28/0x7c [snd-ali5451]
  [bus_match+66/112] bus_match+0x42/0x70
  [<e28da0a8>] driver+0x28/0x7c [snd-ali5451]
  [driver_attach+93/128] driver_attach+0x5d/0x80
  [<e28da0a8>] driver+0x28/0x7c [snd-ali5451]
  [<e28da0a8>] driver+0x28/0x7c [snd-ali5451]
  [bus_add_driver+105/160] bus_add_driver+0x69/0xa0
  [<e28da0a8>] driver+0x28/0x7c [snd-ali5451]
  [<e28da0a8>] driver+0x28/0x7c [snd-ali5451]
  [driver_register+71/96] driver_register+0x47/0x60
  [<e28da0a8>] driver+0x28/0x7c [snd-ali5451]
  [pci_register_driver+59/80] pci_register_driver+0x3b/0x50
  [<e28da0a8>] driver+0x28/0x7c [snd-ali5451]
  [<e28d8a09>] init_module+0x19/0x60 [snd-ali5451]
  [<e28da080>] driver+0x0/0x7c [snd-ali5451]
  [sys_init_module+1249/1600] sys_init_module+0x4e1/0x640
  [<e28d6060>] snd_ali_codec_ready+0x0/0x90 [snd-ali5451]
  [<e28d90f4>] .kmodtab+0x0/0x24 [snd-ali5451]
  [<e28d6060>] snd_ali_codec_ready+0x0/0x90 [snd-ali5451]
  [syscall_call+7/11] syscall_call+0x7/0xb
 
 Code: 8b 11 bb ea ff ff ff 85 d2 74 17 39 c2 74 05 8d 4a 14 eb ec 
  <6>note: modprobe[666] exited with preempt_count 2
 Call Trace:
  [__kmem_cache_alloc+267/272] __kmem_cache_alloc+0x10b/0x110
  [locks_alloc_lock+61/96] locks_alloc_lock+0x3d/0x60
  [posix_lock_file+58/1520] posix_lock_file+0x3a/0x5f0
  [scrup+289/304] scrup+0x121/0x130
  [mod_timer+271/352] mod_timer+0x10f/0x160
  [page_remove_rmap+169/416] page_remove_rmap+0xa9/0x1a0
  [locks_remove_posix+135/176] locks_remove_posix+0x87/0xb0
  [dput+48/304] dput+0x30/0x130
  [__fput+183/240] __fput+0xb7/0xf0
  [filp_close+109/160] filp_close+0x6d/0xa0
  [put_files_struct+108/224] put_files_struct+0x6c/0xe0
  [do_exit+245/688] do_exit+0xf5/0x2b0
  [die+133/144] die+0x85/0x90
  [do_page_fault+343/1182] do_page_fault+0x157/0x49e
  [poke_blanked_console+83/112] poke_blanked_console+0x53/0x70
  [__call_console_drivers+95/112] __call_console_drivers+0x5f/0x70
  [__wake_up_common+58/96] __wake_up_common+0x3a/0x60
  [do_page_fault+0/1182] do_page_fault+0x0/0x49e
  [error_code+45/56] error_code+0x2d/0x38
  [__release_resource+16/64] __release_resource+0x10/0x40
  [release_resource+33/80] release_resource+0x21/0x50
  [<e28d82e8>] snd_ali_free+0x58/0x70 [snd-ali5451]
  [<e28d8592>] snd_ali_dev_free+0x12/0x20 [snd-ali5451]
  [<e288970d>] snd_device_free_R9382eaab+0x5d/0x90 [snd]
  [<e288985a>] snd_device_free_all_R7b406a36+0x5a/0x60 [snd]
  [<e2885b1d>] snd_card_free_R492cef33+0x9d/0x180 [snd]
  [<e28d89ae>] snd_ali_probe+0x15e/0x170 [snd-ali5451]
  [<e28da080>] driver+0x0/0x7c [snd-ali5451]
  [<e28da0a8>] driver+0x28/0x7c [snd-ali5451]
  [pci_device_probe+94/112] pci_device_probe+0x5e/0x70
  [<e28d9ea0>] snd_ali_ids+0x0/0x38 [snd-ali5451]
  [<e28da0a8>] driver+0x28/0x7c [snd-ali5451]
  [bus_match+66/112] bus_match+0x42/0x70
  [<e28da0a8>] driver+0x28/0x7c [snd-ali5451]
  [driver_attach+93/128] driver_attach+0x5d/0x80
  [<e28da0a8>] driver+0x28/0x7c [snd-ali5451]
  [<e28da0a8>] driver+0x28/0x7c [snd-ali5451]
  [bus_add_driver+105/160] bus_add_driver+0x69/0xa0
  [<e28da0a8>] driver+0x28/0x7c [snd-ali5451]
  [<e28da0a8>] driver+0x28/0x7c [snd-ali5451]
  [driver_register+71/96] driver_register+0x47/0x60
  [<e28da0a8>] driver+0x28/0x7c [snd-ali5451]
  [pci_register_driver+59/80] pci_register_driver+0x3b/0x50
  [<e28da0a8>] driver+0x28/0x7c [snd-ali5451]
  [<e28d8a09>] init_module+0x19/0x60 [snd-ali5451]
  [<e28da080>] driver+0x0/0x7c [snd-ali5451]
  [sys_init_module+1249/1600] sys_init_module+0x4e1/0x640
  [<e28d6060>] snd_ali_codec_ready+0x0/0x90 [snd-ali5451]
  [<e28d90f4>] .kmodtab+0x0/0x24 [snd-ali5451]
  [<e28d6060>] snd_ali_codec_ready+0x0/0x90 [snd-ali5451]
  [syscall_call+7/11] syscall_call+0x7/0xb

--zhXaljGHf11kAtnf--

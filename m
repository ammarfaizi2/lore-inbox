Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTLNQ43 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 11:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTLNQ43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 11:56:29 -0500
Received: from smtp0.libero.it ([193.70.192.33]:13006 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S262123AbTLNQ4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 11:56:12 -0500
From: jorge <jorge78_REMOVE_ME@inwind.it>
Subject: Oops: 2.4.23-ck and PCMCIA - USB2 card
Date: Sun, 14 Dec 2003 17:57:46 +0100
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing	moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2003.12.14.16.40.12.148983@inwind.it>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all!

I'm using 2.4.23 kernel with -ck patchset for an Acer 272Xv and it works fine.
Yesterday, I've got this oops detaching my Usb2 PCMCIA card: the PCMCIA
card has 2 usb output, and I use one of these to connect an Iomega USB2
cd-burner. The cd-rw works fine loading ehci-hcd kernel module. 
After extracting the card my keyboard doesn't accept any other input but
mouses (Touchpad and Logitech Optical) seem to work. 
Now, system is NOT completely hanged because I can shutdown the notebook
with kde menu. 
My Debian Sid is up to date.

P.S. Sorry for all lexical mistakes I made...

TIA
			Jorge

Here're system details (lspci, dmesg, ver_linux, and finally oops):

------------------------------- lspci -vvv output (card inserted):

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 650 Host (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [c0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: ec100000-ec1fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:02.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 07) (prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 64 (20000ns max)
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=4K]

00:02.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 07) (prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 64 (20000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at ec001000 (32-bit, non-prefetchable) [size=4K]

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Region 4: I/O ports at 9480 [size=16]

00:02.6 Modem: Silicon Integrated Systems [SiS] Intel 537 [56k Winmodem] (rev a0) (prog-if 00 [Generic])
	Subsystem: COMPAL Electronics Inc: Unknown device 0012
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 173 (13000ns min, 2750ns max)
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at 8400 [size=256]
	Region 1: I/O ports at 9000 [size=128]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound Controller (rev a0)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001a
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 173 (13000ns min, 2750ns max)
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at 8800 [size=256]
	Region 1: I/O ports at 9080 [size=128]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at ec002000 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at 9400 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 8c00 [size=256]
	Region 1: Memory at ec002800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 CardBus bridge: ENE Technology Inc CB1420 Cardbus Controller (rev 01)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x20 (128 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 1e000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=176
	Memory window 0: 1e400000-1e7ff000 (prefetchable)
	Memory window 1: 1e800000-1ebff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:09.1 CardBus bridge: ENE Technology Inc CB1420 Cardbus Controller (rev 01)
	Subsystem: Acer Incorporated [ALI]: Unknown device 001a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x20 (128 bytes)
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at 1e001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=176
	Memory window 0: 1ec00000-1efff000 (prefetchable)
	Memory window 1: 1f000000-1f3ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS650/651/M650/740 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001a
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	BIST result: 00
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at ec100000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at a000 [size=128]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 2.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

02:00.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: DTK Computer: Unknown device 0105
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 1e800000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: DTK Computer: Unknown device 0105
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max)
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at 1e801000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
	Subsystem: DTK Computer: Unknown device 0205
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 68 (4000ns min, 8500ns max), Cache Line Size: 0x20 (128 bytes)
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at 1e802000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-




------------------------------------ dmesg output

Linux version 2.4.23-ck1 (root@D998) (gcc version 3.3.2 (Debian)) #3 Thu Dec 4 12:49:46 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000cc000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000dc000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001def0000 (usable)
 BIOS-e820: 000000001def0000 - 000000001deff000 (ACPI data)
 BIOS-e820: 000000001deff000 - 000000001df00000 (ACPI NVS)
 BIOS-e820: 000000001df00000 - 000000001e000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
480MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 122880
zone(0): 4096 pages.
zone(1): 118784 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f70b0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1defaec7
ACPI: FADT (v001 SiS    650      0x06040000 PTL  0x000f4240) @ 0x1defef8c
ACPI: DSDT (v001 PTLTD      BY25 0x06040000 MSFT 0x0100000e) @ 0x00000000
Kernel command line: BOOT_IMAGE=Linux-2.4.23 ro root=304 video=sisfb:1024x768x256
sisfb: Options 1024x768x256
Initializing CPU#0
Detected 1593.591 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 3145.72 BogoMIPS
Memory: 482132k/491520k available (2367k kernel code, 8932k reserved, 787k data, 140k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000
CPU:             Common caps: 3febf9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xfd98e, last bus=1
PCI: Using configuration type 1
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: Embedded Controller [EC0] (gpe 23)
schedule_task(): keventd has not started
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 7 10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 *10 11)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver v1.1.22 [Flags: R/O]
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-proc.o version 2.6.1 (20010825)
sisfb: Video ROM found and mapped to c00c0000
sisfb: Framebuffer at 0xf0000000, mapped to 0xde80e000, size 32768k
sisfb: MMIO at 0xec100000, mapped to 0xe080f000, size 128k
sisfb: Memory heap starting at 31744K
sisfb: Using MMIO queue mode
sisfb: Detected SiS302LV video bridge
sisfb: Detected LCD PanelDelayCompensation 1
sisfb: Mode is 800x600x8 (60Hz)
sisfb: Initial vbflags 0x8000012
sisfb: Added MTRRs
Console: switching to colour frame buffer device 100x37
sisfb: Installed SISFB_GET_INFO ioctl (80046ef8)
sisfb: Installed SISFB_GET_VBRSTATUS ioctl (80046ef9)
sisfb: 2D acceleration is enabled, scrolling mode ypan
fb0: SIS 650/M650/651/661FX/M661FX/740/741 VG frame buffer device, Version 1.6.16
sisfb: (C) 2001-2003 Thomas Winischhofer. All rights reserved.
vesafb: abort, cannot reserve video memory at 0xf0000000
vesafb: framebuffer at 0xf0000000, mapped to 0xe0830000, size 1536k
vesafb: mode is 1024x768x8, linelength=1024, pages=9
vesafb: protected mode interface info at cbcf:000c
vesafb: scrolling: redraw
fb1: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 at 0xe09b1800, 00:02:3f:ac:dc:96, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 410M
agpgart: Detected SiS 650 chipset
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] AGP 0.99 Aperture @ 0xe8000000 64MB
[drm] Initialized sis 1.0.0 20010503 on minor 0
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 961 MuTIOL IDE UDMA100 controller
    ide0: BM-DMA at 0x9480-0x9487, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x9488-0x948f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N020ATCS04-0, ATA DISK drive
blk: queue c0464b80, I/O limit 4095Mb (mask 0xffffffff)
hdc: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/1768KiB Cache, CHS=2432/255/63, UDMA(33)
hdc: attached ide-cdrom driver.
hdc: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 > hda3 hda4
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Yenta IRQ list 0000, PCI irq10
Socket status: 30000020
Yenta IRQ list 0010, PCI irq10
Socket status: 30000006
host/usb-ohci.c: USB OHCI at membase 0xe09cd000, IRQ 10
host/usb-ohci.c: usb-00:02.2, Silicon Integrated Systems [SiS] USB 1.0 Controller
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 3 ports detected
host/usb-ohci.c: USB OHCI at membase 0xe09cf000, IRQ 10
host/usb-ohci.c: usb-00:02.3, Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 12
Linux I2O PCI support (c) 1999 Red Hat Software.
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
lec.c: Dec  4 2003 12:55:39 initialized
cs: cb_alloc(bus 2): vendor 0x1033, device 0x0035
PCI: Enabling device 02:00.0 (0000 -> 0002)
PCI: Setting latency timer of device 02:00.0 to 64
host/usb-ohci.c: USB OHCI at membase 0xe09d1000, IRQ 10
host/usb-ohci.c: usb-02:00.0, PCI device 1033:0035
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 3 ports detected
hub.c: new USB device 00:02.3-2, assigned address 2
usb.c: USB device 2 (vend/prod 0x46d/0xc00e) is not claimed by any active driver.
PCI: Enabling device 02:00.1 (0000 -> 0002)
PCI: Setting latency timer of device 02:00.1 to 64
host/usb-ohci.c: USB OHCI at membase 0xe09d3000, IRQ 10
host/usb-ohci.c: usb-02:00.1, PCI device 1033:0035
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Enabling device 02:00.2 (0000 -> 0002)
PCI: No IRQ known for interrupt pin C of device 02:00.2
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 140k freed
hub.c: new USB device 02:00.1-1, assigned address 2
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: IOMEGA    Model: CDRW38402EXT2-B   Rev: UOS1
  Type:   CD-ROM                             ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
Adding Swap: 257032k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,4), internal journal
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb2: VGA16 VGA frame buffer device
mice: PS/2 mouse device common for all mice
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
ip_conntrack version 2.1 (3840 buckets, 30720 max) - 292 bytes per conntrack
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
PPP Deflate Compression module registered
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi-1 drive
PCI: No IRQ known for interrupt pin C of device 02:00.2
ehci_hcd 02:00.2: PCI device 1033:00e0
ehci_hcd 02:00.2: irq 10, pci mem e0a5e000
usb.c: new USB bus registered, assigned bus number 5
ehci_hcd 02:00.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 5 ports detected
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
usb.c: USB disconnect on device 02:00.1-1 address 2
ACPI: Processor [CPU0] (supports C1 C2 C3, 2 performance states, 8 throttling states)
slmdm: version 2.7.10 Feb  4 2003 15:18:20 (Smart Link Ltd.).
slmdm: country set is 0xb5 (USA).
Smart Link AMRMO modem.
amrmo: probe 1039:7013 Silicon Integrated Systems [SiS] Intel 537 [56k Winmodem] : SiS630 card...
usb.c: registered new driver usbmouse
input0: Logitech USB-PS/2 Optical Mouse on usb2:2.0
usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
hub.c: new USB device 02:00.2-2, assigned address 2
spurious 8259A interrupt: IRQ7.
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
intel8x0: clocking to 48000
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: link down
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x20f 0x378-0x37f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
ISO 9660 Extensions: RRIP_1991A
This driver is not compatible with the installed modem codec.
Please contact your modem provider for support.
PPP BSD Compression module registered
ISO 9660 Extensions: RRIP_1991A


---------------------------------- ver_linu script


If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux D998 2.4.23-ck1 #3 Thu Dec 4 12:49:46 CET 2003 i686 GNU/Linux
 
Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               2.4.25
e2fsprogs              1.35-WIP
pcmcia-cs              3.2.5
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         bsd_comp ppp_async snd-seq-oss snd-seq-midi-event snd-seq 
snd-pcm-oss snd-mixer-oss nls_iso8859-1 nls_cp437 snd-intel8x0
snd-ac97-codec snd-pcm snd-timer snd-page-alloc snd-mpu401-uart
snd-rawmidi snd-seq-device snd hid usbmouse slamrmo slmdm thermal
processor fan button battery ac sr_mod ppp_synctty ppp_deflate
zlib_inflate zlib_deflate msr microcode cpuid ipt_state ipt_MASQUERADE
iptable_nat ip_conntrack sg ide-scsi mousedev keybdev vga16fb
fbcon-vga-planes


-------------------------------- oops
Dec 14 17:13:24 D998 -- MARK --
Dec 14 17:23:55 D998 kernel: usb.c: USB disconnect on device 02:00.0-0 address 1
Dec 14 17:23:55 D998 kernel: usb.c: USB bus 3 deregistered
Dec 14 17:23:55 D998 kernel: usb.c: USB disconnect on device 02:00.1-0 address 1
Dec 14 17:23:55 D998 kernel: usb.c: USB bus 4 deregistered
Dec 14 17:23:55 D998 kernel: ehci_hcd 02:00.2: remove state 0
Dec 14 17:23:55 D998 kernel: usb.c: USB disconnect on device 02:00.2-0 address 1
Dec 14 17:23:55 D998 kernel: usb.c: USB bus 5 deregistered
Dec 14 17:23:55 D998 kernel: cs: cb_free(bus 2)
Dec 14 17:23:55 D998 kernel:  printing eip:
Dec 14 17:23:55 D998 kernel: e0a5612d
Dec 14 17:23:55 D998 kernel: Oops: 0000
Dec 14 17:23:55 D998 kernel: CPU:    0
Dec 14 17:23:55 D998 kernel: EIP:    0010:[nls_iso8859-1:__insmod_nls_iso8859-1_O/lib/modules/2.4.23-ck1/kernel/fs/n+-1662675/96]    Tainted: P
Dec 14 17:23:55 D998 kernel: EFLAGS: 00010286
Dec 14 17:23:55 D998 kernel: eax: 00000000   ebx: c1555f84   ecx: ddf9be00   edx: e0a5e020
Dec 14 17:23:55 D998 kernel: esi: ddf9be00   edi: 00000000   ebp: c1554000   esp: c1555eac
Dec 14 17:23:55 D998 kernel: ds: 0018   es: 0018   ss: 0018
Dec 14 17:23:55 D998 kernel: Process keventd (pid: 2, stackpage=c1555000)
Dec 14 17:23:55 D998 kernel: Stack: 005349f4 00000001 00000006 dc721f7c c03cc958 00000001 c1555ee8 00000282
Dec 14 17:23:55 D998 kernel:        dc720000 00000000 00000001 00000282 c043f7d6 00000246 00000016 ddf85800
Dec 14 17:23:55 D998 kernel:        c011bd77 0000000a 00000400 c039e1d7 c1555f28 00000282 c1555f84 ddf9be00
Dec 14 17:23:55 D998 kernel: Call Trace:    [printk+295/384] [nls_iso8859-1:__insmod_nls_iso8859-1_O/lib/modules/2.4.23-ck1/kernel/fs/n+-1648418/96] [cb_free+105/128] [shutdown_socket+175/256] [parse_events+221/320]
Dec 14 17:23:55 D998 kernel:   [yenta_bh+79/96] [hcd_panic+16/32] [__run_task_queue+106/128] [context_thread+519/544] [context_thread+0/544] [rest_init+0/96]
Dec 14 17:23:55 D998 kernel:   [arch_kernel_thread+46/64] [context_thread+0/544]
Dec 14 17:23:55 D998 kernel:
Dec 14 17:23:55 D998 kernel: Code: 8b 02 83 c8 02 89 02 31 c0 89 81 00 01 00 00 b8 90 d0 03 00



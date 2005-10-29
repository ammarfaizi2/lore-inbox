Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbVJ2VaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVJ2VaH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 17:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVJ2VaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 17:30:07 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:64159 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751083AbVJ2VaF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 17:30:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NGoNONXWLZQKJVu3hmNTGw7L6RjKkNaJzdnfuGEFDE9+XCquOQKkc8v9BCnWrRJW3GtI23MsQogefpNPu9QF71ytzu5qzave0MOt9KqofzqyR5ctplaI5/cqqK++lfY8aNAi+KT4bBPOszxsbWlv0LYzwbeFxo3+oAZuu+uE0IE=
Message-ID: <fda8dbc60510291430w30d8ffdfo80c45595778f938@mail.gmail.com>
Date: Sat, 29 Oct 2005 23:30:04 +0200
From: Filo <krzysztof.gorgolewski@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Paceblade Pacebook no irq for TI yenta PCMCIA - PCI related
Cc: gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-pcmcia@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm trying to get my PCMCIA port running on my pacebook tablet. I'm
using 2.6.* kernel (actually 2.6.13-rc4-mm1 but I also tried 2.6.12)
and during initialization of yenta_socket I get this message:

Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:05.0, mfunc 0x01021c02, devctl 0x64
Yenta TI: socket 0000:00:05.0 probing PCI interrupt failed, trying to fix
Yenta TI: socket 0000:00:05.0 no PCI interrupts. Fish. Please report.
Yenta: no PCI IRQ, CardBus support disabled for this socket.
Yenta: check your BIOS CardBus, BIOS IRQ or ACPI settings.
Yenta: ISA IRQ mask 0x0ad8, PCI irq 0

It seam that Yenta cant get information about the irq's from the PCI.
It's not an ACPI issue because I did not compile it (it's broken on my
tablet). I'm quite confused what to do now. Any help (even a dirty
hack) would be appreciated.

Here are the full logs:

dmesg:
Linux version 2.6.14-rc4-mm1 (root@aion) (gcc version 3.3.5-20050130
(Gentoo 3.3.5.20050130-r1, ssp-3.3.5.20050130-1, pie-8.7.7.1)) #1
PREEMPT Sat Oct 29 21:49:53 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009a800 (usable)
 BIOS-e820: 000000000009a800 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
240MB LOWMEM available.
On node 0 totalpages: 61440
  DMA zone: 4096 pages, LIFO batch:2
  DMA32 zone: 0 pages, LIFO batch:2
  Normal zone: 57344 pages, LIFO batch:32
  HighMem zone: 0 pages, LIFO batch:2
DMI 2.3 present.
Allocating PCI resources starting at 10000000 (gap: 0f000000:f0f80000)
Built 1 zonelists
No local APIC present or hardware disabled
mapped APIC to ffffd000 (011e1000)
Initializing CPU#0
Kernel command line: root=/dev/hda3 vga=0x317 resume2=swap:/dev/hda2
pci=usepirqmask
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 602.955 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 238848k/245760k available (2836k kernel code, 6428k reserved,
1095k data, 176k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1243.53 BogoMIPS (lpj=2487073)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0084893f 0081813f 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0084893f 0081813f 0000000e 00000000
00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 512K (128 bytes/line)
CPU: Processor revision 1.3.1.3, 600 MHz
CPU: Code Morphing Software revision 4.2.6-8-168
CPU: 20010703 00:29 official release 4.2.6#2
CPU serial number disabled.
CPU: After all inits, caps: 0080893f 0081813f 0000000e 00000000
00000000 00000000 00000000
mtrr: v2.0 (20020519)
CPU: Transmeta(tm) Crusoe(tm) Processor TM5600 stepping 03
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: BIOS32 Service Directory structure at 0xc00f81e0
PCI: BIOS32 Service Directory entry at 0xfd780
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=00
PCI: PCI BIOS revision 2.10 entry at 0xfd89e, last bus=0
PCI: Using configuration type 1
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f8210
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa9ae, dseg 0x400
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:06.0
PCI: IDE base address fixup for 0000:00:0f.0
PCI: Scanning for ghost devices on bus 0
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00fdf30
00:00 slot=00 0:00/84e0 1:00/84e0 2:00/84e0 3:00/84e0
00:09 slot=00 0:4b/0020 1:00/0020 2:00/0020 3:00/0020
00:08 slot=00 0:4b/0020 1:00/0020 2:00/0020 3:00/0020
00:03 slot=00 0:49/0020 1:00/0020 2:00/0020 3:00/0020
00:06 slot=00 0:48/0400 1:00/0400 2:00/0400 3:00/0400
00:05 slot=00 0:49/0400 1:00/0400 2:00/0400 3:00/0400
00:04 slot=00 0:4a/0400 1:00/0400 2:00/0400 3:00/0400
00:0f slot=00 0:00/84e0 1:00/84e0 2:00/84e0 3:00/84e0
00:14 slot=00 0:59/0020 1:00/0020 2:00/0020 3:00/0020
PCI: Attempting to find IRQ router for 10b9:1533
PCI: Using ALI IRQ Router
PCI: Using IRQ router ALI [10b9/1533] at 0000:00:07.0
PCI: IRQ fixup
0000:00:05.0: ignoring bogus IRQ 255
0000:00:0f.0: ignoring bogus IRQ 255
IRQ for 0000:00:05.0[A] -> PIRQ 49, mask 0400, excl 0000 -> newirq=0 ... failed
IRQ for 0000:00:0f.0[A] -> not routed
PCI: Allocating resources
PCI: Resource fc000000-fc0fffff (f=200, d=0, p=0)
PCI: Resource 00001000-000010ff (f=101, d=0, p=0)
PCI: Resource fc103000-fc1030ff (f=200, d=0, p=0)
PCI: Resource fc100000-fc100fff (f=200, d=0, p=0)
PCI: Resource 14000000-14000fff (f=200, d=0, p=0)
PCI: Resource f8000000-fbffffff (f=200, d=0, p=0)
PCI: Resource 00001400-000014ff (f=101, d=0, p=0)
PCI: Resource fc101000-fc101fff (f=200, d=0, p=0)
PCI: Resource 00001800-0000180f (f=101, d=0, p=0)
PCI: Resource 000d0000-000d0fff (f=200, d=0, p=0)
PCI: Sorting device list...
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:01' and the driver 'system'
pnp: match found with the PnP device '00:02' and the driver 'system'
pnp: 00:02: ioport range 0x40b-0x40b has been reserved
pnp: 00:02: ioport range 0x480-0x48f has been reserved
pnp: 00:02: ioport range 0x4d6-0x4d6 has been reserved
pnp: match found with the PnP device '00:0a' and the driver 'system'
pnp: 00:0a: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0a: ioport range 0x8000-0x803f has been reserved
pnp: 00:0a: ioport range 0x8040-0x804f has been reserved
pnp: match found with the PnP device '00:0b' and the driver 'system'
pnp: match found with the PnP device '00:0c' and the driver 'system'
pnp: match found with the PnP device '00:0d' and the driver 'system'
PCI: Ignore bogus resource 6 [0:0] of 0000:00:06.0
PCI: Bus 1, cardbus bridge: 0000:00:05.0
  IO window: 00002000-00002fff
  IO window: 00003000-00003fff
  PREFETCH window: 10000000-11ffffff
  MEM window: 12000000-13ffffff
IRQ for 0000:00:05.0[A] -> PIRQ 49, mask 0400, excl 0000 -> newirq=10
-> assigning IRQ 10PCI: setting IRQ 10 as level-triggered
 ... OK
PCI: Assigned IRQ 10 for device 0000:00:05.0
PCI: Sharing IRQ 10 with 0000:00:03.0
Initializing Cryptographic API
Activating ISA DMA hang workarounds.
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
IRQ for 0000:00:14.0[A] -> PIRQ 59, mask 0020, excl 0000 -> newirq=5
-> got IRQ 5
PCI: Found IRQ 5 for device 0000:00:14.0
ohci_hcd 0000:00:14.0: OHCI Host Controller
ohci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:14.0: irq 5, io mem 0x000d0000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
vesafb: framebuffer at 0xf8200000, mapped to 0xcf880000, using 3072k,
total 8192k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at ca7f:000d
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
vesafb: Mode is VGA compatible
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:07' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
pnp: match found with the PnP device '00:0e' and the driver 'i8042 aux'
PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:0f' and the driver 'serial'
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
mice: PS/2 mouse device common for all mice
io scheduler noop registered
io scheduler deadline registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.27
IRQ for 0000:00:03.0[A] -> PIRQ 49, mask 0020, excl 0000 -> newirq=5
-> assigning IRQ 5PCI: setting IRQ 5 as level-triggered
 ... OK
PCI: Assigned IRQ 5 for device 0000:00:03.0
PCI: Sharing IRQ 5 with 0000:00:05.0
eth0: RealTek RTL8139 at 0xcf80e000, 00:40:ca:b6:01:89, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:0f.0
IRQ for 0000:00:0f.0[A] -> not routed
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1808-0x180f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
input: AT Translated Set 2 keyboard//class/input_dev as input0
logips2pp: Detected unknown logitech mouse model 0
hda: FUJITSU MHT2030AR, ATA DISK drive
input: PS/2 Logitech Mouse//class/input_dev as input1
input: ImPS/2 Generic Wheel Mouse//class/input_dev as input2
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/2048KiB Cache, CHS=58140/16/63, UDMA(66)
hda: cache flushes supported
 hda: hda1 hda2 hda3
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
IRQ for 0000:00:04.0[A] -> PIRQ 4a, mask 0400, excl 0000 -> newirq=10
-> assigning IRQ 10 ... OK
PCI: Assigned IRQ 10 for device 0000:00:04.0
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10] 
MMIO=[fc100000-fc1007ff]  Max Packet=[2048]
ieee1394: raw1394: /dev/raw1394 device initialized
sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
IRQ for 0000:00:05.0[A] -> PIRQ 49, mask 0400, excl 0000 -> newirq=10
-> assigning IRQ 10 ... OK
PCI: Assigned IRQ 10 for device 0000:00:05.0
PCI: Sharing IRQ 10 with 0000:00:03.0
Yenta: CardBus bridge found at 0000:00:05.0 [1509:2250]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:05.0, mfunc 0x01021c02, devctl 0x64
Yenta TI: socket 0000:00:05.0 probing PCI interrupt failed, trying to fix
Yenta TI: socket 0000:00:05.0 no PCI interrupts. Fish. Please report.
Yenta: no PCI IRQ, CardBus support disabled for this socket.
Yenta: check your BIOS CardBus, BIOS IRQ or ACPI settings.
Yenta: ISA IRQ mask 0x0ad8, PCI irq 0
Socket status: 30000020

lspci -vvv

0000:00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 01)
0000:00:00.1 RAM memory: Transmeta Corporation SDRAM controller
0000:00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
0000:00:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
0000:00:04.0 FireWire (IEEE 1394): Agere Systems FW323 (rev 04)
0000:00:05.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller (rev 02)
0000:00:06.0 VGA compatible controller: Silicon Motion, Inc. SM720
Lynx3DM (rev b1)
0000:00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
0000:00:08.0 Multimedia audio controller: ALi Corporation M5451 PCI
AC-Link Controller Audio Device (rev 01)
0000:00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
0000:00:11.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
0000:00:14.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
0000:00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 01)
	Subsystem: Transmeta Corporation: Unknown device 0295
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc000000 (32-bit, non-prefetchable)

0000:00:00.1 RAM memory: Transmeta Corporation SDRAM controller
	Subsystem: Transmeta Corporation: Unknown device 0295
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
	Subsystem: Transmeta Corporation: Unknown device 0295
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 2220
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1000
	Region 1: Memory at fc103000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:04.0 FireWire (IEEE 1394): Agere Systems FW323 (rev 04)
(prog-if 10 [OHCI])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1881
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 96 (3000ns min, 6000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fc100000 (32-bit, non-prefetchable)
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0000:00:05.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller (rev 02)
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 2250
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 14000000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
	Memory window 0: 10000000-11fff000 (prefetchable)
	Memory window 1: 12000000-13fff000
	I/O window 0: 00002000-00002fff
	I/O window 1: 00003000-00003fff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:00:06.0 VGA compatible controller: Silicon Motion, Inc. SM720
Lynx3DM (rev b1) (prog-if 00 [VGA])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 2230
	Control: I/O+ Mem+ BusMaster- SpecCycle+ MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f8000000 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: Source Technology Inc: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 Multimedia audio controller: ALi Corporation M5451 PCI
AC-Link Controller Audio Device (rev 01)
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 2240
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1400
	Region 1: Memory at fc101000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
(prog-if 8a [Master SecP PriP])
	Subsystem: Source Technology Inc: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 1800 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
	Subsystem: Source Technology Inc: Unknown device 0001
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:14.0 USB Controller: ALi Corporation USB 1.1 Controller (rev
03) (prog-if 10 [OHCI])
	Subsystem: Source Technology Inc: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at 000d0000 (32-bit, non-prefetchable)
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

cat /proc/iomem
00000000-0009a7ff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000d0000-000d0fff : 0000:00:14.0
  000d0000-000d0fff : ohci_hcd
000f0000-000fffff : System ROM
00100000-0effffff : System RAM
  00100000-003c5266 : Kernel code
  003c5267-004d6ef3 : Kernel data
10000000-11ffffff : PCI CardBus #01
12000000-13ffffff : PCI CardBus #01
14000000-14000fff : 0000:00:05.0
  14000000-14000fff : yenta_socket
f8000000-fbffffff : 0000:00:06.0
  f8200000-f89fffff : vesafb
fc000000-fc0fffff : 0000:00:00.0
fc100000-fc100fff : 0000:00:04.0
  fc100000-fc1007ff : ohci1394
fc101000-fc101fff : 0000:00:08.0
  fc101000-fc101fff : ALI 5451
fc103000-fc1030ff : 0000:00:03.0
  fc103000-fc1030ff : 8139too
fff80000-ffffffff : reserved

Regards,
Chris Gorgolewski

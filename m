Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262410AbTCMPsJ>; Thu, 13 Mar 2003 10:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262411AbTCMPsJ>; Thu, 13 Mar 2003 10:48:09 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:32011 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262410AbTCMPr6>; Thu, 13 Mar 2003 10:47:58 -0500
Date: Thu, 13 Mar 2003 16:58:29 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-fbdev-users@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.64 tdfxfb problems: 'fb: can't remap 3Dfx VooDoo 5 register area'
Message-ID: <20030313155829.GA1338@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to use the tdfxfb framebuffer module with the 2.5.64 kernel,
I get the following message:

fb: Can't remap 3Dfx Voodoo5 register area.

Is there any way to solve this? I tried google, but I can't find any
solution for this :-(

If I compile the tdfxfb framebuffer into the kernel, I get an oops
during booting with the backlog below. That is rather less nice, but
even as a module it won't work.

Thanks for your attention,
Jurriaan

remap_area_pages
get_vm_Area
__ioremap
rioremap_nocache
sysfs_mkdir
pci_device_probe
bus_match
driver_attach
bus_add_driver
driver_register
proc_register
pci_register_driver
init
init
kernel_thread_helper

Linux middle 2.5.64 #1 Thu Mar 13 16:43:09 CET 2003 i686 unknown unknown GNU/Linux
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
module-init-tools      0.9.10
e2fsprogs              1.32
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.9
Modules Loaded         tdfxfb cfbimgblt

00:00.0 Host bridge: nVidia Corporation: Unknown device 01e0 (rev a2)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [40] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x1
	Capabilities: [60] #08 [2001]

00:00.1 RAM memory: nVidia Corporation: Unknown device 01eb (rev a2)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation: Unknown device 01ee (rev a2)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation: Unknown device 01ed (rev a2)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.4 RAM memory: nVidia Corporation: Unknown device 01ec (rev a2)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.5 RAM memory: nVidia Corporation: Unknown device 01ef (rev a2)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [48] #08 [01e1]

00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
	Subsystem: Asustek Computer, Inc.: Unknown device 0c11
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at e400 [size=32]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ec004000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at ec005000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin C routed to IRQ 11
	Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] #0a [2080]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ec001000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at d000 [size=8]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
	Subsystem: Asustek Computer, Inc.: Unknown device 8095
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at d400 [size=256]
	Region 1: I/O ports at d800 [size=128]
	Region 2: Memory at ec002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 PCI bridge: nVidia Corporation: Unknown device 006c (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000a000-0000cfff
	Memory behind bridge: d0000000-dfffffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 0c11
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev a2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

01:06.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 4 / Voodoo 5 (rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc.: Unknown device 0005
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=128M]
	Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 2: I/O ports at a000 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:07.0 SCSI storage controller: LSI Logic / Symbios Logic 53c860 (rev 13)
	Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 16000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a400 [size=256]
	Region 1: Memory at d9021000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:08.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
	Subsystem: Lite-On Communications Inc LNE100TX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at a800 [size=256]
	Region 1: Memory at d9020000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=256K]

01:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
	Subsystem: Creative Labs SBLive! Player 5.1
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ac00 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at b000 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0a.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
	Subsystem: Promise Technology, Inc. Ultra100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at b400 [size=8]
	Region 1: I/O ports at b800 [size=4]
	Region 2: I/O ports at bc00 [size=8]
	Region 3: I/O ports at c000 [size=4]
	Region 4: I/O ports at c400 [size=64]
	Region 5: Memory at d9000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
a000-cfff : PCI Bus #01
  a000-a0ff : 3Dfx Interactive, In Voodoo 4 / Voodoo 5
  a400-a4ff : LSI Logic / Symbios  53c860
    a400-a47f : sym53c8xx
  a800-a8ff : Lite-On Communicatio LNE100TX
    a800-a8ff : tulip
  ac00-ac1f : Creative Labs SB Live! EMU10k1
    ac00-ac1f : EMU10K1
  b000-b007 : Creative Labs SB Live! MIDI/Game P
  b400-b407 : Promise Technology,  20265
    b400-b407 : ide2
  b800-b803 : Promise Technology,  20265
    b802-b802 : ide2
  bc00-bc07 : Promise Technology,  20265
    bc00-bc07 : ide3
  c000-c003 : Promise Technology,  20265
    c002-c002 : ide3
  c400-c43f : Promise Technology,  20265
    c400-c407 : ide2
    c408-c40f : ide3
    c410-c43f : PDC20265
d000-d007 : PCI device 10de:0066 (nVidia Corporation)
d400-d4ff : PCI device 10de:006a (nVidia Corporation)
d800-d87f : PCI device 10de:006a (nVidia Corporation)
  d800-d83f : NVidia NForce2 - Controller
e400-e41f : PCI device 10de:0064 (nVidia Corporation)
f000-f00f : PCI device 10de:0065 (nVidia Corporation)
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c97ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-00372c59 : Kernel code
  00372c5a-00440ac3 : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
d0000000-dfffffff : PCI Bus #01
  d0000000-d7ffffff : 3Dfx Interactive, In Voodoo 4 / Voodoo 5
  d9000000-d901ffff : Promise Technology,  20265
  d9020000-d90200ff : Lite-On Communicatio LNE100TX
    d9020000-d90200ff : tulip
  d9021000-d90210ff : LSI Logic / Symbios  53c860
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : 3Dfx Interactive, In Voodoo 4 / Voodoo 5
e8000000-ebffffff : PCI device 10de:01e0 (nVidia Corporation)
ec000000-ec0000ff : PCI device 10de:0068 (nVidia Corporation)
ec001000-ec001fff : PCI device 10de:0066 (nVidia Corporation)
ec002000-ec002fff : PCI device 10de:006a (nVidia Corporation)
  ec002000-ec0021ff : NVidia NForce2 - AC'97
ec004000-ec004fff : PCI device 10de:0067 (nVidia Corporation)
ec005000-ec005fff : PCI device 10de:0067 (nVidia Corporation)
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

Linux version 2.5.64 (root@middle) (gcc version 3.2.3 20030309 (Debian prerelease)) #1 Thu Mar 13 16:43:09 CET 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: root=/dev/hda1 hdb=scsi apm=power-off
ide_setup: hdb=scsi
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1996.046 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3948.54 BogoMIPS
Memory: 903596k/917504k available (2507k kernel code, 13124k reserved, 823k data, 380k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Failed to register 'sysfs' in sysfs
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Machine check exception polling timer started.
CPU: AMD Athlon(tm) XP 2400+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfb4c0, last bus=2
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router default [10de/01e0] at 00:00.0
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Enabling SEP on CPU 0
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
NTFS driver 2.1.0 [Flags: R/O].
udf: registering filesystem
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Real Time Clock Driver v1.11
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
Linux agpgart interface v0.100 (c) Dave Jones
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Linux Tulip driver version 1.1.13 (May 11, 2002)
tulip0:  MII transceiver #1 config 3100 status 7829 advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 32 at 0xf8800000, 00:A0:CC:21:A1:AC, IRQ 5.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100 controller on pci00:09.0
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DTLA-307045, ATA DISK drive
hdb: LITE-ON LTR-40125W, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Maxtor 4G120J6, ATA DISK drive
hdd: Maxtor 4G120J6, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20265: IDE controller at PCI slot 01:0a.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xc400-0xc407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xc408-0xc40f, BIOS settings: hdg:DMA, hdh:pio
hde: WDC WD800JB-00CRA1, ATA DISK drive
ide2 at 0xb400-0xb407,0xb802 on irq 5
hdg: WDC WD800JB-00CRA1, ATA DISK drive
ide3 at 0xbc00-0xbc07,0xc002 on irq 5
hda: host protected area => 1
hda: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >
hdc: host protected area => 1
hdc: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(33)
 hdc: hdc1 hdc2
hdd: host protected area => 1
hdd: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(33)
 hdd: hdd1 hdd2
hde: host protected area => 1
hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=155061/16/63, UDMA(100)
 hde: hde1 hde2
hdg: host protected area => 1
hdg: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=155061/16/63, UDMA(100)
 hdg: hdg1 hdg2
ide-cd: passing drive hdb to ide-scsi emulation.
scsi HBA driver sym53c8xx didn't set a release method, please fix the template
sym.1.7.0: setting PCI_COMMAND_PARITY...
sym.1.7.0: setting PCI_COMMAND_INVALIDATE.
sym0: <860> rev 0x13 on pci bus 1 device 7 function 0 irq 11
sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.16a
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1401  Rev: 1007
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0N
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: LTR-40125W        Rev: WS05
  Type:   CD-ROM                             ANSI SCSI revision: 02
st: Version 20021214, fixed bufsize 32768, wrt 30720, s/g segs 256
sym0:1: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 8)
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
sym0:2: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 8)
sr1: scsi-1 drive
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
sym0:5: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 7)
sr2: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr2 at scsi0, channel 0, id 5, lun 0
sr3: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr3 at scsi1, channel 0, id 0, lun 0
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.11:USB Scanner Driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
i2c-proc.o version 2.7.0 (20021208)
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  2832.000 MB/sec
   8regs_prefetch:  2740.000 MB/sec
   32regs    :  1948.000 MB/sec
   32regs_prefetch:  1744.000 MB/sec
   pIII_sse  :  5312.000 MB/sec
   pII_mmx   :  4584.000 MB/sec
   p5_mmx    :  5836.000 MB/sec
raid5: using function: pIII_sse (5312.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Advanced Linux Sound Architecture Driver Version 0.9.0rc7 (Sat Feb 15 15:01:21 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
PCI: Setting latency timer of device 00:06.0 to 64
intel8x0: clocking to 47447
ALSA device list:
  #0: NVidia NForce2 at 0xec002000, irq 5
  #1: Sound Blaster Live! (rev.7) at 0xac00, irq 11
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdg2 ...
md:  adding hdg2 ...
md: hdg1 has different UUID to hdg2
md:  adding hde2 ...
md: hde1 has different UUID to hdg2
md: created md1
md: bind<hde2>
md: bind<hdg2>
md: running: <hdg2><hde2>
md1: max total readahead window set to 512k
md1: 2 data-disks, max readahead per data-disk: 256k
md1: setting max_sectors to 128, segment boundary to 32767
raid0: looking at hdg2
raid0:   comparing hdg2(17670656) with hdg2(17670656)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hde2
raid0:   comparing hde2(17670656) with hdg2(17670656)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 35341312 blocks.
raid0 : conf->smallest->size is 35341312 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: marking sb clean...
md: marking sb clean...
md: updating md1 RAID superblock on device (in sync 1)
md: hdg2 <6>(write) hdg2's sb offset: 17670656
md: hde2 <6>(write) hde2's sb offset: 17670656
md: considering hdg1 ...
md:  adding hdg1 ...
md:  adding hde1 ...
md: created md0
md: bind<hde1>
md: bind<hdg1>
md: running: <hdg1><hde1>
md0: max total readahead window set to 512k
md0: 2 data-disks, max readahead per data-disk: 256k
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at hdg1
raid0:   comparing hdg1(60479872) with hdg1(60479872)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hde1
raid0:   comparing hde1(60479872) with hdg1(60479872)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 120959744 blocks.
raid0 : conf->smallest->size is 120959744 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: marking sb clean...
md: marking sb clean...
md: updating md0 RAID superblock on device (in sync 1)
md: hdg1 <6>(write) hdg1's sb offset: 60479872
md: hde1 <6>(write) hde1's sb offset: 60479872
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 380k freed
Adding 2000368k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,8), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,8)) for (ide0(3,8))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,6), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,6)) for (ide0(3,6))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,5), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,5)) for (ide0(3,5))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,10), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,10)) for (ide0(3,10))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device md(9,0), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (md(9,0)) for (md(9,0))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device md(9,1), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (md(9,1)) for (md(9,1))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide1(22,1), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide1(22,1)) for (ide1(22,1))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide1(22,2), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide1(22,2)) for (ide1(22,2))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide1(22,65), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide1(22,65)) for (ide1(22,65))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide1(22,66), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide1(22,66)) for (ide1(22,66))
Using r5 hash to sort names
eth0: Setting full-duplex based on MII#1 link partner capability of 05e1.
fb: Can't remap 3Dfx Voodoo5 register area.
-- 
The mark of a true M.B.A. is that he is often wrong but seldom in doubt.
GNU/Linux 2.5.64 SMP/ReiserFS 3948 bogomips load av: 0.65 0.29 0.12

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266354AbSKOPBp>; Fri, 15 Nov 2002 10:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266359AbSKOPBp>; Fri, 15 Nov 2002 10:01:45 -0500
Received: from [212.6.171.6] ([212.6.171.6]:30985 "EHLO ns0.ia-scherer.de")
	by vger.kernel.org with ESMTP id <S266354AbSKOPBk>;
	Fri, 15 Nov 2002 10:01:40 -0500
From: andrei.voropaev@simcon-mt.de
Date: Fri, 15 Nov 2002 15:12:32 +0100
To: linux-kernel@vger.kernel.org
Subject: No sound on VIA chipset VT8233
Message-ID: <20021115141232.GA13742@avorop.simcon-mt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Playing a sound file does not produce any sound. Sometime "Input/Output error" is reported.

I have motherboard with VIA Apollo KT266 chipset (south bridge VT8233) with
integrated sound. I'm using ALSA sound drivers for it (v 0.9.0rc5). The
modules load without problems, the card is detected correctly. But aplay
application sometimes returns Input/Output error, and other times works
without complains but no sound is generated. (Yes, I have unmuted all channels
:) I also read Documentation/sound/VIA-chipset and I know that I have pci
quirks enabled (I guess it's default for version 2.4.x) but ISA DMA work
around is not turned on for my configuration. So I decided to report problem.

Thank you

Andrei Voropaev

Details

Kernel

Linux version 2.4.19 (root@avorop) (gcc version 2.95.3 20010315 (release)) #14
Fri Nov 15 13:17:16 CET 2002

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 1800+
stepping        : 2
cpu MHz         : 1533.115
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnowbogomips        : 3060.53

Modules

snd-via82xx             7468   0 (autoclean)
snd-pcm                54784   0 (autoclean) [snd-via82xx]
snd-timer              10632   0 (autoclean) [snd-pcm]
snd-mpu401-uart         2688   0 (autoclean) [snd-via82xx]
snd-rawmidi            12704   0 (autoclean) [snd-mpu401-uart]
snd-seq-device          3904   0 (autoclean) [snd-rawmidi]
snd-ac97-codec         24836   0 (autoclean) [snd-via82xx]
snd                    24236   0 (autoclean) [snd-via82xx snd-pcm snd-timer
snd-mpu401-uart snd-rawmidi snd-seq-device snd-ac97-codec]
soundcore               3556   0 (autoclean) [snd]
NVdriver             1065152   0 (unused)
ide-scsi                7632   0
scsi_mod               53740   1 [ide-scsi]
nls_iso8859-1           2844   1 (autoclean)
nls_cp437               4348   1 (autoclean)
vfat                    9532   1 (autoclean)
fat                    29720   0 (autoclean) [vfat]
ext3                   56768   1 (autoclean)
jbd                    36376   1 (autoclean) [ext3]

/proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
a000-a0ff : Accton Technology Corporation SMC2-1211TX
  a000-a0ff : 8139too
a400-a41f : AVM Audiovisuelles MKTG & Computer System GmbH Fritz!PCI v2.0 ISDN
a800-a80f : VIA Technologies, Inc. Bus Master IDE
  a800-a807 : ide0
  a808-a80f : ide1
ac00-ac1f : VIA Technologies, Inc. UHCI USB
  ac00-ac1f : usb-uhci
b000-b01f : VIA Technologies, Inc. UHCI USB (#2)
  b000-b01f : usb-uhci
b800-b8ff : VIA Technologies, Inc. VT8233 AC97 Audio Controller
  b800-b8ff : VIA8233

/proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-00212ea5 : Kernel code
  00212ea6-00284093 : Kernel data
d0000000-d7ffffff : PCI Bus #01
  d0000000-d7ffffff : nVidia Corporation NV11 (GeForce2 MX)
    d0000000-d3ffffff : vesafb
d8000000-dbffffff : VIA Technologies, Inc. VT8367 [KT266]
dc000000-ddffffff : PCI Bus #01
  dc000000-dcffffff : nVidia Corporation NV11 (GeForce2 MX)
df000000-df0000ff : Accton Technology Corporation SMC2-1211TX
  df000000-df0000ff : 8139too
df001000-df00101f : AVM Audiovisuelles MKTG & Computer System GmbH Fritz!PCI v2.0 ISDN

PCI info
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dc000000-ddffffff
	Prefetchable memory behind bridge: d0000000-d7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX (rev 10)
	Subsystem: Accton Technology Corporation: Unknown device 9211
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a000 [size=256]
	Region 1: Memory at df000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH Fritz!PCI v2.0 ISDN (rev 01)
	Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH Fritz!PCI v2.0 ISDN
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at df001000 (32-bit, non-prefetchable) [size=32]
	Region 1: I/O ports at a400 [size=32]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=55mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Subsystem: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at a800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at ac00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at b000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 10)
	Subsystem: Micro-star International Co Ltd: Unknown device 5360
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 11
	Region 0: I/O ports at b800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX] (rev b2) (prog-if 00 [VGA])
	Subsystem: PROLINK Microsystems Corp: Unknown device 1081
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


SCSI

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SAMSUNG  Model: DVD-ROM SD-616F  Rev: E101
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: CyberDrv Model: CW038D CD-R/RW   Rev: 110C
  Type:   CD-ROM                           ANSI SCSI revision: 02


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281064AbRKYVIp>; Sun, 25 Nov 2001 16:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281063AbRKYVIg>; Sun, 25 Nov 2001 16:08:36 -0500
Received: from urc1.cc.kuleuven.ac.be ([134.58.10.3]:58581 "EHLO
	urc1.cc.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S281061AbRKYVIU>; Sun, 25 Nov 2001 16:08:20 -0500
Message-Id: <200111252108.fAPL8Hwh182638@urc1.cc.kuleuven.ac.be>
Content-Type: text/plain; charset=US-ASCII
From: Marko van Dooren <Marko.vanDooren@cs.kuleuven.ac.be>
Reply-To: Marko.vanDooren@cs.kuleuven.ac.be
Subject: philips CDD 3610 cd-writer freezes system with any 2.4 kernel
Date: Sun, 25 Nov 2001 22:06:42 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] philips CDD 3610 cd-writer freezes system with any 2.4 kernel
[.2] with any 2.4 kernel, writing a cd results in a system freeze. fast 
blanking works, but writing locks up everything. With 2.2.x kernels, 
everything works fine. I have a dual celeron system (the *ss-sucking Abit BP6 
mainboard :( )

Both the harddisk (maxtor) and the cdwriter are attached to the DMA33 
controller because the HPT controller on the mainboard is crap.

Following error messages were in /var/log/messages:

Nov 25 21:35:45 progeny kernel: hda: timeout waiting for DMA
Nov 25 21:35:45 progeny kernel: ide_dmaproc: chipset supported 
ide_dma_timeout func only: 14
Nov 25 21:35:45 progeny kernel: hda: status error: status=0x58 { DriveReady 
SeekComplete DataRequest }
Nov 25 21:35:45 progeny kernel: hda: drive not ready for command
Nov 25 21:36:05 progeny kernel: scsi : aborting command due to timeout : pid 
246, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 00 00 ba 00 00 1f 00
Nov 25 21:36:05 progeny kernel: hdd: timeout waiting for DMA
Nov 25 21:36:05 progeny kernel: ide_dmaproc: chipset supported 
ide_dma_timeout func only: 14


[3.] scsi emulation , sg ?
[4.] 2.4.16-pre1 (and any other 2.4 kernel I've tried)

[7.] debian/unstable
[7.1] 

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11m
mount                  2.11m
modutils               2.4.11
e2fsprogs              1.25
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         agpgart NVdriver sg ide-scsi scsi_mod snd-pcm-oss 
snd-pcm-plugin snd-mixer-oss snd-card-sbawe isapnp snd-sb16-csp snd-sb16-dsp 
snd-pcm snd-mixer snd-opl3 snd-hwdep snd-timer snd-mpu401-uart snd-rawmidi 
snd-seq-device snd soundcore parport_pc lp parport ne2k-pci 8390

[7.2]

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 367.506
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov
pat pse36 mmx fxsr
bogomips        : 732.36

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 367.506
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov
pat pse36 mmx fxsr
bogomips        : 734.00

[7.3]

soundcore               3396   0 (autoclean)
NVdriver              713536  17 (autoclean)
sg                     23364   0 (unused)
ide-scsi                7488   0
scsi_mod               80184   2 [sg ide-scsi]
parport_pc             15656   1 (autoclean)
lp                      5664   0 (autoclean)
parport                24768   1 (autoclean) [parport_pc lp]
ne2k-pci                4768   2 (autoclean)
8390                    6208   0 (autoclean) [ne2k-pci]

[7.4]

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
0213-0213 : isapnp read
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
4000-403f : Intel Corp. 82371AB PIIX4 ACPI
5000-501f : Intel Corp. 82371AB PIIX4 ACPI
c000-c01f : Intel Corp. 82371AB PIIX4 USB
c400-c41f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  c400-c41f : ne2k-pci
c800-c81f : Realtek Semiconductor Co., Ltd. RTL-8029(AS) (#2)
  c800-c81f : ne2k-pci
cc00-cc07 : Triones Technologies, Inc. HPT366 / HPT370
d000-d003 : Triones Technologies, Inc. HPT366 / HPT370
d400-d4ff : Triones Technologies, Inc. HPT366 / HPT370
  d400-d407 : ide2
  d410-d4ff : HPT366
d800-d807 : Triones Technologies, Inc. HPT366 / HPT370 (#2)
dc00-dc03 : Triones Technologies, Inc. HPT366 / HPT370 (#2)
e000-e0ff : Triones Technologies, Inc. HPT366 / HPT370 (#2)
  e000-e007 : ide3
  e010-e0ff : HPT366
f000-f00f : Intel Corp. 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0bffffff : System RAM
  00100000-001dddc1 : Kernel code
  001dddc2-0021831f : Kernel data
d0000000-d3ffffff : Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge
d4000000-d5ffffff : PCI Bus #01
  d4000000-d4ffffff : nVidia Corporation Riva TnT2 [NV5]
d6000000-d7ffffff : PCI Bus #01
  d6000000-d7ffffff : nVidia Corporation Riva TnT2 [NV5]

[7.5]

00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x2

00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d4000000-d5ffffff
        Prefetchable memory behind bridge: d6000000-d7ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if 80 
[Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01) (prog-if 00 
[UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at c000 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Subsystem: D-Link System Inc DE-528
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at c400 [size=32]

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Subsystem: D-Link System Inc DE-528
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at c800 [size=32]

00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 / 
HPT370 (rev 01)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at cc00 [size=8]
        Region 1: I/O ports at d000 [size=4]
        Region 4: I/O ports at d400 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]

00:13.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366 / 
HPT370 (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 18
        Region 0: I/O ports at d800 [size=8]
        Region 1: I/O ports at dc00 [size=4]
        Region 4: I/O ports at e000 [size=256]

01:00.0 VGA compatible controller: nVidia Corporation Riva TnT2 [NV5] (rev 
11) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc. AGP-V3800 SGRAM
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at d4000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d6000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=x2

[7.6]

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: E-IDE    Model: CD-ROM 48X/AKU   Rev: U22
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: PHILIPS  Model: CDD3610 CD-R/RW  Rev: 3.01
  Type:   CD-ROM

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTI3Pot (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 11:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbTI3Pot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 11:44:49 -0400
Received: from [195.227.105.178] ([195.227.105.178]:29069 "EHLO
	SpeedMailer.intranet.fbn-dd.de") by vger.kernel.org with ESMTP
	id S261563AbTI3PoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 11:44:23 -0400
Date: Tue, 30 Sep 2003 17:40:35 +0200
From: Martin Pitt <martin@piware.de>
To: linux-kernel@vger.kernel.org
Subject: Call traces due to lost IRQ
Message-ID: <20030930154032.GA795@donald.balu5>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.1; AVE: 6.21.0.1; VDF: 6.21.0.56
	 at server1 has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

[1.] Kernel boot yields lost IRQ with some call traces

[2.] When booting 2.6.0-test6, the following message appears:

	------------- snip -------------
	irq 12: nobody cared!
	Call Trace:
	 [<c010b5ca>] __report_bad_irq+0x2a/0x90
	 [<c010b6bc>] note_interrupt+0x6c/0xa0
	 ...
=09
	handlers:
	[<c0268730>] (i8042_interrupt+0x0/0x180)
	Disabling IRQ #12
	irq 12: nobody cared!
	Call Trace:
	 [<c010b5ca>] __report_bad_irq+0x2a/0x90
	 [<c010b6bc>] note_interrupt+0x6c/0xa0
	 ...
	------------- snip -------------

 (Please see attached dmesg.txt for the full output). Although I did
 not recognize immediate effects of this, it looks undesired and may
 be helpful for debugging.

[3.] kernel, IRQ
[4.] Linux version 2.6.0-test6 (martin@donald) (gcc-Version 3.3.2 20030908 =
(Debian prerelease)) #4 Tue Sep 30 15:25:31 CEST 2003
[5.] -- (no oops)
[6.] triggered when booting the kernel

[7.1.]
Linux donald 2.6.0-test6 #4 Tue Sep 30 15:25:31 CEST 2003 i686 GNU/Linux

Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
e2fsprogs              1.35-WIP
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.12
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.90
Modules Loaded         floppy sr_mod cdrom nvidia

[7.2.]
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 7
model name      : AMD Duron(tm) processor
stepping        : 1
cpu MHz         : 1296.105
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2547.71

[7.3.]
floppy 54548 0 - Live 0xd2edc000
sr_mod 13156 0 - Live 0xd2eb9000
cdrom 33248 1 sr_mod, Live 0xd2ebf000
nvidia 1534200 8 - Live 0xd1a9a000

[7.4.]=20
# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
5000-500f : 0000:00:07.4
  5000-5007 : viapro-smbus
6000-607f : 0000:00:07.4
d000-d00f : 0000:00:07.1
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : 0000:00:07.2
  d400-d41f : uhci-hcd
d800-d81f : 0000:00:07.3
  d800-d81f : uhci-hcd
dc00-dcff : 0000:00:07.5
e000-e003 : 0000:00:07.5
e400-e403 : 0000:00:07.5
e800-e8ff : 0000:00:0b.0
  e800-e8ff : via-rhine

# cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-002cd933 : Kernel code
  002cd934-0039a53f : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-d7ffffff : 0000:00:00.0
d8000000-d9ffffff : PCI Bus #01
  d8000000-d9ffffff : 0000:01:00.0
    d8000000-d8feffff : vesafb
da000000-dbffffff : PCI Bus #01
  da000000-daffffff : 0000:01:00.0
dc010000-dc0100ff : 0000:00:0b.0
  dc010000-dc0100ff : via-rhine
ffff0000-ffffffff : reserved

[7.5.]
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev =
81)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR+
	Latency: 8
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=3D128M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- 64bit=
- FW+ AGP3- Rate=3Dx1,x2
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP+ GART64- 64bit- FW- Rate=3Dx2
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (p=
rog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: da000000-dbffffff
	Prefetchable memory behind bridge: d8000000-d9ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (r=
ev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Ma=
ster IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d000 [size=3D16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UH=
CI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at d400 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UH=
CI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at d800 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 5
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 A=
udio Controller (rev 50)
	Subsystem: VIA Technologies, Inc. VT82C686 AC97 Audio Controller
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 11
	Region 0: I/O ports at dc00 [size=3D256]
	Region 1: I/O ports at e000 [size=3D4]
	Region 2: I/O ports at e400 [size=3D4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0b.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev =
43)
	Subsystem: D-Link System Inc DFE-530TX rev A
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e800 [size=3D256]
	Region 1: Memory at dc010000 (32-bit, non-prefetchable) [size=3D256]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV5 [RIVA TNT2/TNT2 P=
ro] (rev 11) (prog-if 00 [VGA])
	Subsystem: Diamond Multimedia Systems Viper V770
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at da000000 (32-bit, non-prefetchable) [size=3D16M]
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=3D32M]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- 64bit=
- FW- AGP3- Rate=3Dx1,x2
		Command: RQ=3D32 ArqSz=3D0 Cal=3D0 SBA- AGP+ GART64- 64bit- FW- Rate=3Dx2

[7.6.]
# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: _NEC     Model: DV-5500A         Rev: 1.05
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: RICOH    Model: CD-R/RW MP7063A  Rev: 1.30
  Type:   CD-ROM                           ANSI SCSI revision: 02

(Please note that these are actually IDE devices, I use SCSI
emulation).

[7.7]
# cat /proc/interrupts
           CPU0
  0:    1298534          XT-PIC  timer
  1:       8913          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:       4835          XT-PIC  serial
  5:          0          XT-PIC  acpi, uhci-hcd, uhci-hcd
  8:          4          XT-PIC  rtc
 10:        209          XT-PIC  nvidia
 11:       2765          XT-PIC  eth0
 14:      16296          XT-PIC  ide0
 15:         22          XT-PIC  ide1
NMI:          0
LOC:    1298465
ERR:       3011
MIS:          0



[X.]
I attach the output of dmesg (dmesg.txt) and my kernel config
(config.gz).

Thanks very much for your efforts! 2.6 is great!

Martin
--=20
Martin Pitt
home:  www.piware.de
eMail: martin@piware.de

--huq684BweRXVnRxX
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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
Ahx3LU3xP35/U0QRYwAA

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"

5>255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AWARD                                     ) @ 0x000f7700
ACPI: RSDT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3000
ACPI: FADT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3040
ACPI: DSDT (v001 AWARD  AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: root=/dev/discs/disc0/part7 ro vga=0x305
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1296.105 MHz processor.
Console: colour dummy device 80x25
Memory: 255640k/262080k available (1846k kernel code, 5716k reserved, 819k data, 152k init, 0k highmem)
Calibrating delay loop... 2547.71 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Duron(tm) processor stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1295.0478 MHz.
..... host bus clock speed is 199.0304 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb470, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030813
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:.........................................................................
Table [DSDT](id F004) - 323 Objects with 30 Devices 73 Methods 20 Regions
ACPI Namespace successfully loaded at root c03d431c
spurious 8259A interrupt: IRQ7.
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 0000000000004020 on int 5
Completing Region/Field/Buffer/Package initialization:..............................................
Initialized 20/20 Regions 1/1 Fields 16/16 Buffers 9/9 Packages (331 nodes)
Executing all Device _STA and_INI methods:...............................
31 Devices found containing: 31 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
vesafb: framebuffer at 0xd8000000, mapped to 0xd0806000, size 16320k
vesafb: mode is 1024x768x8, linelength=1024, pages=20
vesafb: protected mode interface info at c000:03b8
vesafb: scrolling: redraw
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
PCI: Via IRQ fixup for 0000:00:07.2, from 12 to 5
PCI: Via IRQ fixup for 0000:00:07.3, from 12 to 5
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 128M @ 0xd0000000
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
via-rhine.c:v1.10-LK1.1.19-2.5  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xdc010000, 00:50:ba:fb:bd:7a, IRQ 11.
eth0: MII PHY found at address 8, status 0x782d advertising 01e1 Link 45e1.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 91301U3, ATA DISK drive
hdb: _NEC DV-5500A, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: RICOH CD-R/RW MP7063A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 25410672 sectors (13010 MB) w/512KiB Cache, CHS=25209/16/63, UDMA(66)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 >
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: _NEC      Model: DV-5500A          Rev: 1.05
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: RICOH     Model: CD-R/RW MP7063A   Rev: 1.30
  Type:   CD-ROM                             ANSI SCSI revision: 02
Console: switching to colour frame buffer device 128x48
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:07.2: UHCI Host Controller
uhci-hcd 0000:00:07.2: irq 5, io base 0000d400
uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci-hcd 0000:00:07.2: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.0-test6 uhci-hcd
usb usb1: SerialNumber: 0000:00:07.2
drivers/usb/core/usb.c: usb_hotplug
usb usb1: registering 1-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: Port indicators are not supported
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: hub controller current requirement: 0mA
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
uhci-hcd 0000:00:07.3: UHCI Host Controller
uhci-hcd 0000:00:07.3: irq 5, io base 0000d800
uhci-hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci-hcd 0000:00:07.3: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.0-test6 uhci-hcd
usb usb2: SerialNumber: 0000:00:07.3
drivers/usb/core/usb.c: usb_hotplug
usb usb2: registering 2-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: ganged power switching
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: Port indicators are not supported
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: hub controller current requirement: 0mA
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: enabling power on all ports
mice: PS/2 mouse device common for all mice
input: PC Speaker
irq 12: nobody cared!
Call Trace:
 [<c010b5ca>] __report_bad_irq+0x2a/0x90
 [<c010b6bc>] note_interrupt+0x6c/0xa0
 [<c010b980>] do_IRQ+0x120/0x130
 [<c0109d08>] common_interrupt+0x18/0x20
 [<c0122c40>] do_softirq+0x40/0xa0
 [<c010b95c>] do_IRQ+0xfc/0x130
 [<c0109d08>] common_interrupt+0x18/0x20
 [<c010be7e>] setup_irq+0x7e/0xf0
 [<c0268730>] i8042_interrupt+0x0/0x180
 [<c010ba13>] request_irq+0x83/0xd0
 [<c03b4cad>] i8042_check_mux+0x3d/0x170
 [<c0268730>] i8042_interrupt+0x0/0x180
 [<c03b520a>] i8042_init+0x11a/0x150
 [<c039e75b>] do_initcalls+0x2b/0xa0
 [<c012e4ff>] init_workqueues+0xf/0x50
 [<c01050d2>] init+0x32/0x160
 [<c01050a0>] init+0x0/0x160
 [<c0107289>] kernel_thread_helper+0x5/0xc

handlers:
[<c0268730>] (i8042_interrupt+0x0/0x180)
Disabling IRQ #12
irq 12: nobody cared!
Call Trace:
 [<c010b5ca>] __report_bad_irq+0x2a/0x90
 [<c010b6bc>] note_interrupt+0x6c/0xa0
 [<c010b980>] do_IRQ+0x120/0x130
 [<c0109d08>] common_interrupt+0x18/0x20
 [<c0122c40>] do_softirq+0x40/0xa0
 [<c010b95c>] do_IRQ+0xfc/0x130
 [<c0109d08>] common_interrupt+0x18/0x20
 [<c010be7e>] setup_irq+0x7e/0xf0
 [<c0268730>] i8042_interrupt+0x0/0x180
 [<c010ba13>] request_irq+0x83/0xd0
 [<c03b4e12>] i8042_check_aux+0x32/0x150
 [<c0268730>] i8042_interrupt+0x0/0x180
 [<c03b51e1>] i8042_init+0xf1/0x150
 [<c039e75b>] do_initcalls+0x2b/0xa0
 [<c012e4ff>] init_workqueues+0xf/0x50
 [<c01050d2>] init+0x32/0x160
 [<c01050a0>] init+0x0/0x160
 [<c0107289>] kernel_thread_helper+0x5/0xc

handlers:
[<c0268730>] (i8042_interrupt+0x0/0x180)
Disabling IRQ #12
irq 12: nobody cared!
Call Trace:
 [<c010b5ca>] __report_bad_irq+0x2a/0x90
 [<c010b6bc>] note_interrupt+0x6c/0xa0
 [<c010b980>] do_IRQ+0x120/0x130
 [<c0109d08>] common_interrupt+0x18/0x20
 [<c0122c40>] do_softirq+0x40/0xa0
 [<c010b95c>] do_IRQ+0xfc/0x130
 [<c0109d08>] common_interrupt+0x18/0x20
 [<c010be7e>] setup_irq+0x7e/0xf0
 [<c0268730>] i8042_interrupt+0x0/0x180
 [<c010ba13>] request_irq+0x83/0xd0
 [<c0268608>] i8042_open+0x68/0x100
 [<c0268730>] i8042_interrupt+0x0/0x180
 [<c0268288>] serio_open+0x18/0x40
 [<c02679ae>] atkbd_connect+0x11e/0x330
 [<c0267cea>] serio_find_dev+0x6a/0x80
 [<c0268000>] serio_register_port+0x40/0x60
 [<c03b4f6f>] i8042_port_register+0x3f/0x90
 [<c03b51f9>] i8042_init+0x109/0x150
 [<c039e75b>] do_initcalls+0x2b/0xa0
 [<c012e4ff>] init_workqueues+0xf/0x50
 [<c01050d2>] init+0x32/0x160
 [<c01050a0>] init+0x0/0x160
 [<c0107289>] kernel_thread_helper+0x5/0xc

handlers:
[<c0268730>] (i8042_interrupt+0x0/0x180)
Disabling IRQ #12
drivers/usb/host/uhci-hcd.c: d800: suspend_hc
drivers/usb/host/uhci-hcd.c: d400: suspend_hc
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver
NET: Registered protocol family 2
hub 2-0:1.0: port 1, status 100, change 3, 12 Mb/s
hub 2-0:1.0: port 2, status 100, change 3, 12 Mb/s
hub 1-0:1.0: port 1, status 100, change 3, 12 Mb/s
hub 1-0:1.0: port 2, status 100, change 3, 12 Mb/s
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 160 bytes per conntrack
hub 2-0:1.0: port 1 enable change, status 100
hub 2-0:1.0: port 2 enable change, status 100
hub 1-0:1.0: port 1 enable change, status 100
hub 1-0:1.0: port 2 enable change, status 100
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda7) for (hda7)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 152k freed
Adding 248968k swap on /dev/discs/disc0/part5.  Priority:-1 extents:1
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4191  Mon Dec  9 11:49:01 PST 2002
found reiserfs format "3.5" with standard journal
Reiserfs journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda6) for (hda6)
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda8) for (hda8)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda10) for (hda10)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda9) for (hda9)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda11) for (hda11)
Using r5 hash to sort names
eth0: Setting full-duplex based on MII #8 link partner capability of 45e1.
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
sr0: scsi3-mmc drive: 17x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 0, lun 0
cdrom: open failed.
inserting floppy driver for 2.6.0-test6
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077

--huq684BweRXVnRxX--

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD4DBQE/eaPwDecnbV4Fd/IRAqQnAJ9AVrUTcuN6MK9CIhFvJgkmIx2pLACVERvN
WimGd4fqlurUNV+GHidbYA==
=4y9J
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129437AbQLEFZt>; Tue, 5 Dec 2000 00:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129391AbQLEFZk>; Tue, 5 Dec 2000 00:25:40 -0500
Received: from CPE-144-132-68-164.vic.bigpond.net.au ([144.132.68.164]:12020
	"HELO crazney.dna") by vger.kernel.org with SMTP id <S129340AbQLEFZ0> convert rfc822-to-8bit;
	Tue, 5 Dec 2000 00:25:26 -0500
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0
From: David Hammerton <ahammert@bigpond.net.au>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Kernel 2.4-test12-pre4 BUG - scsi (?)
X-Mailer: Pronto v2.2.1
Date: 04 Dec 2000 23:54:27 EST
Reply-To: David Hammerton <ahammert@bigpond.net.au>
Message-Id: <20001205045429.0FFDF1B3565@crazney.dna>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:	 
	During burning of CD onto SCSI driver (using cdrecord) crashes. during
the burn (10% or so) it crashes with "Unable to handle kernel null pointer"

[2.] Full description of the problem/report:
	During burning of CD onto SCSI driver (using cdrecord) crashes. during
the burn (10% or so) it crashes with "Unable to handle kernel null pointer" and
dumps a whole lot of things to the screen (flags of some sort, eg "eax=..")

[3.] Keywords (i.e., modules, networking, kernel):
	scsi, cd record, null pointer

[4.] Kernel version (from /proc/version):
	Linux version 2.4.0-test12 (root@crazney) (gcc version 2.95.3 19991030
(prerelease)) #5 Tue Dec 5 10:55:46 EST 2000

[7.] Environment
	console??

[7.1.] Software (add the output of the ver_linux script here)
	Cdrecord 1.8.1 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg
Schilling

	$ sh ver_linux 
	-- Versions installed: (if some fields are empty or look
	-- unusual then possibly you have very old versions)
	Linux crazney 2.4.0-test12 #5 Tue Dec 5 10:55:46 EST 2000 i686 unknown
	Kernel modules	       2.3.17
	Gnu C		       2.95.3
	Gnu Make	       3.79
	Binutils	       2.9.5.0.31
	Linux C Library        2.1.3
	Dynamic linker	       ldd (GNU libc) 2.1.3
	Procps		       2.0.6
	Mount		       2.10h
	Net-tools	       1.55
	Console-tools	       0.2.3
	Sh-utils	       2.0
	Modules Loaded	       NVdriver 8139too emu10k1


[7.2.] Processor information (from /proc/cpuinfo):
	$ cat /proc/cpuinfo 
	processor	: 0
	vendor_id	: GenuineIntel
	cpu family	: 6
	model		: 8
	model name	: Pentium III (Coppermine)
	stepping	: 3
	cpu MHz 	: 701.606
	cache size	: 256 KB
	fdiv_bug	: no
	hlt_bug 	: no
	f00f_bug	: no
	coma_bug	: no
	fpu		: yes
	fpu_exception	: yes
	cpuid level	: 3
	wp		: yes
	flags	: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr sse
	bogomips	: 1399.19

[7.3.] Module information (from /proc/modules):
	$ cat /proc/modules 
	NVdriver	      530416  17 (autoclean)
	8139too 	       15296   1 (autoclean)
	emu10k1 	       42960   0


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
	$ cat /proc/ioports 
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
	0376-0376 : ide1
	03c0-03df : vga+
	03f6-03f6 : ide0
	0cf8-0cff : PCI conf1
	4000-403f : Intel Corporation 82371AB PIIX4 ACPI
	5000-501f : Intel Corporation 82371AB PIIX4 ACPI
	c000-c01f : Intel Corporation 82371AB PIIX4 USB
	c400-c4ff : Symbios Logic Inc. (formerly NCR) 53c810
	   c400-c47f : ncr53c8xx
	c800-c81f : Creative Labs SB Live! EMU10000
	  c800-c81f : EMU10K1
	cc00-cc07 : Creative Labs SB Live!
	d000-d0ff : Accton Technology Corporation SMC2-1211TX
	  d000-d0ff : eth0
	d400-d407 : Triones Technologies, Inc. HPT366
	  d400-d407 : ide2
	d800-d803 : Triones Technologies, Inc. HPT366
	  d802-d802 : ide2
	dc00-dcff : Triones Technologies, Inc. HPT366
	  dc00-dc07 : ide2
	  dc10-dcff : HPT366
	e000-e007 : Triones Technologies, Inc. HPT366 (#2)
	e400-e403 : Triones Technologies, Inc. HPT366 (#2)
	e800-e8ff : Triones Technologies, Inc. HPT366 (#2)
	  e800-e807 : ide3
	  e810-e8ff : HPT366
	f000-f00f : Intel Corporation 82371AB PIIX4 IDE
	  f000-f007 : ide0
	  f008-f00f : ide1


	$ cat /proc/iomem 
	00000000-0009efff : System RAM
	000a0000-000bffff : Video RAM area
	000c0000-000c7fff : Video ROM
	000d0000-000d17ff : Extension ROM
	000f0000-000fffff : System ROM
	00100000-09ffffff : System RAM
	  00100000-00257e2f : Kernel code
	  00257e30-0026cee3 : Kernel data
	d8000000-dfffffff : PCI Bus #01
	  d8000000-dfffffff : nVidia Corporation NV15 (Geforce2 GTS)
	e0000000-e3ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
	e4000000-e7ffffff : S3 Inc. ViRGE/DX or /GX
	e8000000-e9ffffff : PCI Bus #01
	  e8000000-e8ffffff : nVidia Corporation NV15 (Geforce2 GTS)
	ec000000-ec0000ff : Accton Technology Corporation SMC2-1211TX
	  ec000000-ec0000ff : eth0
	ec001000-ec0010ff : Symbios Logic Inc. (formerly NCR) 53c810

[7.5.] PCI information ('lspci -vvv' as root)
	See end of email (look down!)

[7.6.] SCSI information (from /proc/scsi/scsi)
	$ cat /proc/scsi/scsi 
	Attached devices: 
	Host: scsi0 Channel: 00 Id: 01 Lun: 00
	  Vendor: MATSHITA Model: CD-R	 CW-7502   Rev: 4.17
	  Type:   CD-ROM			   ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

	scsi card is a Symbios Logic Inc. (formerly NCR) 53c810 compiled INTO
the kernle (statically linked).
	other scsi stuff in the kernel is:

	*SCSI support [Y]
	*SCSI CD-ROM support [Y]
		2 max drives as modules
	*SCSI generic support [Y]
---- Low level
		<*> NCR53C8XX SCSI support
		(4)   default tagged command queue depth
		(32)   maximum number of queued commands
		(20)   synchronous transfers frequency in MHz
--------------------
output of "cdrecord -scanbus":
# cdrecord -scanbus
Cdrecord 1.8.1 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
Using libscg version 'schily-0.1'
scsibus0:
	0,0,0	  0) *
	0,1,0	  1) 'MATSHITA' 'CD-R	CW-7502  ' '4.17' Removable CD-ROM
	0,2,0	  2) *
	0,3,0	  3) *
	0,4,0	  4) *
	0,5,0	  5) *
	0,6,0	  6) *
	0,7,0	  7) *
-----------------------

I havent burned any cd's since 2.4-test5, so i dont know when this problem was
introduced.

-----------------------------
[7.5.] PCI information ('lspci -vvv' as root)

# lspci -vvv
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev
03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32 set
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e8000000-e9ffffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80
[Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set
	Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if
00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at c000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:09.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01) (prog-if 00
[VGA])
	Subsystem: S3 Inc. ViRGE/DX
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 4
	Region 0: Memory at e4000000 (32-bit, non-prefetchable) [disabled]
[size=64M]
	Expansion ROM at ea000000 [disabled] [size=64K]

00:0b.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c810 (rev
23)
	Subsystem: Symbios Logic Inc. (formerly NCR) 8100S
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 64 max, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at c400 [size=256]
	Region 1: Memory at ec001000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 08)
	Subsystem: Creative Labs CT4832 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 2 min, 20 max, 32 set
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at c800 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.1 Input device controller: Creative Labs SB Live! (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set
	Region 0: I/O ports at cc00 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX (rev 10)
	Subsystem: Accton Technology Corporation EN-1207D Fast Ethernet Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 min, 64 max, 32 set
	Interrupt: pin A routed to IRQ 4
	Region 0: I/O ports at d000 [size=256]
	Region 1: Memory at ec000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME+
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Vital Product Data

00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev
01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 8 max, 248 set, cache line size 08
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at d400 [size=8]
	Region 1: I/O ports at d800 [size=4]
	Region 4: I/O ports at dc00 [size=256]
	Expansion ROM at eb000000 [disabled] [size=128K]

00:13.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev
01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 8 max, 248 set, cache line size 08
	Interrupt: pin B routed to IRQ 3
	Region 0: I/O ports at e000 [size=8]
	Region 1: I/O ports at e400 [size=4]
	Region 4: I/O ports at e800 [size=256]

01:00.0 VGA compatible controller: nVidia Corporation NV15 (Geforce2 GTS) (rev
a3) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 400e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 5 min, 1 max, 248 set
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

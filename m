Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbTBHAvv>; Fri, 7 Feb 2003 19:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266939AbTBHAvv>; Fri, 7 Feb 2003 19:51:51 -0500
Received: from 12-252-67-253.client.attbi.com ([12.252.67.253]:21389 "EHLO
	morningstar.nowhere.lie") by vger.kernel.org with ESMTP
	id <S266938AbTBHAvo>; Fri, 7 Feb 2003 19:51:44 -0500
From: "John W. M. Stevens" <john@betelgeuse.us>
Date: Fri, 7 Feb 2003 18:01:24 -0700
To: linux-kernel@vger.kernel.org
Subject: Bug Report (more information)
Message-ID: <20030208010124.GA30737@morningstar.nowhere.lie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a repeat of an earlier bug report, with more information about
how to reproduce it.

[1.] One line summary of the problem:

   Defect is kernel hang on Dual Processor, Athlon MP system.

[2.] Full description of the problem/report:

   The system regularly experiences short (from 1 to 5 seconds)
   hangs where both processors appear to be "hung".  Most often,
   the system will recover, but in three different cases the
   system has hung "permanently" (for values of "permanently"
   ranging from 10 minutes, to at most four hours before I gave
   up and hit reset).

[3.] Keywords (i.e., modules, networking, kernel):

   Hard freeze.

[4.] Kernel version (from /proc/version):

   Linux version 2.4.20 (root@morningstar)
   (gcc version 2.95.4 20011002 (Debian prerelease))
   #20 SMP Thu Feb 6 20:35:14 MST 2003

[5.] Output of Oops.

   Sorry, but since the system hung, there was no Oops.

[6.] A small shell script or example program which triggers the
	      problem (if possible)

   Two steps: 1) enable support for AMD Viper chipset and using
   DMA by default.  2) Using IDE-SCSI, attemp to burn a CD.

   After several seconds, system will lock up.

[7.] Environment

   Memory      : 512 MBytes, ECC, 266 MHz FSB.
   Disk        : All SCSI.  See below.
   Mother Board: Tyan Tiger MPX S2466N
   Networking  : Two ethernet cards, one 10 Mbps, one 100 Mbps.
   Removable   : Samsung CDRW drive.

   Adquate cooling and power.

[7.1.] Software (add the output of the ver_linux script here)


If some fields are empty or look unusual you may have an old version.
   Compare to the current minimal requirements in Documentation/Changes.
 
   Linux morningstar 2.4.18 #13 SMP Sat Jan 18 13:21:01 MST 2003 i686 unknown
 
   Gnu C                  2.95.4
   Gnu make               3.79.1
   util-linux             2.11n
   mount                  2.11n
   modutils               2.4.15
   e2fsprogs              1.27
   PPP                    2.4.1
   Linux C Library        2.2.5
   Dynamic linker (ldd)   2.2.5
   Procps                 2.0.7
   Net-tools              1.60
   Console-tools          0.2.3
   Sh-utils               2.0.11
   Modules Loaded         

[7.2.] Processor information (from /proc/cpuinfo):

   processor	: 0
   vendor_id	: AuthenticAMD
   cpu family	: 6
   model		: 6
   model name	: AMD Athlon(tm) MP 1900+
   stepping	: 2
   cpu MHz		: 1600.063
   cache size	: 256 KB
   fdiv_bug	: no
   hlt_bug		: no
   f00f_bug	: no
   coma_bug	: no
   fpu		: yes
   fpu_exception	: yes
   cpuid level	: 1
   wp		: yes
   flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
   bogomips	: 3191.60

   processor	: 1
   vendor_id	: AuthenticAMD
   cpu family	: 6
   model		: 6
   model name	: AMD Athlon(tm) Processor
   stepping	: 2
   cpu MHz		: 1600.063
   cache size	: 256 KB
   fdiv_bug	: no
   hlt_bug		: no
   f00f_bug	: no
   coma_bug	: no
   fpu		: yes
   fpu_exception	: yes
   cpuid level	: 1
   wp		: yes
   flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
   bogomips	: 3198.15

[7.3.] Module information (from /proc/modules):

   This is an entirely static system . . . no modules.

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
1010-1013 : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
2000-2fff : PCI Bus #02
  2000-20ff : Adaptec AHA-2940U2/U2W
  2400-247f : Digital Equipment Corporation DECchip 21041 [Tulip Pass 3]
    2400-247f : tulip
  2480-24ff : 3Com Corporation 3c905C-TX/TX-M [Tornado]
    2480-24ff : 02:08.0
  2800-283f : Ensoniq ES1371 [AudioPCI-97]
    2800-283f : es1371
f000-f00f : Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc800-000ccfff : Extension ROM
000cd000-000d27ff : Extension ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-1feeffff : System RAM
  00100000-002c4c3b : Kernel code
  002c4c3c-003817bf : Kernel data
1fef0000-1fefefff : ACPI Tables
1feff000-1fefffff : ACPI Non-volatile Storage
1ff00000-1ff7ffff : System RAM
1ff80000-1fffffff : reserved
e0000000-e0ffffff : PCI Bus #01
  e0000000-e0ffffff : nVidia Corporation NV11 [GeForce2 MX]
e1000000-e10fffff : PCI Bus #02
  e1000000-e1000fff : Advanced Micro Devices [AMD] AMD-768 [Opus] USB
    e1000000-e1000fff : usb-ohci
  e1001000-e1001fff : Adaptec AHA-2940U2/U2W
    e1001000-e1001fff : aic7xxx
  e1002000-e100207f : Digital Equipment Corporation DECchip 21041 [Tulip Pass 3]
    e1002000-e100207f : tulip
  e1002400-e100247f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
e1300000-e1300fff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
e8000000-efffffff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
f0000000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : nVidia Corporation NV11 [GeForce2 MX]
fec00000-fec03fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at e1300000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at 1010 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e0000000-e0ffffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD]: Unknown device 7440 (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD]: Unknown device 7441 (rev 04) (prog-if 8a [Master SecP PriP])
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 7441
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD]: Unknown device 7443 (rev 03)
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 7443
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:10.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7448 (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=168
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: e1000000-e10fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

01:05.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX) (rev b2) (prog-if 00 [VGA])
	Subsystem: VISIONTEK: Unknown device 0023
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

02:00.0 USB Controller: Advanced Micro Devices [AMD]: Unknown device 7449 (rev 07) (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 7449
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 64 (20000ns max)
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at e1000000 (32-bit, non-prefetchable) [size=4K]

02:04.0 SCSI storage controller: Adaptec AHA-2940U2/W
	Subsystem: Adaptec: Unknown device a180
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (9750ns min, 6250ns max), cache line size 10
	Interrupt: pin A routed to IRQ 16
	BIST result: 00
	Region 0: I/O ports at 2000 [disabled] [size=256]
	Region 1: Memory at e1001000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 21)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 2400 [size=128]
	Region 1: Memory at e1002000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=256K]

02:07.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort- >SERR- <PERR-
	Latency: 64 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at 2800 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 78)
	Subsystem: Tyan Computer: Unknown device 2466
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 80 (2500ns min, 2500ns max), cache line size 10
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at 2480 [size=128]
	Region 1: Memory at e1002400 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: QUANTUM  Model: ATLAS10K2-TY092L Rev: DA40
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: QUANTUM  Model: ATLAS10K2-TY092L Rev: DA40
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: QUANTUM  Model: ATLAS10K2-TY092L Rev: DA40
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: SAMSUNG  Model: CD-R/RW SW-240B  Rev: R401
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
(please look in /proc and include all information that you
think to be relevant):

   A CD burn starts up, gets about 7 MBytes into the operation,
   then the system hangs, hard!

   The system will hang when the "use DMA by default" is turned
   on, but the AMD Viper support is not compiled in, and when
   the AMD Viper support is compiled in, but "use DMA by default"
   is not enabled.

   No surprise, since the exact same hardware is involved.

   In short, the best guess here is that it's a DMA issue on
   AMD Viper chipsets.

Thanks,
John S.

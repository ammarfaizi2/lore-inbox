Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbTCPBTc>; Sat, 15 Mar 2003 20:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbTCPBTc>; Sat, 15 Mar 2003 20:19:32 -0500
Received: from mercury.mv.net ([199.125.85.40]:62425 "HELO mercury.mv.net")
	by vger.kernel.org with SMTP id <S261900AbTCPBTZ>;
	Sat, 15 Mar 2003 20:19:25 -0500
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Tyan TIGER MPX won't boot 2.5.64 (2.4.20 runs fine)
Message-Id: <E18uMtq-0000NZ-00@vanzandt.mv.net>
From: "James R. Van Zandt" <jrv@vanzandt.mv.com>
Date: Sat, 15 Mar 2003 20:25:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] Tyan TIGER MPX won't boot 2.5.64 (2.4.20 runs fine)

[2.] I have a new Tyan TIGER MPX motherboard with two AMD Athlon MP
2200+ CPUs.  Linux 2.4.20 runs fine (configured SMP).  However, 2.5.64
will not boot.  When I try, the machine freezes up with the following
displayed on the screen (transcribed by hand onto another machine):

  Intel machine check architecture supported.
  Intel machine check reporting enabled on CPU#0.
  Machine check exception polling timer started.
  Enabling fast FPU save and restore... done.
  Enabling unmasked SIMD FPU exception support... done.
  Checking 'hlt' instructioon... OK.
  POSIX conformance testing by UNIFIX
  CPU0: AMD Athlon(tm) MP 2200+ stepping 00
  per-CPU timeslice cutoff: 731.49 usecs.
  task migration cache decay timeout: 1 msecs.
  masked ExtINT on CPU#0
  Leaving ESR disabled.
  Booting processor 1/1 eip 2000
  Storing NMI vector
  APIC never delivered???
  APIC delivery error (4)l.
  CPU #1 not responding - cannot use it.
  Booting processor 1/2 eip 2000
  Storing NMI vector
  APIC never delivered???
  APIC delivery error (4).
  CPU #2 not responding - cannot use it.
  Error: only one processor found.
  ENABLING IO-APIC IRQs
  
[3.] keywords: kernel, SMP
[4.] Kernel version 2.5.64
[5.] 
[6.] 
[7.] 
[7.1.] 
as reported under 2.4.20:
 
Linux vanzandt 2.4.20 #11 SMP Sat Mar 15 18:43:27 EST 2003 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      writing
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         i2c-dev i2c-core 

[7.2.] As reported by 2.4.20 kernel:
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 8
model name	: AMD Athlon(tm) MP 2200+
stepping	: 0
cpu MHz		: 1800.079
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
bogomips	: 3591.37

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 8
model name	: AMD Athlon(tm) Processor
stepping	: 0
cpu MHz		: 1800.079
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
bogomips	: 3591.37


[7.3.] 
[7.4.] 
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
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
1000-10ff : Adaptec AIC-7892A U160/m
1410-1413 : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
2000-2fff : PCI Bus #01
  2000-20ff : PCI device 1002:4966 (ATI Technologies Inc)
3000-3fff : PCI Bus #02
  3000-307f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
    3000-307f : 02:08.0
  3080-309f : Creative Labs SB Live! EMU10k1
    3080-309f : EMU10K1
  30a0-30a7 : Creative Labs SB Live! MIDI/Game Port
  30a8-30af : US Robotics/3Com 56K FaxModem Model 5610
    30a8-30af : serial(auto)
f000-f00f : Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009f3ff : System RAM
0009f400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cd000-000cd7ff : Extension ROM
000cd800-000d2bff : Extension ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-3feeffff : System RAM
  00100000-002d2f8d : Kernel code
  002d2f8e-00369c63 : Kernel data
3fef0000-3fefefff : ACPI Tables
3feff000-3fefffff : ACPI Non-volatile Storage
3ff00000-3ff7ffff : System RAM
3ff80000-3fffffff : reserved
ec000000-ec000fff : Adaptec AIC-7892A U160/m
  ec000000-ec000fff : aic7xxx
ec100000-ec1fffff : PCI Bus #01
  ec100000-ec10ffff : PCI device 1002:4966 (ATI Technologies Inc)
  ec110000-ec11ffff : PCI device 1002:496e (ATI Technologies Inc)
ec200000-ec2fffff : PCI Bus #02
  ec200000-ec200fff : Advanced Micro Devices [AMD] AMD-768 [Opus] USB
    ec200000-ec200fff : usb-ohci
  ec201000-ec20107f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
ec500000-ec500fff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
f0000000-f3ffffff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
f4000000-fbffffff : PCI Bus #01
  f4000000-f7ffffff : PCI device 1002:4966 (ATI Technologies Inc)
  f8000000-fbffffff : PCI device 1002:496e (ATI Technologies Inc)
fec00000-fec03fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

[7.5.] PCI information  ('lspci -vvv' as root)

00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at ec500000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at 1410 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: ec100000-ec1fffff
	Prefetchable memory behind bridge: f4000000-fbffffff
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

00:09.0 SCSI storage controller: Adaptec 7892A (rev 02)
	Subsystem: Adaptec: Unknown device e2a0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (10000ns min, 6250ns max), cache line size 10
	Interrupt: pin A routed to IRQ 17
	BIST result: 00
	Region 0: I/O ports at 1000 [disabled] [size=256]
	Region 1: Memory at ec000000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7448 (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=168
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: ec200000-ec2fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

01:05.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4966 (rev 01) (prog-if 00 [VGA])
	Subsystem: Unknown device 174b:7176
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at 2000 [size=256]
	Region 2: Memory at ec100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.1 Display controller: ATI Technologies Inc: Unknown device 496e (rev 01)
	Subsystem: Unknown device 174b:7177
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 10
	Region 0: Memory at f8000000 (32-bit, prefetchable) [disabled] [size=64M]
	Region 1: Memory at ec110000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 USB Controller: Advanced Micro Devices [AMD]: Unknown device 7449 (rev 07) (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 7449
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at ec200000 (32-bit, non-prefetchable) [size=4K]

02:05.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
	Subsystem: Creative Labs: Unknown device 8064
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 3080 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.1 Input device controller: Creative Labs SB Live! (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at 30a0 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:07.0 Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev 01) (prog-if 02 [16550])
	Subsystem: US Robotics/3Com: Unknown device 00d3
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at 30a8 [size=8]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 78)
	Subsystem: Tyan Computer: Unknown device 2466
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 80 (2500ns min, 2500ns max), cache line size 10
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at 3000 [size=128]
	Region 1: Memory at ec201000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices: 
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST336938LW       Rev: 0003
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST336938LW       Rev: 0003
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: SONY     Model: CD-RW  CRX210E1  Rev: 2YS2
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

The configuration is largely the same as I'm using for 2.4.20
(imported via "make oldconfig") except no modules at all.

I note that processor 0 is reported as "AMD Athlon(tm) MP 2200+",
while the second is just "AMD Athlon(tm) Processor".  Does that mean
the second one is *not* MP?  I.e. did the dealer sell me the wrong
thing?

Thank you

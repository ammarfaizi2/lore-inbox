Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317023AbSGXMcD>; Wed, 24 Jul 2002 08:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317025AbSGXMcD>; Wed, 24 Jul 2002 08:32:03 -0400
Received: from spirit.qbfox.com ([212.67.200.51]:45840 "EHLO spirit.qbfox.com")
	by vger.kernel.org with ESMTP id <S317023AbSGXMcA>;
	Wed, 24 Jul 2002 08:32:00 -0400
Message-Id: <200207241235.NAA01282@spirit.qbfox.com>
From: Per Gregers Bilse <bilse@qbfox.com>
Date: Wed, 24 Jul 2002 13:35:08 +0100
Organization: qbfox
X-Mailer: Mail User's Shell (7.2.2 4/12/91)
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 clock warps 4294 seconds
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] System clock (as returned by eg time(2)) warps 4294 seconds
[2.] Full description of the problem/report can be found below
[3.] system clock, clock warp, Duron
[4.] Linux version 2.4.18 (root@wraith) (gcc version 2.95.3 20010315 (release)) #23 Tue Jul 23 19:22:21 BST 2002
[5.] No Oops
[6.] No small shell script or example program
[7.] Duron 800Mhz, PC Chips M807 mboard, 128M PC100 memory (all BIOS tweaks
set to very conservative values), soft raid
[7.1.] Software
Kernel modules         2.4.13
Gnu C                  2.95.3
Binutils               2.11.90.0.8
Linux C Library        2.2.4
Dynamic linker         ldd (GNU libc) 2.2.4
Procps                 2.0.7
Mount                  2.11g
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         8139too mii loop rtc

[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 3
model name	: AMD Duron(tm) Processor
stepping	: 1
cpu MHz		: 801.452
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1599.07

[7.3.] Module information (from /proc/modules):
8139too                13792   1
mii                     1120   0 [8139too]
loop                    8496   6 (autoclean)
rtc                     5592   0 (autoclean)

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
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-40ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
c000-cfff : PCI Bus #01
  c000-c07f : Silicon Integrated Systems [SiS] 86C326
d000-d00f : VIA Technologies, Inc. Bus Master IDE
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : VIA Technologies, Inc. UHCI USB
dc00-dcff : VIA Technologies, Inc. AC97 Audio Controller
e000-e003 : VIA Technologies, Inc. AC97 Audio Controller
e400-e403 : VIA Technologies, Inc. AC97 Audio Controller
e800-e8ff : VIA Technologies, Inc. AC97 Modem Controller
ec00-ecff : Accton Technology Corporation SMC2-1211TX

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-00efffff : System RAM
  00100000-00282ae9 : Kernel code
  00282aea-002ede97 : Kernel data
00f00000-00ffffff : reserved
01000000-07feffff : System RAM
07ff0000-07ff2fff : ACPI Non-volatile Storage
07ff3000-07ffffff : ACPI Tables
d0000000-d3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
d4000000-d5ffffff : PCI Bus #01
  d5000000-d500ffff : Silicon Integrated Systems [SiS] 86C326
d6000000-d67fffff : PCI Bus #01
  d6000000-d67fffff : Silicon Integrated Systems [SiS] 86C326
d6800000-d68000ff : Accton Technology Corporation SMC2-1211TX
  d6800000-d68000ff : 8139too
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Subsystem: Elitegroup Computer Systems: Unknown device 0987
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: d4000000-d5ffffff
	Prefetchable memory behind bridge: d6000000-d67fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Subsystem: Elitegroup Computer Systems: Unknown device 0987
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 3
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 20)
	Subsystem: VIA Technologies, Inc. AC97 Audio Controller
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at dc00 [size=256]
	Region 1: I/O ports at e000 [size=4]
	Region 2: I/O ports at e400 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.6 Communication controller: VIA Technologies, Inc. AC97 Modem Controller (rev 20)
	Subsystem: SILICON Laboratories: Unknown device 4c21
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at e800 [size=256]
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX (rev 10)
	Subsystem: Accton Technology Corporation EN-1207D Fast Ethernet Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ec00 [size=256]
	Region 1: Memory at d6800000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 (rev 0b) (prog-if 00 [VGA])
	Subsystem: Palit Microsystems Inc. SiS6326 GUI Accelerator
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d6000000 (32-bit, prefetchable) [size=8M]
	Region 1: Memory at d5000000 (32-bit, non-prefetchable) [size=64K]
	Region 2: I/O ports at c000 [size=128]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 1.0
		Status: RQ=1 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.] No SCSI information (from /proc/scsi/scsi)
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

Hi,

I have been experiencing a strange problem, whereby the system clock on
my workstation warps forward 4294 seconds for either a second or two,
or much longer.  The first symptom of the problem was the X screensaver
misbehaving.  I have previously been searching any and all mailing lists
and FAQs, with no result, until the problem occurred on another machine
(same H/W as my workstation) used as a server.  That is the machine
I have taken the information above from (essentially RedHat 7.2 with
a lot of patches, and a GCC "downgrade" to the stable/recommended
version).  I then went searching again, and stumbled upon one posting
referencing the same problem, please see:

http://gwyn.tux.org/hypermail/linux-kernel/1999week20/0728.html

(What clinched my search this time was the "4294" seconds.)

The problem in my case seems to be closely linked to moderate network
activity and the absence (yes, absence) of disk activity.

The server runs among other things a BGP4 implementation I have developed,
and while loading up several sets of full Internet routing tables,
incoming network traffic is oto 500kbps / 30-40pps for a minute or two.
(For the record, the machine is just a host, and the kernel routing tables
are not modified, everything just stays in userland.)  CPU load is only a
few percent during this, and there is very little (just background noise)
disk activity.  During this period I will experience several thousand
instances of time warp per second (ie, time(2) will repeatedly return
a warped value), while everything is fine under otherwise steady state
conditions (little network activity), as well as under any CPU and/or
disk load, including complete congestion.

The plot thickens ...

The server had been up for nearly three months when the problem suddenly
manifested itself very firmly (basically, time-stamp based soft timers
in the BGP implementation were bombing out).  I had never seen it
on the server before, but once it appeared it stayed.  What made me
recognise it was that the warp was the exact same 4294 seconds I had
previously experienced on my workstation, and I'm pretty sure that what
made it appear was that I turned off debugging in the BGP implementation.
With full debug/log output, as I had been running with for the past couple
of months, it produces several Mbytes of logfile output per second while
loading up; with debugging off, there's practically no disk activity.

I've applied the hack/fix suggested in the posting mentioned above,
and the problem seems to have gone away, but I'm wondering if there
might be something else wrong, given that I'm experiencing it on single
CPU machines.

I'm not subscribed to the kernel mailing list, please explicitly Cc
any replies; thanks.

  -- Per G. Bilse


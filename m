Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318356AbSG3RSh>; Tue, 30 Jul 2002 13:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318360AbSG3RSh>; Tue, 30 Jul 2002 13:18:37 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:51694 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S318356AbSG3RSd>; Tue, 30 Jul 2002 13:18:33 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Eric Altendorf <EricAltendorf@orst.edu>
Reply-To: EricAltendorf@orst.edu
To: linux-kernel@vger.kernel.org
Subject: 2.5.25: spurious 8259A interrupt: IRQ7
Date: Tue, 30 Jul 2002 09:52:28 -0700
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200207300952.28460.EricAltendorf@orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is my first time trying to report a kernel problem, so I have no 
idea if I'm doing it the right way or not.  I also don't understand 
the problem; maybe it's my own fault.  Here it goes, though:


[1.] One line summary of the problem:    

spurious 8259A interrupt: IRQ7. (during heavy disk reads)


[2.] Full description of the problem/report:

I was experimenting with kernel 2.5.25 with 2.4 IDE forward port and 
Toshiba ACPI extensions.  I was running find and part way through I 
got this message on the console:
	spurious 8259A interrupt: IRQ7.
It doesn't seem to be reproducible.


[3.] Keywords (i.e., modules, networking, kernel):

spurious, interrupt, IRQ7


[4.] Kernel version (from /proc/version):

Linux version 2.5.25 (root@zigoku) (gcc version 2.96 20000731 (Red Hat 
Linux 7.3 2.96-110)) #1 Tue Jul 30 01:31:34 PDT 2002


[5.] Output of Oops.. message (if applicable) with symbolic 
information 
     resolved (see Documentation/oops-tracing.txt)

No oops.


[6.] A small shell script or example program which triggers the
     problem (if possible)

Haven't replicated it yet.


[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux zigoku 2.5.25 #1 Tue Jul 30 01:31:34 PDT 2002 i586 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         vfat fat


[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineTMx86
cpu family	: 5
model		: 4
model name	: Transmeta(tm) Crusoe(tm) Processor TM5600
stepping	: 3
cpu MHz		: 597.628
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr cx8 sep cmov mmx longrun lrti
bogomips	: 1150.97


[7.3.] Module information (from /proc/modules):

vfat                   11360   2 (autoclean)
fat                    37688   0 (autoclean) [vfat]


[7.4.] Loaded driver and hardware information (/proc/ioports, 
/proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-10ff : Acer Laboratories Inc. [ALi] M5451 PCI South Bridge Audio
  1000-10ff : ALI 5451
4000-40ff : PCI CardBus #01
4400-44ff : PCI CardBus #01
edb0-edbf : Acer Laboratories Inc. [ALi] M5229 IDE
edc0-edff : Intel Corp. 82557 [Ethernet Pro 100]
  edc0-edff : e100
ee00-ee3f : Acer Laboratories Inc. [ALi] M7101 PMU
ef00-ef1f : Acer Laboratories Inc. [ALi] M7101 PMU


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ef5bfff : System RAM
  00100000-002369cc : Kernel code
  002369cd-0028d5bb : Kernel data
0ef5c000-0ef5ffff : reserved
0ef60000-0ef6ffff : ACPI Tables
0ef70000-0f06ffff : reserved
10000000-10000fff : Acer Laboratories Inc. [ALi] M5451 PCI South 
Bridge Audio
10001000-10001fff : Toshiba America Info Systems ToPIC95 PCI to 
Cardbus Bridge with ZV Support
10400000-107fffff : PCI CardBus #01
10800000-10bfffff : PCI CardBus #01
dfdfe000-dfdfefff : Acer Laboratories Inc. [ALi] M5237 USB
dfe00000-dfefffff : Intel Corp. 82557 [Ethernet Pro 100]
  dfe00000-dfefffff : e100
dffff000-dfffffff : Intel Corp. 82557 [Ethernet Pro 100]
  dffff000-dfffffff : e100
e0000000-e7ffffff : S3 Inc. 86C270-294 Savage/IX-MV
efd00000-efdfffff : Transmeta Corporation LongRun Northbridge
ffe00000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)


00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 
01)
	Subsystem: Transmeta Corporation: Unknown device 0295
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at efd00000 (32-bit, non-prefetchable) [size=1M]

00:00.1 RAM memory: Transmeta Corporation SDRAM controller
	Subsystem: Transmeta Corporation: Unknown device 0295
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
	Subsystem: Transmeta Corporation: Unknown device 0295
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:04.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV 
(rev 13) (prog-if 00 [VGA])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1000ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=128M]
	Expansion ROM at 000c0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi] 
M5451 PCI AC-Link Controller Audio Device (rev 01)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA 
Bridge [Aladdin IV]
	Subsystem: Toshiba America Info Systems: Unknown device 0004
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 08)
	Subsystem: Toshiba America Info Systems: Unknown device 0003
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at dffff000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at edc0 [size=64]
	Region 2: Memory at dfe00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:10.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3) 
(prog-if e0)
	Subsystem: Toshiba America Info Systems: Unknown device 0004
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 255
	Region 4: I/O ports at edb0 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:12.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to 
Cardbus Bridge with ZV Support (rev 32)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:14.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 
Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: Toshiba America Info Systems: Unknown device 0004
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at dfdfe000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)

No SCSI in this kernel. :-)


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):


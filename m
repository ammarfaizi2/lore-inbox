Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132321AbQK3A2B>; Wed, 29 Nov 2000 19:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132333AbQK3A1v>; Wed, 29 Nov 2000 19:27:51 -0500
Received: from plzena-5.dialup.vol.cz ([212.20.120.6]:3588 "HELO
        madness.madness.mad") by vger.kernel.org with SMTP
        id <S132321AbQK3A1h>; Wed, 29 Nov 2000 19:27:37 -0500
Date: Thu, 30 Nov 2000 00:50:22 +0100 (CET)
From: Martin MaD Douda <martin@douda.net>
To: linux-kernel@vger.kernel.org
Subject: 100% repeatable OOPS
Message-ID: <Pine.LNX.4.21.0011292355290.1030-100000@madness.madness.mad>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, all.

[1.] One line summary of the problem:    

I'm getting oops every time I run dosemu with special virtual boot floppy
image

[2.] Full description of the problem/report:

I have boot floppy image for dosemu, which went bogus for some (unknown)
reason. When I use it, kernel oopses immediately and reliably.
After unrawing keyboard everything seems to work fine. 


[3.] Keywords (i.e., modules, networking, kernel):

kernel syscall i386

[4.] Kernel version (from /proc/version):

Linux version 2.4.0-test11 (root@madness.madness.mad) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #2 Wed Nov 22 16:25:14 CET 2000

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)


Nov 29 23:23:20 madness kernel: invalid operand: 0000 
Nov 29 23:23:20 madness kernel: CPU:    0 
Nov 29 23:23:20 madness kernel: EIP:    0000:[<00000253>] 
Nov 29 23:23:20 madness kernel: EFLAGS: 00030202 
Nov 29 23:23:20 madness kernel: eax: 0000023a   ebx: 00000f00   ecx: 0000fffe   edx: 0000005b 
Nov 29 23:23:20 madness kernel: esi: 00008327   edi: 000005a8   ebp: 00007c00   esp: c1abbf34 
Nov 29 23:23:20 madness kernel: ds: 0000   es: 0000   ss: 0018 
Nov 29 23:23:20 madness kernel: Process dos (pid: 14078, stackpage=c1abb000) 
Nov 29 23:23:20 madness kernel: Stack: 00007bee 00000000 0000ffc9 00000070 00000000 00000000 00000000 00000000  
Nov 29 23:23:20 madness kernel:        00000003 00000000 00088108 00000000 00000000 00000000 00000000 00000000  
Nov 29 23:23:20 madness kernel:        000000c0 00000000 00001000 00000000 00000000 00000000 00000000 00000000  
Nov 29 23:23:20 madness kernel: Call Trace: [system_call+51/56] [<fffafff1>]  
Nov 29 23:23:20 madness kernel: Code:  Bad EIP value. 

[6.] A small shell script or example program which triggers the
     problem (if possible)

N/A. If really needed, I can provide my dosemu configuration and that bogus floppy image.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux madness.madness.mad 2.4.0-test11 #2 Wed Nov 22 16:25:14 CET 2000 i686 unknown
Kernel modules         2.3.19
Gnu C                  egcs-2.91.66
Gnu Make               3.78.1
Binutils               2.9.5.0.22
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10f
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         ide-floppy ipchains


[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 3
model name	: AMD Duron(tm) Processor
stepping	: 0
cpu MHz		: 601.000079
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
features	: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1199.31


[7.3.] Module information (from /proc/modules):


ide-floppy             10016   0 (autoclean)
ipchains               32832   0 (unused)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

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
4000-40ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
d000-d00f : VIA Technologies, Inc. Bus Master IDE
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : VIA Technologies, Inc. UHCI USB
d800-d81f : VIA Technologies, Inc. UHCI USB (#2)
dc00-dcff : VIA Technologies, Inc. AC97 Audio Controller
e000-e003 : VIA Technologies, Inc. AC97 Audio Controller
e400-e403 : VIA Technologies, Inc. AC97 Audio Controller



00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-001fbfaf : Kernel code
  001fbfb0-002091bf : Kernel data
07ff0000-07ff2fff : ACPI Non-volatile Storage
07ff3000-07ffffff : ACPI Tables
d0000000-d3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
d4000000-d5ffffff : PCI Bus #01
  d4000000-d5ffffff : nVidia Corporation Vanta [NV6]
d6000000-d7ffffff : PCI Bus #01
  d6000000-d6ffffff : nVidia Corporation Vanta [NV6]
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)


00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0 set
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0 set
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: d6000000-d7ffffff
	Prefetchable memory behind bridge: d4000000-d5ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set
	Region 4: I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo Super AC97/Audio] (rev 20)
	Subsystem: Micro-star International Co Ltd: Unknown device 3400
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at dc00 [size=256]
	Region 1: I/O ports at e000 [size=4]
	Region 2: I/O ports at e400 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation Vanta (rev 15) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 5 min, 1 max, 32 set
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d4000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


[7.6.] SCSI information (from /proc/scsi/scsi)

no SCSI here.

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:


The most interesting information is this:

EIP:    0000:[<00000253>] 

Kernel really jumped to some random address. I've no idea, how it is possible.  
But this definitely should not happen.

Feel free to ask for more information.

Have a nice day.

				Martin Douda


--------------------------------------------------------------------------------
                              Martin "MaD" Douda
WEB: http://martin.douda.net/   PHONE:+420603752779   ICQ# 86467013
EMAIL: <martin@douda.net>, <mad@gate.mobil.cz> (160 characters only)
PGP:ID=0x6FE43023 Fingerprint:E495 11DA EF6E 0DD6 965A 54F3 888E CC9E 6FE4 3023
--------------------------------------------------------------------------------
Don't hit the keys so hard, it hurts.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318330AbSG3O4f>; Tue, 30 Jul 2002 10:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318331AbSG3O4f>; Tue, 30 Jul 2002 10:56:35 -0400
Received: from mail.inf.elte.hu ([157.181.161.6]:57239 "EHLO mail.inf.elte.hu")
	by vger.kernel.org with ESMTP id <S318330AbSG3O4b>;
	Tue, 30 Jul 2002 10:56:31 -0400
Date: Tue, 30 Jul 2002 16:59:48 +0200 (CEST)
From: bege <bege@inf.elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: bug-report
Message-ID: <Pine.A41.4.31.0207301658480.48216-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--------------
| BUG-REPORT |
--------------

1.
--
OOPS message while compiling

2.
--
I got an OOPS kernel message (described below) while i was compiling
XFree86 with gcc-3.0 and g++-2.95

3.
--
I used the -mcpu=athlon -march=athlon parameters in the makefile although
g++-2.95 doesn't support this. But i think it may be cause compile errors
not kernel crash.

4.
--

Linux version 2.4.18 (root@void) (gcc version 3.0.4) #11 Tue Jul 30 13:33:15 CEST 2002

5.
--
ksymoops 2.4.6 on i686 2.4.18.  Options used
     -V (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (specified)

 <1>Unable to handle kernel paging request at virtual address ea840758
c01446da
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01446da>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: ea840754   ebx: cd6ef4c0   ecx: cd6ef4d8   edx: c4f6ff58
esi: cd6ef3e0   edi: c562f140   ebp: c562f168   esp: c681bf28
ds: 0018   es: 0018   ss: 0018
Process dpkg (pid: 24488, stackpage=c681b000)
Stack: 00000000 c562f140 c285fdc0 c562f140 bffffa0c c0144706 c562f140 c562f140
       c013db4e c562f140 00000000 c013dc19 c562f140 c6de3e40 c681bf9c 00000000
       c013ce99 c6de3e40 c681bf9c 00000000 fffffff0 c562f140 c562f140 ce14b000
Call Trace: [<c0144706>] [<c013db4e>] [<c013dc19>] [<c013ce99>] [<c013de5d>]
   [<c0106d2b>]
Code: 89 48 04 89 43 18 89 51 04 89 0a ff 04 24 eb b1 8d b6 00 00


>>EIP; c01446da <select_parent+6a/80>   <=====

>>ebx; cd6ef4c0 <_end+d4a1e94/105b29d4>
>>ecx; cd6ef4d8 <_end+d4a1eac/105b29d4>
>>edx; c4f6ff58 <_end+4d2292c/105b29d4>
>>esi; cd6ef3e0 <_end+d4a1db4/105b29d4>
>>edi; c562f140 <_end+53e1b14/105b29d4>
>>ebp; c562f168 <_end+53e1b3c/105b29d4>
>>esp; c681bf28 <_end+65ce8fc/105b29d4>

Trace; c0144706 <shrink_dcache_parent+16/30>
Trace; c013db4e <d_unhash+1e/50>
Trace; c013dc19 <vfs_rmdir+99/210>
Trace; c013ce99 <lookup_hash+49/90>
Trace; c013de5d <sys_rmdir+cd/f0>
Trace; c0106d2b <system_call+33/38>

Code;  c01446da <select_parent+6a/80>
00000000 <_EIP>:
Code;  c01446da <select_parent+6a/80>   <=====
   0:   89 48 04                  mov    %ecx,0x4(%eax)   <=====
Code;  c01446dd <select_parent+6d/80>
   3:   89 43 18                  mov    %eax,0x18(%ebx)
Code;  c01446e0 <select_parent+70/80>
   6:   89 51 04                  mov    %edx,0x4(%ecx)
Code;  c01446e3 <select_parent+73/80>
   9:   89 0a                     mov    %ecx,(%edx)
Code;  c01446e5 <select_parent+75/80>
   b:   ff 04 24                  incl   (%esp,1)
Code;  c01446e8 <select_parent+78/80>
   e:   eb b1                     jmp    ffffffc1 <_EIP+0xffffffc1> c014469b <select_parent+2b/80>
Code;  c01446ea <select_parent+7a/80>
  10:   8d b6 00 00 00 00         lea    0x0(%esi),%esi

7.1
---
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux void 2.4.18 #11 Tue Jul 30 13:33:15 CEST 2002 i686 unknown

Gnu C                  3.0.4
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
Modules Loaded         agpgart tulip af_packet rtc unix

7.2
---
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(TM) XP 1800+
stepping	: 2
cpu MHz		: 1532.941
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
bogomips	: 3060.53

7.3
---
agpgart                12832   0 (unused)
tulip                  37664   1
af_packet               8200   0 (unused)
rtc                     5688   0 (autoclean)
unix                   13924   5 (autoclean)

7.4
---
/proc/ioports:

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
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
9000-901f : VIA Technologies, Inc. UHCI USB (#4)
9400-941f : VIA Technologies, Inc. UHCI USB (#3)
9800-980f : VIA Technologies, Inc. Bus Master IDE
  9800-9807 : ide0
  9808-980f : ide1
a000-a0ff : Accton Technology Corporation EN-1216 Ethernet Adapter
  a000-a0ff : tulip
a400-a407 : Creative Labs SB Live!
a800-a81f : Creative Labs SB Live! EMU10k1
b000-b01f : VIA Technologies, Inc. UHCI USB (#2)
b400-b41f : VIA Technologies, Inc. UHCI USB
b800-b8ff : C-Media Electronics Inc CM8738
d000-dfff : PCI Bus #01
  d800-d8ff : PCI device 1002:514c (ATI Technologies Inc)

/proc/iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fffbfff : System RAM
  00100000-001be4fe : Kernel code
  001be4ff-001ec03f : Kernel data
0fffc000-0fffefff : ACPI Tables
0ffff000-0fffffff : ACPI Non-volatile Storage
d6000000-d60003ff : Accton Technology Corporation EN-1216 Ethernet Adapter
  d6000000-d60003ff : tulip
d6800000-d68000ff : PCI device 1106:3104 (VIA Technologies, Inc.)
d7000000-d7dfffff : PCI Bus #01
  d7000000-d700ffff : PCI device 1002:514c (ATI Technologies Inc)
d7f00000-dfffffff : PCI Bus #01
  d8000000-dfffffff : PCI device 1002:514c (ATI Technologies Inc)
e0000000-e3ffffff : VIA Technologies, Inc. VT8367 [KT266]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

7.5
---
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
	Subsystem: Asustek Computer, Inc.: Unknown device 807f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: d7000000-d7dfffff
	Prefetchable memory behind bridge: d7f00000-dfffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: Asustek Computer, Inc.: Unknown device 80e2
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at b800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 3
	Region 4: I/O ports at b400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at b000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.2 USB Controller: VIA Technologies, Inc.: Unknown device 3104 (rev 51) (prog-if 20)
	Subsystem: Asustek Computer, Inc.: Unknown device 8080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at d6800000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
	Subsystem: Creative Labs: Unknown device 8064
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a800 [size=32]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.1 Input device controller: Creative Labs SB Live! (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at a400 [size=8]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Ethernet controller: Accton Technology Corporation EN-1216 Ethernet Adapter (rev 11)
	Subsystem: Standard Microsystems Corp [SMC]: Unknown device 1255
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (63750ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 4
	Region 0: I/O ports at a000 [size=256]
	Region 1: Memory at d6000000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3147
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 9800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 7
	Region 4: I/O ports at 9400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 7
	Region 4: I/O ports at 9000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 514c (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 013a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at d7000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at d7fe0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


				bege


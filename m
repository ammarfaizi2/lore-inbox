Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTK1KUw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 05:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbTK1KUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 05:20:52 -0500
Received: from c-24-126-17-200.we.client2.attbi.com ([24.126.17.200]:40752
	"EHLO localhost") by vger.kernel.org with ESMTP id S262104AbTK1KUn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 05:20:43 -0500
Subject: PROBLEM: 2.6.0-test11 Oops after resuming from sleep/hibernation
From: Naheed Vora <vora@usc.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: University of Southern California
Message-Id: <1070014827.4366.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 28 Nov 2003 02:20:28 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    
Oops after resuming from sleep/hibernation

[2.] Full description of the problem/report:

2.6.0-test11 throws Oops when my laptop resumes after sleep mode or 
hibernation. I am using APM (compiled in the kernel). I think this has 
something to do with the wireless card/pcmcia as it happens only when 
I have my wireless card(Orinoco) connected and on before put to sleep. In absense 
of wireless card, there is no panic. Just before panic, I see lots of 
messages scroll up followed by message, Bad Scheduling in Interrupts! 
and then Panic.

Surprisingly I don't have anything in my syslog/messages. oops written
by hand from the terminal.


[3.] Keywords (i.e., modules, networking, kernel):
APM, pcmcia, orinoco_cs

[4.] Kernel version (from /proc/version):
Linux version 2.6.0-test11 (root@gnubird) (gcc version 3.3.2 (Debian)) #6 Thu Nov 27 01:27:14 PST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

Note: ksyms is not the one when Oops was generated but system was rebooted 
and brought to same state as at the time of Oops.

ksymoops 2.4.9 on i686 2.6.0-test11.  Options used
     -V (default)
     -k ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test11/ (default)
     -m /boot/System.map-2.6.0-test11 (default)

Warning (read_ksyms): no kernel symbols in ksyms, is ksyms a valid ksyms
file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
pid:281         com:apmd
EIP:    0060:[<c011b740>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000246
eax: 00000000   ebx: c03c6980   ecx: 00000000   edx: 00000000
esi: 0000000b   edi: cb9106e0   ebp: 0000000b   
ds: 007b   es: 007b   
cr0: 8005008b
cr2: 4015af98
cr3: 012eb000
cr4: 00000690
Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; c011b740 <panic+100/120>   <=====

>>ebx; c03c6980 <buf.0+0/400>
>>edi; cb9106e0 <_end+b532088/3fc1f9a8>


2 warnings issued.  Results may not be reliable.


[6.] A small shell script or example program which triggers the
     problem (if possible)

None

[7.] Environment

Debian (sarge/unstable)

[7.1.] Software (add the output of the ver_linux script here)
Linux gnubird 2.6.0-test11 #6 Thu Nov 27 01:27:14 PST 2003 i686 GNU/Linux
 
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre3
e2fsprogs              1.35-WIP
pcmcia-cs              3.2.5
PPP                    2.4.2b3
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         orinoco_cs vfat orinoco hermes msdos fat


[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 10
cpu MHz		: 647.928
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1277.95

[7.3.] Module information (from /proc/modules):
orinoco_cs 6472 - - Live 0xccb42000
vfat 12544 - - Live 0xccb45000
orinoco 41580 - - Live 0xcc936000
hermes 7424 - - Live 0xcc919000
msdos 8672 - - Live 0xcc915000
fat 39456 - - Live 0xcc91d000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0100-013f : orinoco_cs
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-103f : 0000:00:07.3
1040-105f : 0000:00:07.3
1800-183f : 0000:00:03.0
  1800-183f : eepro100
1840-1847 : 0000:00:03.1
1850-185f : 0000:00:07.1
  1850-1857 : ide0
  1858-185f : ide1
1860-187f : 0000:00:07.2
2000-2fff : PCI Bus #01
  2000-20ff : 0000:01:00.0
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02
4800-48ff : PCI CardBus #06
4c00-4cff : PCI CardBus #06

00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000d0000-000d17ff : Extension ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-0bfeffff : System RAM
  00100000-002d6d16 : Kernel code
  002d6d17-0038eeff : Kernel data
0bff0000-0bffebff : ACPI Tables
0bffec00-0bffffff : ACPI Non-volatile Storage
10000000-103fffff : PCI CardBus #02
10400000-107fffff : PCI CardBus #02
10800000-10bfffff : PCI CardBus #06
10c00000-10ffffff : PCI CardBus #06
50000000-50000fff : 0000:00:02.0
  50000000-50000fff : yenta_socket
50100000-50100fff : 0000:00:02.1
  50100000-50100fff : yenta_socket
60000000-60000fff : card services
f4000000-f40fffff : 0000:00:05.0
f4100000-f411ffff : 0000:00:03.0
f4120000-f4120fff : 0000:00:03.0
  f4120000-f4120fff : eepro100
f4121000-f4121fff : 0000:00:03.1
f4122000-f4122fff : 0000:00:05.0
f4200000-f5ffffff : PCI Bus #01
  f4200000-f4200fff : 0000:01:00.0
  f5000000-f5ffffff : 0000:01:00.0
f8000000-fbffffff : 0000:00:00.0
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
gnubird:/usr/src/linux-2.6.0-test11# lspci -vvv
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: f4200000-f5ffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:02.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
	Subsystem: IBM: Unknown device 0130
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at 50000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10000000-103ff000 (prefetchable)
	Memory window 1: 10400000-107ff000
	I/O window 0: 00004000-000040ff
	Memory window 1: 10400000-107ff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:02.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
	Subsystem: IBM: Unknown device 0130
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at 50100000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10800000-10bff000 (prefetchable)
	Memory window 1: 10c00000-10fff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 09)
	Subsystem: Intel Corp. EtherExpress PRO/100+ MiniPCI
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f4120000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1800 [size=64]
	Region 2: Memory at f4100000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:03.1 Serial controller: Xircom Mini-PCI V.90 56k Modem (prog-if 02 [16550])
	Subsystem: Intel Corp.: Unknown device 2408
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 1840 [size=8]
	Region 1: Memory at f4121000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=2 PME-

00:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
	Subsystem: IBM: Unknown device 0153
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at f4122000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at f4000000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1850 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 1860 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64) (prog-if 00 [VGA])
	Subsystem: IBM ThinkPad A20m
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 2000 [size=256]
	Region 2: Memory at f4200000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)
None

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

gnubird:/usr/src/linux-2.6.0-test11# cat /proc/apm 
1.16ac 1.2 0x03 0x01 0x03 0x09 80% -1 ?

[X.] Other notes, patches, fixes, workarounds:

gnubird:/usr/src/linux-2.6.0-test11/scripts# cat /proc/cmdline 
root=/dev/hda7 acpi=off



Please CC me when replying to the list,
Thanks,
----
Naheed Vora


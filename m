Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264785AbSJaNDL>; Thu, 31 Oct 2002 08:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265124AbSJaNDK>; Thu, 31 Oct 2002 08:03:10 -0500
Received: from saturno.fis.uc.pt ([193.136.215.208]:21265 "EHLO
	saturno.fis.uc.pt") by vger.kernel.org with ESMTP
	id <S264785AbSJaNCx>; Thu, 31 Oct 2002 08:02:53 -0500
Date: Thu, 31 Oct 2002 13:09:13 GMT
From: Luis Miguel Tavora <lmtavora@saturno.fis.uc.pt>
Message-Id: <200210311309.NAA03653@saturno.fis.uc.pt>
To: linux-kernel@vger.kernel.org
Reply-To: lmtavora@saturno.fis.uc.pt
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP3 Imap webMail Program 2.0.11
X-Originating-IP: 193.136.215.247
Subject: Ext3 journalling file system
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] Ext3 jornalling file system

[2.] The system pt-get to update RH 7.3, on a
Compaq M700 Laptop the system is turned into a
highly critical stage: impossible to lauch 
applications, no disk access and the machine doesn't
reboot with the shutdown command (but the CPU & 
clock  keep working ok, I think...)


[3.]

[4.]   Linux version 2.4.19 (root@Fargo) (gcc 
version 2.96 20000731 (Red Hat Linux
7.3 2.96-112)) #1 Wed Oct 30 14:59:19 WET 2002

[5.]
Oct 30 11:47:19 Fargo kernel: kernel BUG at 
inode.c:513!
Oct 30 11:47:19 Fargo kernel: invalid operand: 0000
Oct 30 11:47:19 Fargo kernel: CPU:    0
Oct 30 11:47:19 Fargo kernel: EIP:    
0010:[<c0146379>]    Tainted: P
Oct 30 11:47:19 Fargo kernel: EFLAGS: 00010206
Oct 30 11:47:19 Fargo kernel: eax: 00000100   ebx: 
c02890a0   ecx: c02890c0   edx:
c02890a0
Oct 30 11:47:19 Fargo kernel: esi: c7f51a00   edi: 
c02890a0   ebp: c76885e0   esp:
c39efe54
Oct 30 11:47:19 Fargo kernel: ds: 0018   es: 0018   
ss: 0018
Oct 30 11:47:19 Fargo kernel: Process rpm (pid: 
7187, stackpage=c39ef000)
Oct 30 11:47:19 Fargo kernel: Stack: c76885e0 
c33ed320 00000000 00000000 c02890a0
c880ee08 c02890a0 c02890a0
Oct 30 11:47:19 Fargo kernel:        00000000 
00000000 c76885e0 c5f03a20 c8812be4
0004ab8f c8812bf5 c33ed320
Oct 30 11:47:19 Fargo kernel:        c39ee000 
c76885f4 c39efebc c02890a0 c39efebc
c02890a0 c8812ce7 c76885e0
Oct 30 11:47:19 Fargo kernel: Call Trace:    
[<c880ee08>] [<c8812be4>] [<c8812bf5>]
[<c8812ce7>] [<c880fed7>]
Oct 30 11:47:19 Fargo kernel:   [<c881c340>] 
[<c880fe00>] [<c881c340>] [<c0146cf4>]
[<c013f54c>] [<c0144a16>]
Oct 30 11:47:19 Fargo kernel:   [<c013f724>] 
[<c013f72f>] [<c0163872>] [<c01409d3>]
[<c010891b>]
Oct 30 11:47:19 Fargo kernel:
Oct 30 11:47:19 Fargo kernel: Code: 0f 0b 01 02 b0 
2d 1e c0 8b 83 08 01 00 00 a9 10
00 00 00 75
Oct 30 11:47:19 Fargo kernel:  <0>Assertion failure 
in journal_start_Rce5bcfc0() at
transaction.c:226: 
"handle->h_transaction->t_journal == journal"
Oct 30 11:47:19 Fargo kernel: kernel BUG at 
transaction.c:226!
Oct 30 11:47:19 Fargo kernel: invalid operand: 0000
Oct 30 11:47:19 Fargo kernel: CPU:    0
Oct 30 11:47:19 Fargo kernel: EIP:    
0010:[<c88002f8>]    Tainted: P
Oct 30 11:47:19 Fargo kernel: EFLAGS: 00010296
Oct 30 11:47:19 Fargo kernel: eax: 00000076   ebx: 
c76885e0   ecx: c5c14000   edx:
c5c15f64
Oct 30 11:47:19 Fargo kernel: esi: c39ee000   edi: 
c146e7c0   ebp: c5cd1000   esp:
c39efbdc
Oct 30 11:47:19 Fargo kernel: ds: 0018   es: 0018   
ss: 0018
Oct 30 11:47:19 Fargo kernel: Process rpm (pid: 
7187, stackpage=c39ef000)
Oct 30 11:47:19 Fargo kernel: Stack: c8806e80 
c8806750 c8806730 000000e2 c8806f20
c76885e0 c76885e0 ffffffe2
Oct 30 11:47:19 Fargo kernel:        c146e7c0 
c6ce9840 c8812d58 c5cd1000 00000001
5251504f 56555453 5a595857
Oct 30 11:47:19 Fargo kernel:        76757400 
c146e7c0 c5ddde00 00000001 c0145a3e
c146e7c0 00000004 c146e7c0
Oct 30 11:47:19 Fargo kernel: Call Trace:    
[<c8806e80>] [<c8806750>] [<c8806730>]
[<c8806f20>] [<c8812d58>]
Oct 30 11:47:19 Fargo kernel:   [<c0145a3e>] 
[<c0129ddd>] [<c0170fa8>] [<c011d9c5>]
[<c011d9f9>] [<c011a277>]
Oct 30 11:47:19 Fargo kernel:   [<c011423e>] 
[<c0108ecd>] [<c0109120>] [<c01091a1>]
[<c0146379>] [<c880132c>]
Oct 30 11:47:19 Fargo kernel:   [<c8800d46>] 
[<c880132c>] [<c0108a0c>] [<c0146379>]
[<c880ee08>] [<c8812be4>]
Oct 30 11:47:19 Fargo kernel:   [<c8812bf5>] 
[<c8812ce7>] [<c880fed7>] [<c881c340>]
[<c880fe00>] [<c881c340>]
Oct 30 11:47:19 Fargo kernel:   [<c0146cf4>] 
[<c013f54c>] [<c0144a16>] [<c013f724>]
[<c013f72f>] [<c0163872>]
Oct 30 11:47:19 Fargo kernel:   [<c01409d3>] 
[<c010891b>]
Oct 30 11:47:19 Fargo kernel:
Oct 30 11:47:19 Fargo kernel: Code: 0f 0b e2 00 30 
67 80 c8 83 c4 14 ff 43 08 eb 6a
6a 01 68 f0

[6.]

[7.]
[7.1]

If some fields are empty or look unusual you may 
have an old version.
Compare to the current minimal requirements in 
Documentation/Changes.

Linux Fargo 2.4.19 #1 Wed Oct 30 14:59:19 WET 2002 
i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.18
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
Modules Loaded         eepro100 maestro soundcore 
ipchains usb-uhci usbcore ext3 jbd

[7.2]
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 746.742
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce 
cx8 sep mtrr pge mca cmov pat pse36
mmx fxsr sse
bogomips        : 1490.94

[7.3]
eepro100               19728   1
maestro                30048   1 (autoclean)
soundcore               6212   2 (autoclean) 
[maestro]
ipchains               37960   7
usb-uhci               24260   0 (unused)
usbcore                70944   1 [usb-uhci]
ext3                   63488   5
jbd                    46064   5 [ext3]

[7.4]
-> /proc/ioports
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
03e8-03ef : serial(auto)
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1000-100f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  1000-1007 : ide0
  1008-100f : ide1
2000-2fff : PCI Bus #01
  2000-20ff : ATI Technologies Inc Rage Mobility 
P/M AGP 2x
4000-401f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
4020-403f : Intel Corp. 82371AB/EB/MB PIIX4 USB
  4020-403f : usb-uhci
4040-407f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  4040-407f : eepro100
4080-4087 : Lucent Microelectronics LT WinModem
4400-44ff : ESS Technology ES1978 Maestro 2E
  4400-44ff : ESS Maestro 2E
5000-503f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI

-> /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d2800-000d3fff : Extension ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-001d859a : Kernel code
  001d859b-00230a7f : Kernel data
07ff0000-07ff37ff : reserved
07ff3800-07ffffff : ACPI Non-volatile Storage
40000000-410fffff : PCI Bus #01
  40000000-40ffffff : ATI Technologies Inc Rage 
Mobility P/M AGP 2x
  41000000-41000fff : ATI Technologies Inc Rage 
Mobility P/M AGP 2x
50000000-53ffffff : Intel Corp. 440BX/ZX/DX - 
82443BX/ZX/DX Host bridge
5a000000-5a01ffff : Intel Corp. 82557/8/9 [Ethernet 
Pro 100]
5a080000-5a080fff : Texas Instruments PCI1450
5a100000-5a100fff : Texas Instruments PCI1450 (#2)
5a180000-5a180fff : Intel Corp. 82557/8/9 [Ethernet 
Pro 100]
  5a180000-5a180fff : eepro100
5a200000-5a200fff : Lucent Microelectronics LT 
WinModem

[7.5]
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 
82443BX/ZX/DX Host bridge (rev 03)
Subsystem: Compaq Computer Corporation: Unknown 
device b110
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR-
FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort+
>SERR- <PERR-
Latency: 64
Region 0: Memory at 50000000 (32-bit, prefetchable) 
[size=64M]
Capabilities: [a0] AGP version 1.0
Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 
82443BX/ZX/DX AGP bridge (rev 03)
(prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR-
FastB2B-
Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
Bus: primary=00, secondary=01, subordinate=01, 
sec-latency=0
I/O behind bridge: 00002000-00002fff
Memory behind bridge: 40000000-410fffff
Prefetchable memory behind bridge: fff00000-000fffff
BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- 
>Reset- FastB2B+

00:04.0 CardBus bridge: Texas Instruments PCI1450 
(rev 03)
Subsystem: Compaq Computer Corporation: Unknown 
device b113
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR-
FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
Latency: 66, cache line size 08
Interrupt: pin A routed to IRQ 11
Region 0: Memory at 5a080000 (32-bit, 
non-prefetchable) [size=4K]
Bus: primary=00, secondary=02, subordinate=02, 
sec-latency=0
Memory window 0: 00000000-00000000 (prefetchable)
Memory window 1: 00000000-00000000 (prefetchable)
I/O window 0: 00000000-00000003
I/O window 1: 00000000-00000003
BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 
16bInt+ PostWrite-
16-bit legacy interface ports at 0001

00:04.1 CardBus bridge: Texas Instruments PCI1450 
(rev 03)
Subsystem: Compaq Computer Corporation: Unknown 
device b113
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR-
FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
Latency: 66, cache line size 08
Interrupt: pin A routed to IRQ 11
Region 0: Memory at 5a100000 (32-bit, 
non-prefetchable) [size=4K]
Bus: primary=00, secondary=03, subordinate=03, 
sec-latency=0
Memory window 0: 00000000-00000000 (prefetchable)
Memory window 1: 00000000-00000000 (prefetchable)
I/O window 0: 00000000-00000003
I/O window 1: 00000000-00000003
BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 
16bInt+ PostWrite-
16-bit legacy interface ports at 0001

00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA 
(rev 02)
Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- 
VGASnoop- ParErr- Stepping- SERR+
FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB 
PIIX4 IDE (rev 01) (prog-if 80
[Master])
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR-
FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
Latency: 64
Region 4: I/O ports at 1000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB 
PIIX4 USB (rev 01) (prog-if 00
[UHCI])
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR-
FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
Latency: 64
Interrupt: pin D routed to IRQ 11
Region 4: I/O ports at 4020 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 
ACPI (rev 03)
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR-
FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
Interrupt: pin ? routed to IRQ 9

00:08.0 Multimedia audio controller: ESS Technology 
ES1978 Maestro 2E (rev 10)
Subsystem: Compaq Computer Corporation: Unknown 
device b112
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR-
FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
Latency: 64 (500ns min, 6000ns max)
Interrupt: pin A routed to IRQ 11
Region 0: I/O ports at 4400 [size=256]
Capabilities: [c0] Power Management version 2
Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Intel Corp. 82557/8/9 
[Ethernet Pro 100] (rev 09)
Subsystem: Intel Corp. EtherExpress PRO/100+ MiniPCI
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR-
FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
Latency: 66 (2000ns min, 14000ns max), cache line 
size 08
Interrupt: pin A routed to IRQ 11
Region 0: Memory at 5a180000 (32-bit, 
non-prefetchable) [size=4K]
Region 1: I/O ports at 4040 [size=64]
Region 2: Memory at 5a000000 (32-bit, 
non-prefetchable) [size=128K]
Expansion ROM at <unassigned> [disabled] [size=1M]
Capabilities: [dc] Power Management version 2
Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:09.1 Serial controller: Lucent Microelectronics 
LT WinModem (prog-if 00 [8250])
Subsystem: Intel Corp.: Unknown device 2203
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR-
FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
Interrupt: pin A routed to IRQ 11
Region 0: I/O ports at 4080 [size=8]
Region 1: Memory at 5a200000 (32-bit, 
non-prefetchable) [size=4K]
Capabilities: [dc] Power Management version 2
Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 PME-Enable+ DSel=0 DScale=2 PME+

01:00.0 VGA compatible controller: ATI Technologies 
Inc Rage Mobility P/M AGP 2x (rev
64) (prog-if 00 [VGA])
Subsystem: Compaq Computer Corporation: Unknown 
device b111
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping+ SERR-
FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
Latency: 66 (2000ns min), cache line size 08
Interrupt: pin A routed to IRQ 11
Region 0: Memory at 40000000 (32-bit, 
non-prefetchable) [size=16M]
Region 1: I/O ports at 2000 [size=256]
Region 2: Memory at 41000000 (32-bit, 
non-prefetchable) [size=4K]
Expansion ROM at <unassigned> [disabled] [size=128K]
Capabilities: [50] AGP version 1.0
Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
Capabilities: [5c] Power Management version 1
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6]
[7.7]

[8.] Below, I'm enclosing the options used on the 
compilation of the kernel:

#
# Automatically generated by make menuconfig: don't 
edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_CARDBUS=y
# CONFIG_TCIC is not set
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
# CONFIG_IP_NF_NAT_LOCAL is not set
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
# CONFIG_IP_NF_ARPTABLES is not set
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CMD680 is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
CONFIG_IDEDMA_IVB=y
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
CONFIG_SCSI_IZIP_EPP16=y
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_SCSI_PCMCIA is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_TC35815 is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=m
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_NEW_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_FMVJ18X is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_ARCNET_COM20020_CS is not set
# CONFIG_PCMCIA_IBMTR is not set
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_PCMCIA_XIRTULIP is not set
# CONFIG_NET_PCMCIA_RADIO is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=y
# CONFIG_INPUT_KEYBDEV is not set
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=2048
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set
# CONFIG_INPUT_ANALOG is not set
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=y
# CONFIG_DRM_OLD is not set
CONFIG_DRM_NEW=y

# CONFIG_DRM_TDFX is not set
CONFIG_DRM_R128=m
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set

#
# PCMCIA character devices
#
# CONFIG_PCMCIA_SERIAL_CS is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=m
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
CONFIG_NTFS_FS=m
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set
# CONFIG_ZLIB_FS_INFLATE is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=m
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
CONFIG_SOUND_MAESTRO=m
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
# CONFIG_SOUND_VMIDI is not set
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
# CONFIG_SOUND_MPU401 is not set
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_PAS_JOYSTICK is not set
# CONFIG_SOUND_PSS is not set
CONFIG_SOUND_SB=m
# CONFIG_SOUND_AWE32_SYNTH is not set
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
# CONFIG_SOUND_YM3812 is not set
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_YMFPCI_LEGACY is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_LONG_TIMEOUT is not set
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_UHCI=m
# CONFIG_USB_UHCI_ALT is not set
# CONFIG_USB_OHCI is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_BLUETOOTH is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
CONFIG_USB_STORAGE_HP8200e=y
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
CONFIG_USB_SCANNER=m
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_BRLVGER is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set

-----------------------------------------------------
This mail sent through IMP: http://web.horde.org/imp/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263255AbTJWJC7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 05:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTJWJC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 05:02:59 -0400
Received: from pclinux-ccalmb.lut.ac.uk ([131.231.83.157]:63374 "EHLO
	pclinux-ccalmb.lut.ac.uk") by vger.kernel.org with ESMTP
	id S263255AbTJWJCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 05:02:51 -0400
Date: Thu, 23 Oct 2003 10:03:07 +0100
From: a.l.m.buxey@lboro.ac.uk
To: linux-kernel@vger.kernel.org
Subject: BUG in 2.6.0-test8
Message-ID: <20031023090307.GA26026@lboro.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i dont know what caused this...its just in my 'dmesg' output from lastnight.

this system is a fairly busy server system (yes...yes..i know ;-) )

heres the 'cut here' bug output in the dmesg.

------------[ cut here ]------------
kernel BUG at kernel/exit.c:758!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c011f4c9>]    Not tainted
EFLAGS: 00010292
EIP is at do_exit+0x289/0x340
eax: 00000000   ebx: f7ffeac0   ecx: ffffffff   edx: d6414000
esi: 00000000   edi: d5cbe120   ebp: 00000001   esp: d6415eb8
ds: 007b   es: 007b   ss: 0068
Process sh (pid: 13465, threadinfo=d6414000 task=d5cbe120)
Stack: d5cbe120 d0193480 d5cbe120 d5cbe6e4 d6414000 00000001 00000001 d6414000 
       c011f66b 00000001 d6414000 d6414000 c01285ff 00000001 d5cbe6e4 d6415f24 
       d6414000 d5cbe6e4 d6415fc4 d5cbe6e4 d6414000 d6415f24 c0109293 d6415f24 
Call Trace:
 [<c011f66b>] do_group_exit+0x7b/0xc0
 [<c01285ff>] get_signal_to_deliver+0x1ef/0x380
 [<c0109293>] do_signal+0xd3/0x110
 [<c01299d9>] sys_rt_sigaction+0xf9/0x120
 [<c0109329>] do_notify_resume+0x59/0x5c
 [<c0109506>] work_notifysig+0x13/0x15

Code: 0f 0b f6 02 d4 c0 28 c0 eb 0d 90 90 90 90 90 90 90 90 90 90 
 <6>note: sh[13465] exited with preempt_count 1



heres the ver_linux output

Linux systemX 2.6.0-test8 #2 Wed Oct 22 22:08:55 BST 2003 i686 i686 i386 GNU/Linux
 
Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
module-init-tools      0.9.14
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.1pre4
nfs-utils              1.0.1
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         dummy eepro100 mii iptable_filter ip_tables


/proc/cpu
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III CPU family      1400MHz
stepping        : 1
cpu MHz         : 1403.203
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 2785.28

/proc/modules
dummy 1764 - - Live 0xf88b4000
eepro100 26252 - - Live 0xf88be000
mii 4928 - - Live 0xf88b1000
iptable_filter 2464 - - Live 0xf88a4000
ip_tables 16432 - - Live 0xf88a8000


/proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
9800-983f : 0000:00:0d.0
  9800-983f : eepro100
a000-afff : PCI Bus #01
  a800-a87f : 0000:01:00.0
d400-d4ff : 0000:00:01.1
d800-d80f : 0000:00:00.1
  d800-d807 : ide0
  d808-d80f : ide1

/proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000cc000-000cd7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3fdfbfff : System RAM
  00100000-0027e814 : Kernel code
  0027e815-002ef8bf : Kernel data
3fdfc000-3fdfefff : ACPI Tables
3fdff000-3fdfffff : ACPI Non-volatile Storage
e4800000-e48fffff : 0000:00:0d.0
e5000000-e5000fff : 0000:00:0d.0
  e5000000-e5000fff : eepro100
e5800000-e5ffffff : PCI Bus #01
  e5800000-e581ffff : 0000:01:00.0
e6800000-e6800fff : 0000:00:01.3
e7000000-e7000fff : 0000:00:01.2
e7800000-e7800fff : 0000:00:01.1
e8000000-ebffffff : 0000:00:00.0
f0000000-feafffff : PCI Bus #01
  f0000000-f7ffffff : 0000:01:00.0
fff80000-ffffffff : reserved


and finally, the pci list

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 30)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
        Subsystem: Asustek Computer, Inc.: Unknown device 80e1
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16
        Region 4: I/O ports at d800 [size=16]

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 84)
        Subsystem: Asustek Computer, Inc.: Unknown device 80e1
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (13000ns min, 2750ns max)
        Interrupt: pin C routed to IRQ 10
        Region 0: I/O ports at d400 [size=256]
        Region 1: Memory at e7800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=160mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) (prog-if 10 [OHCI])
        Subsystem: Unknown device 0039:7001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 0: Memory at e7000000 (32-bit, non-prefetchable) [size=4K]

00:01.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) (prog-if 10 [OHCI])
        Subsystem: Unknown device 0039:7000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 0: Memory at e6800000 (32-bit, non-prefetchable) [size=4K]

00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: e5800000-e5ffffff
        Prefetchable memory behind bridge: f0000000-feafffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:0d.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100 S Desktop Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 9800 [size=64]
        Region 2: Memory at e4800000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D (rev 21) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc.: Unknown device 80e1
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        BIST result: 00
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at e5800000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at a800 [size=128]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] AGP version 2.0
                Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>



hope this helps!!

Alan


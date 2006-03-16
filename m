Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWCPLxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWCPLxB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 06:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWCPLxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 06:53:01 -0500
Received: from violet.upc.es ([147.83.2.51]:48587 "EHLO violet.upc.es")
	by vger.kernel.org with ESMTP id S1750917AbWCPLxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 06:53:00 -0500
Date: Thu, 16 Mar 2006 13:49:07 +0100 (CET)
From: Raul Orus <rorus@ma4.upc.edu>
X-X-Sender: raul@gage10.upc.es
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Computer hanged up, something related with journal.c 
Message-ID: <Pine.LNX.4.60.0603161332570.27559@gage10.upc.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem:

Computer hanged up, something related with journal.c

[2.] Full description of the problem/report:

With high hard disk accesses and CPU load the computer crashed with the 
following message:

gage152b kernel: Assertion failure in __journal_remove_journal_head() at
fs/jbd/
journal.c:1787: "jh->b_jcount >= 0"

[3.] Keywords (i.e., modules, networking, kernel):

kernel, journal

[4.] Kernel version (from /proc/version):

Linux version 2.6.15.4 (root@gage152b.upc.es) (gcc version 3.3.5 (Debian 
1:3.3.5-13)) #1 SMP Tue Feb 14 16:34:46 CET 2006


[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which triggers the
      problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

[7.2.] Processor information (from /proc/cpuinfo):

---- This is a single Pentium 4 CPU with HyperThreading technology.

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 1
cpu MHz         : 2993.148
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
pbe nx pni monitor ds_cpl cid xtpr
bogomips        : 5991.03

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 1
cpu MHz         : 2993.148
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
pbe nx pni monitor ds_cpl cid xtpr
bogomips        : 5985.54

[7.3.] Module information (from /proc/modules):
iptable_nat 7940 0 - Live 0xf9b57000
md5 4224 1 - Live 0xf9b5c000
ipv6 240480 28 - Live 0xf9bbc000
ipt_limit 2944 8 - Live 0xf9b5a000
iptable_mangle 3200 0 - Live 0xf9b19000
ipt_LOG 6912 8 - Live 0xf9b16000
ipt_MASQUERADE 4096 0 - Live 0xf9b14000
ip_nat 18476 2 iptable_nat,ipt_MASQUERADE, Live 0xf9b40000
ipt_TOS 2816 0 - Live 0xf9b03000
ipt_REJECT 5760 1 - Live 0xf9b11000
ip_conntrack_irc 7152 0 - Live 0xf9b0e000
ip_conntrack_ftp 7792 0 - Live 0xf9b0b000
ipt_state 2304 6 - Live 0xf9b05000
ip_conntrack 47928 6 
iptable_nat,ipt_MASQUERADE,ip_nat,ip_conntrack_irc,ip_conntrack_ftp,ipt_state, 
Live 0xf9b33000
iptable_filter 3328 1 - Live 0xf9b01000
ip_tables 20608 9 
iptable_nat,ipt_limit,iptable_mangle,ipt_LOG,ipt_MASQUERADE,ipt_TOS,ipt_REJECT,ipt_state,iptable_filter, 
Live 0xf887
0000
snd_intel8x0 30748 0 - Live 0xf8877000
snd_ac97_codec 84000 1 snd_intel8x0, Live 0xf9b1d000
snd_ac97_bus 2560 1 snd_ac97_codec, Live 0xf8864000
rtc 13108 0 - Live 0xf8867000
unix 26768 72 - Live 0xf8838000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
/proc/ioports

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-047f : 0000:00:1f.0
   0400-0403 : PM1a_EVT_BLK
   0404-0405 : PM1a_CNT_BLK
   0408-040b : PM_TMR
   0428-042f : GPE0_BLK
0480-04bf : 0000:00:1f.0
0500-051f : 0000:00:1f.3
   0500-050f : i801_smbus
0cf8-0cff : PCI conf1
9000-9fff : PCI Bus #01
   9000-90ff : 0000:01:00.0
a000-afff : PCI Bus #02
   a000-a0ff : 0000:02:03.0
     a000-a0ff : 8139too
b000-b01f : 0000:00:1d.1
   b000-b01f : uhci_hcd
b400-b41f : 0000:00:1d.2
   b400-b41f : uhci_hcd
b800-b81f : 0000:00:1d.3
   b800-b81f : uhci_hcd
bc00-bc1f : 0000:00:1d.0
   bc00-bc1f : uhci_hcd
d800-d8ff : 0000:00:1f.5
   d800-d8ff : Intel ICH5
dc00-dc3f : 0000:00:1f.5
   dc00-dc3f : Intel ICH5
f000-f00f : 0000:00:1f.2
   f000-f007 : ide0
   f008-f00f : ide1

/proc/iomem

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000ccfff : Video ROM
000f0000-000fffff : System ROM
00100000-7ffeffff : System RAM
   00100000-00387b0e : Kernel code
   00387b0f-004c317b : Kernel data
7fff0000-7fff2fff : ACPI Non-volatile Storage
7fff3000-7fffffff : ACPI Tables
88000000-880fffff : PCI Bus #02
   88000000-8800ffff : 0000:02:03.0
e0000000-e7ffffff : 0000:00:00.0
e8000000-f7ffffff : PCI Bus #01
   e8000000-efffffff : 0000:01:00.0
     e8000000-efffffff : radeonfb framebuffer
   f0000000-f7ffffff : 0000:01:00.1
f8000000-f9ffffff : PCI Bus #01
   f8000000-f801ffff : 0000:01:00.0
   f9000000-f900ffff : 0000:01:00.0
     f9000000-f900ffff : radeonfb mmio
   f9010000-f901ffff : 0000:01:00.1
fa000000-fbffffff : PCI Bus #02
   fb000000-fb0000ff : 0000:02:03.0
     fb000000-fb0000ff : 8139too
fc000000-fc0003ff : 0000:00:1d.7
   fc000000-fc0003ff : ehci_hcd
fc001000-fc0011ff : 0000:00:1f.5
   fc001000-fc0011ff : Intel ICH5
fc002000-fc0020ff : 0000:00:1f.5
   fc002000-fc0020ff : Intel ICH5
fec00000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)
0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub 
Interface (rev 02)
         Subsystem: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub 
Interface
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
         Capabilities: [e4] #09 [2106]
         Capabilities: [a0] AGP version 3.0
                 Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                 Command: RQ=1 ArqSz=0 Cal=2 SBA+ AGP- GART64- 64bit- FW- 
Rate=<none>

0000:00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller 
(rev 02) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
         I/O behind bridge: 00009000-00009fff
         Memory behind bridge: f8000000-f9ffffff
         Prefetchable memory behind bridge: e8000000-f7ffffff
         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI 
#1 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Biostar Microtech Int'l Corp: Unknown device 3101
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 16
         Region 4: I/O ports at bc00 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI 
#2 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Biostar Microtech Int'l Corp: Unknown device 3101
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 17
         Region 4: I/O ports at b000 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI 
#3 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Biostar Microtech Int'l Corp: Unknown device 3101
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin C routed to IRQ 18
         Region 4: I/O ports at b400 [size=32]

0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI 
#4 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Biostar Microtech Int'l Corp: Unknown device 3101
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 16
         Region 4: I/O ports at b800 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI 
Controller (rev 02) (prog-if 20 [EHCI])
         Subsystem: Biostar Microtech Int'l Corp: Unknown device 3101
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin D routed to IRQ 19
         Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=1K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2) (prog-if 00 
[Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
         I/O behind bridge: 0000a000-0000afff
         Memory behind bridge: fa000000-fbffffff
         Prefetchable memory behind bridge: 88000000-880fffff
         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge 
(rev 02)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 
Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
         Subsystem: Biostar Microtech Int'l Corp: Unknown device 5200
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at <unassigned>
         Region 1: I/O ports at <unassigned>
         Region 2: I/O ports at <unassigned>
         Region 3: I/O ports at <unassigned>
         Region 4: I/O ports at f000 [size=16]

0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller 
(rev 02)
         Subsystem: Biostar Microtech Int'l Corp: Unknown device 3101
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin B routed to IRQ 3
         Region 4: I/O ports at 0500 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER 
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)
         Subsystem: Biostar Microtech Int'l Corp: Unknown device 8212
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 20
         Region 0: I/O ports at d800 [size=256]
         Region 1: I/O ports at dc00 [size=64]
         Region 2: Memory at fc001000 (32-bit, non-prefetchable) [size=512]
         Region 3: Memory at fc002000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 
9200 PRO] (rev 01) (prog-if 00 [VGA])
         Subsystem: Info-Tek Corp.: Unknown device 0610
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
         Region 1: I/O ports at 9000 [size=256]
         Region 2: Memory at f9000000 (32-bit, non-prefetchable) [size=64K]
         Expansion ROM at f8000000 [disabled] [size=128K]
         Capabilities: [58] AGP version 3.0
                 Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- 
Rate=<none>
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.1 Display controller: ATI Technologies Inc: Unknown device 5940 
(rev 01)
         Subsystem: Info-Tek Corp.: Unknown device 0611
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Region 0: Memory at f0000000 (32-bit, prefetchable) [disabled] 
[size=128M]
         Region 1: Memory at f9010000 (32-bit, non-prefetchable) [disabled] 
[size=64K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
         Subsystem: Biostar Microtech Int'l Corp: Unknown device 2300
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (8000ns min, 16000ns max)
         Interrupt: pin A routed to IRQ 17
         Region 0: I/O ports at a000 [size=256]
         Region 1: Memory at fb000000 (32-bit, non-prefetchable) [size=256]
         Expansion ROM at 88000000 [disabled] [size=64K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):

/var/log/messages

Mar 16 08:20:13 gage152b kernel: ------------[ cut here ]------------
Mar 16 08:20:13 gage152b kernel: SMP
Mar 16 08:20:13 gage152b kernel: Modules linked in: iptable_nat md5 ipv6 
ipt_limit iptable_mangle ipt_LOG ipt_MASQUERADE ip_nat ipt_TOS ipt_REJECT 
ip_conntrack_irc ip_conntrack_ftp ipt_state ip_conntrack iptable_filter 
ip_tables snd_intel8x0 snd_ac97_codec snd_ac97_bus rtc unix
Mar 16 08:20:13 gage152b kernel: CPU:    0
Mar 16 08:20:13 gage152b kernel: EIP: 
0060:[__journal_remove_journal_head+45/343]    Not tainted VLI
Mar 16 08:20:13 gage152b kernel: EFLAGS: 00010282   (2.6.15.4)
Mar 16 08:20:13 gage152b kernel: EIP is at 
__journal_remove_journal_head+0x2d/0x157
Mar 16 08:20:13 gage152b kernel: eax: 00000069   ebx: d2995424   ecx: 
f764dec8   edx: c03b4f00
Mar 16 08:20:13 gage152b kernel: esi: d2995404   edi: f763a200   ebp: 
ef8bb480   esp: f764dec4
Mar 16 08:20:13 gage152b kernel: ds: 007b   es: 007b   ss: 0068
Mar 16 08:20:13 gage152b kernel: Process kjournald (pid: 1209, 
threadinfo=f764c000 task=f7fb5030)
Mar 16 08:20:13 gage152b kernel: Stack: c03b4f00 c038f7f7 c03b12b0 
000006fb c03b1379 d2995404 f11e65e8 c0195952
Mar 16 08:20:13 gage152b kernel:        d2995404 d2995404 c01919b2 
d2995404 00000000 00000000 00000000 00000000
Mar 16 08:20:13 gage152b kernel:        00000081 f774a000 d97b9a60 
00000b4f 00000000 f7fb5030 f5a00a50 f5734580
Mar 16 08:20:13 gage152b kernel: Call Trace:
Mar 16 08:20:13 gage152b kernel:  [journal_remove_journal_head+47/72] 
journal_remove_journal_head+0x2f/0x48
Mar 16 08:20:13 gage152b kernel:  [journal_commit_transaction+1058/3544] 
journal_commit_transaction+0x422/0xdd8
Mar 16 08:20:13 gage152b kernel:  [lock_timer_base+25/51] 
lock_timer_base+0x19/0x33
Mar 16 08:20:13 gage152b kernel:  [try_to_del_timer_sync+19/78] 
try_to_del_timer_sync+0x13/0x4e
Mar 16 08:20:13 gage152b kernel:  [try_to_del_timer_sync+72/78] 
try_to_del_timer_sync+0x48/0x4e
Mar 16 08:20:13 gage152b kernel:  [kjournald+175/504] kjournald+0xaf/0x1f8
Mar 16 08:20:13 gage152b kernel:  [autoremove_wake_function+0/58] 
autoremove_wake_function+0x0/0x3a
Mar 16 08:20:13 gage152b kernel:  [do_exit+819/829] do_exit+0x333/0x33d
Mar 16 08:20:13 gage152b kernel:  [autoremove_wake_function+0/58] 
autoremove_wake_function+0x0/0x3a
Mar 16 08:20:13 gage152b kernel:  [ret_from_fork+6/20] 
ret_from_fork+0x6/0x14
Mar 16 08:20:13 gage152b kernel:  [commit_timeout+0/9] 
commit_timeout+0x0/0x9
Mar 16 08:20:13 gage152b kernel:  [kjournald+0/504] kjournald+0x0/0x1f8
Mar 16 08:20:13 gage152b kernel:  [kernel_thread_helper+5/11] 
kernel_thread_helper+0x5/0xb
Mar 16 08:20:13 gage152b kernel: Code: 8b 74 24 0c 8b 5e 24 83 7b 04 00 79 
29 68 79 13 3b c0 68 fb 06 00 00 68 b0 12 3b c0 68 f7 f7 38 c0 68 00 4f 3b 
c0 e8 df 42 f8 ff <0f> 0b fb 06 b0 12 3b c0 83 c4 14 f0 ff 46 0c 83 7b 04 
00 0f 85



/proc/filesystems
nodev   sysfs
nodev   rootfs
nodev   bdev
nodev   proc
nodev   sockfs
nodev   binfmt_misc
nodev   usbfs
nodev   pipefs
nodev   futexfs
nodev   tmpfs
nodev   inotifyfs
nodev   eventpollfs
nodev   devpts
         ext3
         ext2
nodev   ramfs
         msdos
         vfat
         iso9660
nodev   nfs
nodev   nfsd
         ntfs
nodev   autofs
         udf
nodev   mqueue
nodev   rpc_pipefs

[X.] Other notes, patches, fixes, workarounds:



  --------------------------------------------------------------
  Dr. Raul Orus Perez

  O O O gAGE/UPC        Applied Mathematics Dept. IV
  O O O group           Campus Nord, Mod C3 Room 209
  O O O of Astronomy    Jordi Girona 1-3, 08034 Barcelona, Spain
  U P C and GEomatics   Tel 34-93-4015944
  http://gage1.upc.es   Fax 34-93-4015981
  --------------------------------------------------------------


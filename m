Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271485AbSISPXs>; Thu, 19 Sep 2002 11:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271488AbSISPXs>; Thu, 19 Sep 2002 11:23:48 -0400
Received: from vulcan.bascom.com ([206.112.62.10]:30120 "EHLO
	vulcan.bascom.com") by vger.kernel.org with ESMTP
	id <S271485AbSISPXe>; Thu, 19 Sep 2002 11:23:34 -0400
From: "Drew J. Como" <dcomo@bascom.com>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Kernel Panic for unknown reason
Date: Thu, 19 Sep 2002 11:27:59 -0400
Message-ID: <000c01c25ff1$23a1f990$13013c0a@dcomo>
MIME-Version: 1.0
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As per the information listed below, I have a system that will
only kernel panic when traffic is being sent to him.  If I disconnect
all of the network cables, etc. and let him be, he doesn't panic.

Aug 30 00:15:37 (none) kernel: Unable to handle kernel paging request at
virtual address 50182444
Aug 30 00:15:37 (none) kernel:  printing eip:
Aug 30 00:15:37 (none) kernel: c0135e0d
Aug 30 00:15:37 (none) kernel: *pde = 00000000
Aug 30 00:15:37 (none) kernel: Oops: 0002
Aug 30 00:15:37 (none) kernel: CPU:    0
Aug 30 00:15:37 (none) kernel: EIP:    0010:[open_namei+633/1244]    Not
tainted
Aug 30 00:15:37 (none) kernel: EFLAGS: 00010246
Aug 30 00:15:37 (none) kernel: eax: c2ec0c10   ebx: 00000000   ecx: c02b23bc
edx: 00000003
Aug 30 00:15:37 (none) kernel: esi: c55c0000   edi: c5893f8c   ebp: 00010801
esp: c5893f54
Aug 30 00:15:37 (none) kernel: ds: 0018   es: 0018   ss: 0018
Aug 30 00:15:37 (none) kernel: Process find (pid: 890, stackpage=c5893000)
Aug 30 00:15:37 (none) kernel: Stack: 00010800 c55c0000 08057364 bffff4cc
00001000 00000000 00000004 c2ec0c10
Aug 30 00:15:37 (none) kernel:        c012c3da c55c0000 00010801 08054538
c5893f8c 00000005 c2ec0c10 c7ffc350
Aug 30 00:15:37 (none) kernel:        08057364 bffff4cc 00000000 00000003
00000001 c012c717 c55c0000 00010800
Aug 30 00:15:37 (none) kernel: Call Trace: [filp_open+46/76]
[sys_open+51/148] [system_call+51/56]
Aug 30 00:15:37 (none) kernel:
Aug 30 00:15:37 (none) kernel: Code: 00 8b 44 24 18 50 56 e8 c3 ef ff ff 89
c3 83 c4 08 85 db 00

# cat cpuinfo

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 997.532
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1992.29

# cat modules

ipt_LOG                 3120   1 (autoclean)
ipt_limit                960   1 (autoclean)
ipt_REJECT              2784  11 (autoclean)
ipt_MASQUERADE          1200   2 (autoclean)
ipt_REDIRECT             736   1 (autoclean)
ipt_state                608   4 (autoclean)
iptable_filter          1728   1 (autoclean)
ip_nat_ftp              2720   0 (unused)
ip_conntrack_ftp        3472   0 (unused)
iptable_nat            13168   2 (autoclean) [ipt_MASQUERADE ipt_REDIRECT
ip_nat_ftp]
ip_conntrack           14384   3 [ipt_MASQUERADE ipt_REDIRECT ipt_state
ip_nat_ftp ip_conntrack_ftp iptable_nat]
ip_tables              10528  10 [ipt_LOG ipt_limit ipt_REJECT
ipt_MASQUERADE ipt_REDIRECT ipt_state iptable_filter iptable_nat]

# lspci -vvv

00:00.0 Host bridge: ServerWorks CNB20LE (rev 06)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 48, cache line size 08

00:00.1 Host bridge: ServerWorks CNB20LE (rev 06)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 48, cache line size 08

00:02.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
08)
	Subsystem: Dell Computer Corporation: Unknown device 009b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fe102000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at ecc0 [size=64]
	Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at fd000000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0e.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
(prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00ce
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at e800 [size=256]
	Region 2: Memory at fe101000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: ServerWorks OSB4 (rev 50)
	Subsystem: ServerWorks OSB4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

00:0f.1 IDE interface: ServerWorks: Unknown device 0211 (prog-if 8a [Master
SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 08b0 [size=16]

00:0f.2 USB Controller: ServerWorks: Unknown device 0220 (rev 04) (prog-if
10 [OHCI])
	Subsystem: ServerWorks: Unknown device 0220
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fe100000 (32-bit, non-prefetchable) [size=4K]

01:02.0 SCSI storage controller: Adaptec 7899P (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 00ce
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	BIST result: 00
	Region 0: I/O ports at dc00 [disabled] [size=256]
	Region 1: Memory at f9043000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at f8000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:02.1 SCSI storage controller: Adaptec 7899P (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 00ce
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin B routed to IRQ 11
	BIST result: 00
	Region 0: I/O ports at d800 [disabled] [size=256]
	Region 1: Memory at f9042000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at f8000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:08.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
0d)
	Subsystem: Intel Corporation: Unknown device 1050
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f9041000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at d4c0 [size=64]
	Region 2: Memory at f9020000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:0a.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
0d)
	Subsystem: Intel Corporation: Unknown device 1050
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f9040000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at d480 [size=64]
	Region 2: Memory at f9000000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

Please let me know if this is a hardware problem or ???...

Thanks for your help!!

============================================
Drew J. Como             Phone: 631-434-6600
Systems Administrator      Fax: 631-434-7800
dcomo@bascom.com         Web: www.bascom.com
    Bascom Global Internet Services, Inc.
--------------------------------------------
          "When quality is the goal,
           winning is guaranteed."


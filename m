Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267998AbTGMODt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 10:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268174AbTGMODt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 10:03:49 -0400
Received: from franka.aracnet.com ([216.99.193.44]:31134 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S267998AbTGMODi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 10:03:38 -0400
Date: Sun, 13 Jul 2003 07:18:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 917] New: Badness in Badness in local_bh_enable at kernel/softirq.c:11
Message-ID: <191360000.1058105885@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=917

           Summary: Badness in Badness in local_bh_enable at
                    kernel/softirq.c:11
                    Badness in local_bh_enable at kernel/softirq.c:11
    Kernel Version: 2.5.75
            Status: NEW
          Severity: high
             Owner: bugme-admin@osdl.org
         Submitter: bellucda@tiscali.it


Distribution:Redhat 8
Hardware Environment:
Intel(R) Pentium(R) 4 CPU 2.00GHz
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe ci
d

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
        Subsystem: Acer Incorporated [ALI]: Unknown device 0019
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [9104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP- 64bit- FW+ Rate=x1

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev
04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 96
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: e8000000-e80fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 05) (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: e8100000-e81fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05) (prog-if 80 [Master])
        Subsystem: Acer Incorporated [ALI]: Unknown device 0019
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at 1800 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 05) (prog-if
00 [UHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 0019
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
        Subsystem: Acer Incorporated [ALI]: Unknown device 0019
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at 1810 [size=16]

00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 05) (prog-if
00 [UHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 0019
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 11
        Region 4: I/O ports at 1840 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio (rev 05)
        Subsystem: Acer Incorporated [ALI]: Unknown device 0019
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at 1c00 [size=256]
        Region 1: I/O ports at 1880 [size=64]

00:1f.6 Modem: Intel Corp. 82801BA/BAM AC'97 Modem (rev 05) (prog-if 00 [Generic])
        Subsystem: Acer Incorporated [ALI]: Unknown device 0019
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at 2400 [size=256]
        Region 1: I/O ports at 2000 [size=128]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY
(prog-if 00 [VGA])
        Subsystem: Acer Incorporated [ALI]: Unknown device 0019
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR+ FastB2B+
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 3000 [size=256]
        Region 2: Memory at e8000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
        Subsystem: Acer Incorporated [ALI]: Unknown device 0019
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00001000-000010ff
        I/O window 1: 00001400-000014ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

02:00.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
        Subsystem: Acer Incorporated [ALI]: Unknown device 0019
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: 10c00000-10fff000 (prefetchable)
        Memory window 1: 11000000-113ff000
        I/O window 0: 00002800-000028ff
        I/O window 1: 00002c00-00002cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

02:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet Controller
(rev 03)
        Subsystem: Acer Incorporated [ALI]: Unknown device 0019
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e8100000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 4000 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-



Software Environment:
ppp-2.4.1-7
Problem Description:
local_bh_enable called with irqs_disabled
Steps to reproduce:
run: pppd call <conn. name>

Jul 12 18:19:22 laptop kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 12 18:19:22 laptop kernel: Call Trace:
Jul 12 18:19:22 laptop kernel:  [<c0131368>] local_bh_enable+0x8c/0x8e
Jul 12 18:19:22 laptop kernel:  [<d0959021>] ppp_sync_push+0x11f/0x3d6 [ppp_synctty]
Jul 12 18:19:22 laptop kernel:  [<c0193c73>] lookup_one_len+0x63/0x72
Jul 12 18:19:22 laptop kernel:  [<d09587f7>] ppp_sync_wakeup+0x31/0x60 [ppp_synctty]
Jul 12 18:19:22 laptop kernel:  [<c023961e>] do_tty_hangup+0x6e0/0x8c6
Jul 12 18:19:22 laptop kernel:  [<c01cb368>] devpts_pty_kill+0x40/0x5d
Jul 12 18:19:22 laptop kernel:  [<c023b75b>] release_dev+0x717/0x74e
Jul 12 18:19:22 laptop kernel:  [<c0122c21>] kernel_map_pages+0x29/0x60
Jul 12 18:19:22 laptop kernel:  [<c01cda40>] ext3_release_file+0x0/0x64
Jul 12 18:19:22 laptop kernel:  [<c023bcd2>] tty_release+0x98/0x1b8
Jul 12 18:19:22 laptop kernel:  [<c023bc3a>] tty_release+0x0/0x1b8
Jul 12 18:19:22 laptop kernel:  [<c017eeba>] __fput+0x126/0x138
Jul 12 18:19:22 laptop kernel:  [<c017cf2b>] filp_close+0x4b/0x74
Jul 12 18:19:22 laptop kernel:  [<c012dd75>] put_files_struct+0x8f/0x102
Jul 12 18:19:22 laptop kernel:  [<c012f1b6>] do_exit+0x422/0xada
Jul 12 18:19:22 laptop kernel:  [<c017d058>] sys_close+0x104/0x228
Jul 12 18:19:22 laptop kernel:  [<c012f8a1>] sys_exit+0x15/0x16
Jul 12 18:19:22 laptop kernel:  [<c010afeb>] syscall_call+0x7/0xb


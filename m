Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264551AbUEaGTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbUEaGTY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 02:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264554AbUEaGTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 02:19:24 -0400
Received: from bay17-f43.bay17.hotmail.com ([64.4.43.93]:62737 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264551AbUEaGSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 02:18:36 -0400
X-Originating-IP: [24.74.227.136]
X-Originating-Email: [dctucker@hotmail.com]
From: "Casey Tucker" <dctucker@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: network driver causes kernel panic
Date: Mon, 31 May 2004 06:18:30 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY17-F43UyM2uzq8sC0003192b@hotmail.com>
X-OriginalArrivalTime: 31 May 2004 06:18:31.0232 (UTC) FILETIME=[18453C00:01C446D7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Kernel panic when connector removed from eth1

2. When i remove the RJ-45 connector from the input jack of eth1 on my 
machine, kernel panics. Unfortunately, I cannot give the specific output of 
the crash. I believe the driver is tulip, however not being able to remember 
which card is which, it may indeed be the natsemi driver.

3. natsemi, tulip

4. Linux version 2.6.6 (root@whiteguy) (gcc version 3.2.3) #1 Mon May 10 
17:03:59 EDT 2004

5.

6. #!/bin/sh remove_clip_from_jack(eth1);

7.1
Gnu C                  3.2.3
Gnu make               3.80
binutils               2.14.90.0.6
util-linux             2.12
mount                  2.12
module-init-tools      0.9.14
e2fsprogs              1.34
reiserfsprogs          3.6.4
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.3
Procps                 2.0.16
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         ipt_state ipt_REJECT ipt_LOG iptable_nat ip_conntrack 
iptable_filter ip_tables

7.2
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 534.806
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr
bogomips        : 1052.67

7.3
ipt_state 1408 2 - Live 0xcc8df000
ipt_REJECT 5632 3 - Live 0xcc8eb000
ipt_LOG 5632 1 - Live 0xcc8e8000
iptable_nat 19780 1 - Live 0xcc8c8000
ip_conntrack 29888 2 ipt_state,iptable_nat, Live 0xcc8ce000
iptable_filter 2080 1 - Live 0xcc8bc000
ip_tables 15056 5 ipt_state,ipt_REJECT,ipt_LOG,iptable_nat,iptable_filter, 
Live 0xcc8bf000

7.4
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
d000-d00f : 0000:00:07.1
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : 0000:00:07.2
d800-d87f : 0000:00:0f.0
  d800-d87f : de2104x
dc00-dc1f : 0000:00:10.0
  dc00-dc1f : EMU10K1
e000-e007 : 0000:00:10.1
e400-e4ff : 0000:00:13.0
  e400-e4ff : eth0

7.5
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] 
(rev 06)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=8 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: e6000000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev 
07)
        Subsystem: VIA Technologies, Inc. VT82C596/A/B PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d000 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 02) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d400 [size=32]

00:07.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:0f.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 
[Tulip Pass 3] (rev 21)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d800 [size=128]
        Region 1: Memory at ea001000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at e8000000 [disabled] [size=256K]

00:10.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
        Subsystem: Creative Labs: Unknown device 8064
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at dc00 [size=32]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
08)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at e000 [size=8]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.0 Ethernet controller: National Semiconductor Corporation DP83815 
(MacPhyter) Ethernet Controller
        Subsystem: Netgear: Unknown device f311
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2750ns min, 13000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at e400 [size=256]
        Region 1: Memory at ea000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at e9000000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=320mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

01:00.0 VGA compatible controller: nVidia Corporation NV6 [Vanta/Vanta LT] 
(rev 15) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e6000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at e5000000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>


7.6
no scsi

7.7
yeah that's about it i guess... i'm running on a VIA motherboard (covered in 
lspci i guess)

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar – get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/


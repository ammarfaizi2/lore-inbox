Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVCLAQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVCLAQg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 19:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVCLAPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 19:15:46 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:58829 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S261798AbVCLANF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 19:13:05 -0500
Date: Sat, 12 Mar 2005 01:13:52 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
In-Reply-To: <1110580150.4822.75.camel@eeyore>
Message-ID: <Pine.LNX.4.62.0503120102360.25254@alpha.polcom.net>
References: <20050304234622.63e8a335.akpm@osdl.org> 
 <Pine.LNX.4.62.0503110006260.30687@alpha.polcom.net>  <1110559685.4822.15.camel@eeyore>
  <Pine.LNX.4.62.0503112009070.22293@alpha.polcom.net>  <1110574599.4822.54.camel@eeyore>
  <Pine.LNX.4.62.0503112239580.25254@alpha.polcom.net> <1110580150.4822.75.camel@eeyore>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005, Bjorn Helgaas wrote:

> Can you do an "lspci -vvn"?

# lspci -vvn
0000:00:00.0 Class 0600: 1022:700e (rev 13)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 32
         Region 0: Memory at f0000000 (32-bit, prefetchable)
         Region 1: Memory at f7003000 (32-bit, prefetchable) [size=4K]
         Region 2: I/O ports at c000 [disabled] [size=4]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ 
Rate=x4

0000:00:01.0 Class 0604: 1022:700f
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
         Memory behind bridge: f4000000-f5ffffff
         Prefetchable memory behind bridge: e8000000-efffffff
         BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:07.0 Class 0601: 1106:0686 (rev 40)
         Subsystem: 147b:a702
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.1 Class 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP 
PriP])
         Subsystem: 1106:0571
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 4: I/O ports at c400 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.2 Class 0c03: 1106:3038 (rev 1a)
         Subsystem: 0925:1234
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin D routed to IRQ 9
         Region 4: I/O ports at c800 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.3 Class 0c03: 1106:3038 (rev 1a)
         Subsystem: 0925:1234
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin D routed to IRQ 9
         Region 4: I/O ports at cc00 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.4 Class 0c05: 1106:3057 (rev 40)
         Subsystem: 1106:3057
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin ? routed to IRQ 11
         Capabilities: [68] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 Class 0400: 109e:036e (rev 11)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
         Latency: 32 (4000ns min, 10000ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at f7000000 (32-bit, prefetchable)
         Capabilities: [44] Vital Product Data
         Capabilities: [4c] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.1 Class 0480: 109e:0878 (rev 11)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
         Latency: 32 (1000ns min, 63750ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at f7001000 (32-bit, prefetchable)
         Capabilities: [44] Vital Product Data
         Capabilities: [4c] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0b.0 Class 0401: 1102:0002 (rev 08)
         Subsystem: 1102:8064
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (500ns min, 5000ns max)
         Interrupt: pin A routed to IRQ 9
         Region 0: I/O ports at d000
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0b.1 Class 0980: 1102:7002 (rev 08)
         Subsystem: 1102:0020
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 0: I/O ports at d400
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0d.0 Class 0180: 1095:3112 (rev 02)
         Subsystem: 1095:3112
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
         Latency: 32, cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at d800
         Region 1: I/O ports at dc00 [size=4]
         Region 2: I/O ports at e000 [size=8]
         Region 3: I/O ports at e400 [size=4]
         Region 4: I/O ports at e800 [size=16]
         Region 5: Memory at f7002000 (32-bit, non-prefetchable) [size=512]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:00:0f.0 Class 0200: 10ec:8139 (rev 10)
         Subsystem: 10ec:8139
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
         Latency: 32 (8000ns min, 16000ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at ec00
         Region 1: Memory at f7004000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:05.0 Class 0300: 10de:0150 (rev a4)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 248 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at f4000000 (32-bit, non-prefetchable)
         Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
         Capabilities: [60] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                 Command: RQ=16 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ 
Rate=x4

What do you think about this?

I will try new patch in the morning.


Thanks,

Grzegorz Kulewski

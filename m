Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272532AbRIFTtR>; Thu, 6 Sep 2001 15:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272538AbRIFTtI>; Thu, 6 Sep 2001 15:49:08 -0400
Received: from cs173101.pp.htv.fi ([213.243.173.101]:31846 "EHLO
	porkkala.cs173101.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S272532AbRIFTs7>; Thu, 6 Sep 2001 15:48:59 -0400
Message-ID: <3B97D334.E27BDA25@pp.htv.fi>
Date: Thu, 06 Sep 2001 22:49:08 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: AMD 760 (761?) AGP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

What is current status of support for AMD 760 (or is this 761?) AGP bridge?
Current agpgart doesn't seem to work when forced to load.

Here's output from lspci -vvv and /proc/pci, dunno about lspci, but both are
AGP 4x. Also some id information could be added for the ATI. It's ATI Radeon
VE DDR (QY?, 186 Mhz).

00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700e (rev
13)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at f7800000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at e000 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700f
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e7000000-e7dfffff
	Prefetchable memory behind bridge: e7f00000-f77fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

01:05.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5159
(prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 013a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at e7000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at e7fe0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


  Bus  0, device   0, function  0:
    Host bridge: Advanced Micro Devices [AMD] AMD-760 [Irongate] System
Controller (rev 19).
      Master Capable.  Latency=32.  
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
      Prefetchable 32 bit memory at 0xf7800000 [0xf7800fff].
      I/O at 0xe000 [0xe003].
  Bus  0, device   1, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-760 [Irongate] AGP Bridge
(rev 0).
      Master Capable.  No bursts.  Min Gnt=8.

  Bus  1, device   5, function  0:
    VGA compatible controller: PCI device 1002:5159 (ATI Technologies Inc)
(rev 0).
      IRQ 9.
      Master Capable.  Latency=64.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xe8000000 [0xefffffff].
      I/O at 0xd800 [0xd8ff].
      Non-prefetchable 32 bit memory at 0xe7000000 [0xe700ffff].

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311270AbSDECTN>; Thu, 4 Apr 2002 21:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311403AbSDECTD>; Thu, 4 Apr 2002 21:19:03 -0500
Received: from pcp01314487pcs.hatisb01.ms.comcast.net ([68.63.220.2]:7296 "EHLO
	bacchus.jdhouse.org") by vger.kernel.org with ESMTP
	id <S311270AbSDECSt>; Thu, 4 Apr 2002 21:18:49 -0500
Date: Thu, 4 Apr 2002 20:19:49 -0600 (CST)
From: "Jonathan A. Davis" <davis@jdhouse.org>
To: linux-kernel@vger.kernel.org
Subject: Re: patch-2.4.19-pre5-ac2
In-Reply-To: <Pine.LNX.4.33.0204041720210.1546-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0204041958070.1384-100000@bacchus.jdhouse.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The radeon updates in pre5-ac2 seem to make a minor mess out of my Radeon
7500's console fb.  After X starts up -- switching back to a text console
results in artifacts from the X display contents plus borked scrolling.  
No tendency to crash though and switching back to X results in a normal X
display.  I dropped out the patches to:

drivers/char/drm/radeon_state.c
drivers/video/radeon.h
drivers/video/radeonfb.c

Which returned things to normal.  I'm not up enough on the kernel fb stuff 
to dig into the patch guts very effectively.

The mb chipset is a VIA K266A with very conservative (no overclock, 
etc...) settings.  Processor is an Athlon XP 1700+.

Here is some boot/config info:

--dmesg--
radeonfb: ref_clk=2700, ref_div=12, xclk=23000 defaults
Console: switching to colour frame buffer device 80x30
radeonfb: ATI Radeon 7500 QW  DDR SGRAM 64 MB
radeonfb: DVI port no monitor connected
radeonfb: CRT port CRT monitor connected

--lspci--
01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 
5157 (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 013a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at c000 [size=256]
        Region 2: Memory at ed000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x2
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

--XFree86.0.log--
(--) PCI:*(1:0:0) ATI Radeon 7500 QW rev 0, Mem @ 0xe0000000/27, 
0xed000000/16,I/O @ 0xc000/8
...


-- 

-Jonathan <davis@jdhouse.org>



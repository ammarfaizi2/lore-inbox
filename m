Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281579AbRKRXHW>; Sun, 18 Nov 2001 18:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281589AbRKRXHM>; Sun, 18 Nov 2001 18:07:12 -0500
Received: from dsl-65-185-241-169.telocity.com ([65.185.241.169]:42882 "HELO
	mail.temp123.org") by vger.kernel.org with SMTP id <S281579AbRKRXG5>;
	Sun, 18 Nov 2001 18:06:57 -0500
Date: Sun, 18 Nov 2001 18:06:56 -0500
From: Faux Pas III <fauxpas@temp123.org>
To: linux-kernel@vger.kernel.org
Subject: Weird PCMCIA behavior
Message-ID: <20011118180656.A18252@temp123.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note: this is the same laptop mentioned above in the Maestro 2E
thread above, so the same weird-ass power behavior applies here.

When on AC power, everything is dandy with PCMCIA.  When on 
battery power, PCMCIA device detection fails, emanating a lower
than normal pitched beep, followed by an even lower beep.
However, if the apm module is inserted, this makes it behave
properly, but ONLY if the apm module was compiled with 'Make
CPU idle calls when idle'.  Yeah, I know it's ucked fup.

Some possibly relevant details:

2.4.{14,15-pre{3,5}}
pcmcia-cs-3.1.29

lspci -vv: 

00:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 05)
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=14, subordinate=14, sec-latency=0
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

-- 
Josh Litherland (fauxpas@temp123.org)

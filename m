Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280929AbRKORng>; Thu, 15 Nov 2001 12:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280923AbRKORn1>; Thu, 15 Nov 2001 12:43:27 -0500
Received: from dsl-65-185-241-169.telocity.com ([65.185.241.169]:13954 "HELO
	mail.temp123.org") by vger.kernel.org with SMTP id <S280915AbRKORnS>;
	Thu, 15 Nov 2001 12:43:18 -0500
Date: Thu, 15 Nov 2001 12:43:11 -0500
From: Faux Pas III <fauxpas@temp123.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Maestro 2E vs. Power mgmt
Message-ID: <20011115124311.C11236@temp123.org>
In-Reply-To: <20011115120314.A11264@temp123.org> <Pine.LNX.4.33.0111150926410.21985-100000@segfault.osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111150926410.21985-100000@segfault.osdlab.org>; from mochel@osdl.org on Thu, Nov 15, 2001 at 09:29:27AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 09:29:27AM -0800, Patrick Mochel wrote:

> Could you do a lspci -vv as root on that device both with AC and without?

On AC:

frabjous:~# lspci -vv
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (AGP disabled) (rev 03)
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
        Latency: 64
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]

00:04.0 VGA compatible controller: Neomagic Corporation [MagicMedia 256AV] (rev 12) (prog-if 00 [VGA])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at df000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at ff800000 (32-bit, non-prefetchable) [size=4M]
        Region 2: Memory at ff700000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:05.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 1000 [size=16]

00:05.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at ffe0 [size=32]

00:05.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:07.0 Communication controller: Lucent Microelectronics 56k WinModem (rev 01)
        Subsystem: Toshiba America Info Systems Internal V.90 Modem
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (63000ns min, 3500ns max)
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at ffefff00 (32-bit, non-prefetchable) [size=256]
        Region 1: I/O ports at 02f8 [size=8]
        Region 2: I/O ports at 1c00 [size=256]
        Capabilities: [f8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Communication controller: Toshiba America Info Systems FIR Port (rev 23)
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ff80 [size=32]

00:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 05)
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=14, subordinate=14, sec-latency=0
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

00:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 05)
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=15, subordinate=15, sec-latency=0
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

00:0c.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)
        Subsystem: Toshiba America Info Systems ES1978 Maestro-2E Audiodrive
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ee00 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D2 PME-Enable- DSel=0 DScale=0 PME-

frabjous:~# 

And on battery:

frabjous:~# lspci -vv
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (AGP disabled) (rev 03)
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
        Latency: 64
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]

00:04.0 VGA compatible controller: Neomagic Corporation [MagicMedia 256AV] (rev 12) (prog-if 00 [VGA])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at df000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at ff800000 (32-bit, non-prefetchable) [size=4M]
        Region 2: Memory at ff700000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:05.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 1000 [size=16]

00:05.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at ffe0 [size=32]

00:05.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:07.0 Communication controller: Lucent Microelectronics 56k WinModem (rev 01)
        Subsystem: Toshiba America Info Systems Internal V.90 Modem
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (63000ns min, 3500ns max)
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at ffefff00 (32-bit, non-prefetchable) [size=256]
        Region 1: I/O ports at 02f8 [size=8]
        Region 2: I/O ports at 1c00 [size=256]
        Capabilities: [f8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Communication controller: Toshiba America Info Systems FIR Port (rev 23)
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ff80 [size=32]

00:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 05)
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=14, subordinate=14, sec-latency=0
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

00:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 05)
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=15, subordinate=15, sec-latency=0
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

00:0c.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)
        Subsystem: Toshiba America Info Systems ES1978 Maestro-2E Audiodrive
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ee00 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D2 PME-Enable- DSel=0 DScale=0 PME-

frabjous:~# 



-- 
Josh Litherland (fauxpas@temp123.org)

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131843AbQKWQEv>; Thu, 23 Nov 2000 11:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129667AbQKWQEm>; Thu, 23 Nov 2000 11:04:42 -0500
Received: from grad.physics.sunysb.edu ([129.49.56.86]:3853 "EHLO
        grad.physics.sunysb.edu") by vger.kernel.org with ESMTP
        id <S129581AbQKWQEZ>; Thu, 23 Nov 2000 11:04:25 -0500
Date: Thu, 23 Nov 2000 10:32:14 -0500 (EST)
From: Rui Sousa <rsousa@grad.physics.sunysb.edu>
To: Michael Elkins <me@sigpipe.org>
cc: usb@in.tum.de, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel 2.4.0-test11-ac1 hang with usb-uhci and emu10k1
In-Reply-To: <20001123020203.A30491@toesinperil.com>
Message-ID: <Pine.LNX.4.21.0011231028030.17678-100000@grad.physics.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2000, Michael Elkins wrote:

Usb controller is sharing a interrupt with the emu10k1.
For what I know the emu10k1 driver doesn't have any problem
sharing irq's, so I would blame the usb driver...

Rui Sousa

> 00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64
>         Interrupt: pin D routed to IRQ 9
>         Region 4: I/O ports at 10c0 [size=32]
> 
...
> 
> 00:10.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 07)
>         Subsystem: Creative Labs CT4780 SBLive! Value
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (500ns min, 5000ns max)
>         Interrupt: pin A routed to IRQ 9
>         Region 0: I/O ports at 10e0 [size=32]
>         Capabilities: [dc] Power Management version 1
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:10.1 Input device controller: Creative Labs SB Live! (rev 07)
>         Subsystem: Creative Labs Gameport Joystick
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64
>         Region 0: I/O ports at 1428 [size=8]
>         Capabilities: [dc] Power Management version 1
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
...
> 
> [X.] Other notes, patches, fixes, workarounds:
> 
> Loading the usb-uhci module before the emu10k1 driver seems to work.  I tested
> playing audio while accessing images from my digital camera via USB with
> no errors.
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

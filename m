Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270405AbRHMSyp>; Mon, 13 Aug 2001 14:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270401AbRHMSyh>; Mon, 13 Aug 2001 14:54:37 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:32692 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S270408AbRHMSyX>; Mon, 13 Aug 2001 14:54:23 -0400
Message-Id: <5.1.0.14.2.20010813194733.03dc0a10@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 13 Aug 2001 19:54:32 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live!
  heads-up
Cc: rui.p.m.sousa@clix.pt, alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), pgallen@randomlogic.com,
        linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:35 13/08/01, Alan Cox wrote:
> > > It hung my SMP box solid
> > > It spews white noise on my box with surround speakers
> >
> > Digital or analog speakers?
>
>Analogue four output - I didnt know you had digital out working

To follow myself up: the new driver as found in 2.4.9-pre2 works fine for 
me on my GX440 dual celeron (Tyan Thunder Pro S1836DLUAN mobo). The driver 
is compiled into the kernel and I only tried digital output connected to a 
DTT2500 surround system.

No hangs while playing several mp3s (in X 4.0.3), seeking around them, etc. 
So the driver isn't all bad... It behaves exactly the same as the old one 
for my limited application test set.

Is it perhaps specific to the chipset and/or the actual type of SB Live 
card? - I have the original SB Live! (lspci -vvv output below).

Or does the hang only trigger when you do something specific? I could try 
to reproduce...

Anton

00:00.0 Host bridge: Intel Corporation 440GX - 82443GX Host bridge
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 64
         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
         Capabilities: [a0] AGP version 1.0
                 Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
00:01.0 PCI bridge: Intel Corporation 440GX - 82443GX AGP bridge (prog-if 
00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
         I/O behind bridge: 0000c000-0000cfff
         Memory behind bridge: fd300000-fe3fffff
         Prefetchable memory behind bridge: d9000000-dd0fffff
         BridgeCtl: Parity+ SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Region 4: I/O ports at ffa0 [size=16]
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Interrupt: pin D routed to IRQ 11
         Region 4: I/O ports at ef80 [size=32]
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin ? routed to IRQ 9
00:10.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) 
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, cache line size 08
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: fe400000-fe4fffff
         Prefetchable memory behind bridge: 00000000dd100000-00000000dd100000
         BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                 Bridge: PM- B3+
00:11.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] 
(rev 05)
         Subsystem: Intel Corporation 82558 10/100 with Wake on LAN
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min, 14000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at fd2ff000 (32-bit, prefetchable) [size=4K]
         Region 1: I/O ports at ef40 [size=32]
         Region 2: Memory at fea00000 (32-bit, non-prefetchable) [size=1M]
         Expansion ROM at fe900000 [disabled] [size=1M]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:12.0 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 
(rev 04)
         Subsystem: Adaptec AHA-2940U/2940UW Dual AHA-394xAU/AUW/AUWD AIC-7895B
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min, 2000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at e400 [disabled] [size=256]
         Region 1: Memory at febfe000 (32-bit, non-prefetchable) [size=4K]
         Expansion ROM at febe0000 [disabled] [size=64K]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:12.1 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 
(rev 04)
         Subsystem: Adaptec AHA-2940U/2940UW Dual AHA-394xAU/AUW/AUWD AIC-7895B
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min, 2000ns max), cache line size 08
         Interrupt: pin B routed to IRQ 10
         Region 0: I/O ports at e800 [disabled] [size=256]
         Region 1: Memory at febff000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:14.0 Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood Plus 
DVD Decoder (rev 02)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Interrupt: pin A routed to IRQ 9
         Region 0: Memory at fe800000 (32-bit, non-prefetchable) [size=1M]
         Capabilities: [40] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 
04) (prog-if 00 [VGA])
         Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (4000ns min, 8000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at da000000 (32-bit, prefetchable) [size=32M]
         Region 1: Memory at fe3fc000 (32-bit, non-prefetchable) [size=16K]
         Region 2: Memory at fd800000 (32-bit, non-prefetchable) [size=8M]
         Expansion ROM at fe3e0000 [disabled] [size=64K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [f0] AGP version 2.0
                 Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                 Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1
02:05.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 05)
         Subsystem: Creative Labs CT4620 SBLive!
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (500ns min, 5000ns max)
         Interrupt: pin A routed to IRQ 9
         Region 0: I/O ports at df80 [size=32]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
02:05.1 Input device controller: Creative Labs SB Live! (rev 05)
         Subsystem: Creative Labs Gameport Joystick
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Region 0: I/O ports at dff0 [size=8]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
02:06.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 11)
         Subsystem: Hauppauge computer works Inc.: Unknown device 13eb
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (4000ns min, 10000ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at dd1fe000 (32-bit, prefetchable) [size=4K]
         Capabilities: [44] Vital Product Data
         Capabilities: [4c] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
02:06.1 Multimedia controller: Brooktree Corporation Bt878 (rev 11)
         Subsystem: Hauppauge computer works Inc.: Unknown device 13eb
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (1000ns min, 63750ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at dd1ff000 (32-bit, prefetchable) [size=4K]
         Capabilities: [44] Vital Product Data
         Capabilities: [4c] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-



-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


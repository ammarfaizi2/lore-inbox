Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129657AbQLJI0N>; Sun, 10 Dec 2000 03:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129688AbQLJI0D>; Sun, 10 Dec 2000 03:26:03 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:47763 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S129657AbQLJIZ6>;
	Sun, 10 Dec 2000 03:25:58 -0500
Date: Sun, 10 Dec 2000 02:55:09 -0500
Message-Id: <200012100755.CAA17924@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jens Taprogge <taprogge@idg.rwth-aachen.de>,
        "Theodore Y. Ts'o" <tytso@MIT.EDU>, rgooch@ras.ucalgary.ca,
        jgarzik@mandrakesoft.mandrakesoft.com, dhinds@valinux.com,
        linux-kernel@vger.kernel.org
In-Reply-To: Linus Torvalds's message of Sat, 9 Dec 2000 10:13:50 -0800 (PST),
	<Pine.LNX.4.10.10012091011070.1574-100000@penguin.transmeta.com>
Subject: Re: Serial cardbus code.... for testing, please.....
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Sat, 9 Dec 2000 10:13:50 -0800 (PST)
   From: Linus Torvalds <torvalds@transmeta.com>

   I checked my VAIO's, and they all have a Ricoh cardbus bridge.

   Ted claimed he had a TI1311 or something, I think. So his VAIO is
   definitely different from the ones I have. That may be enough of a
   difference.

Err, no.  At least, I don't think I ever said that.  It has the Ricoh
cardbus bridge.

   (But I know I've tried TI bridges too, and have had multiple success
   reports with them. They are not uncommon. They _do_ tend to need more
   initialization than some of the other bridges, and maybe that's the
   difference. Ted, can you send me the lspci -vvxxx output with the full
   config space setup?)

Here you go.  Here's the lspci -vvxxx output under Linux 2.2.18 with
pcmcia-cs and the CardBus Ositech Jack of Spades inserted and running.

						- Ted


00:00.0 Host bridge: Intel Corporation 430TX - 82439TX MTXC (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
00: 86 80 00 71 06 00 00 22 01 00 00 06 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 80
50: 08 00 81 34 1a 00 50 01 2b 50 55 05 00 00 55 55
60: 08 10 20 20 20 20 00 83 70 03 00 00 00 00 00 00
70: 20 00 0a 00 0e 00 00 00 23 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 20 0f 00 00 00 20 00 00

00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 10 71 0f 00 80 02 02 00 80 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 4d 00 b3 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 09 09 09 09 90 00 00 00 00 f2 80 00 00 00 00 00
70: 00 00 00 00 00 00 0c 0c 00 00 00 00 00 00 00 00
80: 00 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 02 11 01 f1 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 25 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at fcd0
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: d1 fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 07 a3 00 80 00 00 00 00 01 00 02 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at fce0
00: 86 80 12 71 01 00 80 02 01 00 03 0c 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: e1 fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 04 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 86 80 13 71 03 00 80 02 02 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 80 00 00 07 cf 3f 1f d4 17 00 00 00 00 00 00
50: 0a 50 1d 00 71 6d 7d 0f 36 80 00 02 0d 00 00 e2
60: 40 80 f3 62 f8 02 e7 f8 40 01 17 00 00 00 00 00
70: 00 08 17 00 00 00 00 00 00 00 00 00 70 03 11 00
80: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 81 21 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:08.0 VGA compatible controller: Neomagic Corporation NM2160 [MagicGraph 128XD] (rev 01) (prog-if 00 [VGA])
	Subsystem: Sony Corporation MagicGraph 128XD
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fd000000 (32-bit, prefetchable)
	Region 1: Memory at fea00000 (32-bit, non-prefetchable)
	Region 2: Memory at fed00000 (32-bit, non-prefetchable)
00: c8 10 04 00 03 00 80 02 01 00 00 03 00 80 00 00
10: 08 00 00 fd 00 00 a0 fe 00 00 d0 fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 2f 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 10 ff
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 FireWire (IEEE 1394): Sony Corporation CXD1947Q i.LINK Controller (rev 01) (prog-if 00 [Generic])
	Subsystem: Sony Corporation CXD1947Q i.LINK Controller
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fecffc00 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 4d 10 09 80 02 00 10 02 01 00 00 0c 08 40 00 00
10: 00 fc cf fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 09 80
30: 00 00 00 00 dc 00 00 00 00 00 00 00 09 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 01 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c475
	Subsystem: Sony Corporation: Unknown device 8030
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at <ignored> (32-bit, non-prefetchable)
	Bus: primary=00, secondary=20, subordinate=22, sec-latency=176
	Memory window 0: 60020000-60041000
	I/O window 0: 00001000-000011ff
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001
00: 80 11 75 04 07 00 10 02 00 00 07 06 00 a8 02 00
10: 00 00 00 68 dc 00 00 22 00 20 22 b0 00 00 02 60
20: 00 10 04 60 00 00 00 00 00 00 00 00 00 10 00 00
30: fc 11 00 00 00 00 00 00 00 00 00 00 09 01 00 04
40: 4d 10 30 80 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 00 00 00 03 00 00 63 04 63 04 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 19 fe
e0: 00 41 c0 24 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

20:00.0 Ethernet controller: Standard Microsystems Corp [SMC] LANEPIC (rev 01)
	Subsystem: Ositech Communications Inc LANEPIC Cardbus Fast Ethernet Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 7000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 1100
	Region 1: Memory at 60041000 (32-bit, non-prefetchable)
	Expansion ROM at 60030000 [disabled]
00: b8 10 06 00 07 00 80 00 01 00 00 02 00 40 80 00
10: 01 11 00 00 00 10 04 60 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 07 02 00 00 a2 13 06 80
30: 01 00 03 60 00 00 00 00 00 00 00 00 09 01 08 1c
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

20:00.1 Serial controller: Standard Microsystems Corp [SMC] LANEPIC (rev 01) (prog-if 02 [16550])
	Subsystem: Ositech Communications Inc: Unknown device 8007
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 1000
	Region 1: Memory at 60040000 (32-bit, non-prefetchable)
	Expansion ROM at 60020000 [disabled]
00: b8 10 06 00 03 00 80 00 01 02 00 07 00 00 80 00
10: 01 10 00 00 00 00 04 60 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 07 03 00 00 a2 13 07 80
30: 01 00 02 60 00 00 00 00 00 00 00 00 09 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

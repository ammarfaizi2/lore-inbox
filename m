Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129645AbQKTArZ>; Sun, 19 Nov 2000 19:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130692AbQKTArP>; Sun, 19 Nov 2000 19:47:15 -0500
Received: from innerfire.net ([208.181.73.33]:52229 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S129645AbQKTAq7>;
	Sun, 19 Nov 2000 19:46:59 -0500
Date: Sun, 19 Nov 2000 16:18:43 -0800 (PST)
From: Gerhard Mack <gmack@innerfire.net>
To: Alex Romosan <romosan@adonis.lbl.gov>
cc: Martin Mares <mj@suse.cz>, Steven Walter <srwalter@hapablap.dyn.dhs.org>,
        linux-kernel@vger.kernel.org
Subject: Re: "No IRQ known for interrupt pin A..." error message
In-Reply-To: <877l5zg29g.fsf@adonis.lbl.gov>
Message-ID: <Pine.LNX.4.10.10011191617420.21113-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That looks exactly like the message I get if I tell the bios not to assign
an interrupt to my video card.	

	Gerhard


On 19 Nov 2000, Alex Romosan wrote:

> Martin Mares <mj@suse.cz> writes:
> 
> > > During boot, I get the message:
> > > 
> > > PCI: No IRQ known for interrupt pin A of device 00:00.1. Please try
> > > using pci=biosirq.
> > 
> > Can you send me 'lspci -vvx' output, please?
> >  
> 
> i am not the original poster, but i get the same message (save for the
> device number), i.e. "PCI: No IRQ known for interrupt pin A of device
>  05:00.0. Please try using pci=biosirq". this is on a dell latitude
> running 2.4.0-test11-pre7. the output from 'lspci -vvx' follows:
> 
> 00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (AGP disabled) (rev 02)
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
> 	Latency: 32
> 	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
> 00: 86 80 92 71 06 01 00 a2 02 00 00 06 00 20 00 00
> 10: 08 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 00:02.0 VGA compatible controller: Neomagic Corporation NM2160 [MagicGraph 128XD] (rev 01) (prog-if 00 [VGA])
> 	Subsystem: Dell Computer Corporation MagicGraph 128XD
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=16M]
> 	Region 1: Memory at fde00000 (32-bit, non-prefetchable) [size=2M]
> 	Region 2: Memory at fdd00000 (32-bit, non-prefetchable) [size=1M]
> 00: c8 10 04 00 03 00 80 02 01 00 00 03 00 20 00 00
> 10: 08 00 00 e0 00 00 e0 fd 00 00 d0 fd 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 74 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 10 ff
> 
> 00:03.0 CardBus bridge: Texas Instruments PCI1131 (rev 01)
> 	Subsystem: Dell Computer Corporation: Unknown device 0074
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 168, cache line size 08
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=176
> 	Memory window 0: 10400000-107ff000 (prefetchable)
> 	Memory window 1: 10800000-10bff000
> 	I/O window 0: 00001000-000010ff
> 	I/O window 1: 00001400-000014ff
> 	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
> 	16-bit legacy interface ports at 0001
> 00: 4c 10 15 ac 07 00 00 02 01 00 07 06 08 a8 82 00
> 10: 00 00 00 10 00 00 00 02 00 01 01 b0 00 00 40 10
> 20: 00 f0 7f 10 00 00 80 10 00 f0 bf 10 00 10 00 00
> 30: fc 10 00 00 00 14 00 00 fc 14 00 00 0b 01 c0 05
> 40: 28 10 74 00 01 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 00:03.1 CardBus bridge: Texas Instruments PCI1131 (rev 01)
> 	Subsystem: Dell Computer Corporation: Unknown device 0074
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 168, cache line size 08
> 	Interrupt: pin B routed to IRQ 11
> 	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
> 	Bus: primary=00, secondary=05, subordinate=05, sec-latency=176
> 	Memory window 0: 10c00000-10fff000 (prefetchable)
> 	Memory window 1: 11000000-113ff000
> 	I/O window 0: 00001800-000018ff
> 	I/O window 1: 00001c00-00001cff
> 	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
> 	16-bit legacy interface ports at 0001
> 00: 4c 10 15 ac 07 00 00 02 01 00 07 06 08 a8 82 00
> 10: 00 10 00 10 00 00 00 02 00 05 05 b0 00 00 c0 10
> 20: 00 f0 ff 10 00 00 00 11 00 f0 3f 11 00 18 00 00
> 30: fc 18 00 00 00 1c 00 00 fc 1c 00 00 0b 02 00 05
> 40: 28 10 74 00 01 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 00: 86 80 10 71 0f 01 80 02 01 00 80 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32
> 	Region 4: I/O ports at 0860 [size=16]
> 00: 86 80 11 71 05 00 80 02 01 80 01 01 00 20 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 61 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32
> 	Interrupt: pin D routed to IRQ 11
> 	Region 4: I/O ports at ece0 [size=32]
> 00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 20 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: e1 ec 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00
> 
> 00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 00: 86 80 13 71 03 00 80 02 01 00 80 06 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 05:00.0 Ethernet controller: 3Com Corporation 3c575 [Megahertz] 10/100 LAN CardBus (rev 01)
> 	Subsystem: 3Com Corporation 3C575 Megahertz 10/100 LAN Cardbus PC Card
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: I/O ports at 1800 [size=128]
> 	Region 1: Memory at 11000000 (32-bit, non-prefetchable) [size=128]
> 	Region 2: Memory at 11000080 (32-bit, non-prefetchable) [size=128]
> 	Expansion ROM at 10c00000 [size=128K]
> 	Capabilities: [50] Power Management version 1
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 00: b7 10 57 51 07 00 10 02 01 00 00 02 00 40 00 00
> 10: 01 18 00 00 00 00 00 11 80 00 00 11 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 90 00 00 00 b7 10 57 5b
> 30: 01 00 c0 10 50 00 00 00 00 00 00 00 0b 01 00 00
> 
> if i bring up the eth0 interface by hand the card works fine and i can
> connect to the network.
> 
> --alex--
> 
> -- 
> | I believe the moment is at hand when, by a paranoiac and active |
> |  advance of the mind, it will be possible (simultaneously with  |
> |  automatism and other passive states) to systematize confusion  |
> |  and thus to help to discredit completely the world of reality. |
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262495AbTDAMvV>; Tue, 1 Apr 2003 07:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262502AbTDAMvV>; Tue, 1 Apr 2003 07:51:21 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:53178 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S262495AbTDAMvN>; Tue, 1 Apr 2003 07:51:13 -0500
Subject: Re: 2.5.66-mm2-1 freezes solid after init PCMCIA
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030401125328.B30470@flint.arm.linux.org.uk>
References: <1049196020.789.8.camel@teapot>
	 <20030401125328.B30470@flint.arm.linux.org.uk>
Content-Type: multipart/mixed; boundary="=-XzNfdd37qCx2sJY9nv1u"
Organization: 
Message-Id: <1049202135.612.4.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 01 Apr 2003 15:02:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XzNfdd37qCx2sJY9nv1u
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2003-04-01 at 13:53, Russell King wrote:
> On Tue, Apr 01, 2003 at 01:20:21PM +0200, Felipe Alfaro Solana wrote:
> > At this point, the machine hangs. This didn't happen with 2.5.66-mm1 or
> > 2.5.66-mm2 (but it happens with 2.5.66-mm2-1). I'm 99% sure this is
> > caused by Dominik or Russell King PCMCIA patches.
> 
> What happens if you boot without the cardbus card inserted?  If this
> works, please send lspci -vv output.  What happens if you insert the
> cardbus card?  If this works, again, please send the lspci -vv output.

OK, here we go...

1. Booting 2.5.66-mm2-1 at "init 1" with *no* CardBus card inserted
works fine, as expected. The lspci -vvv for this configuration is
attached to this message as "lspci-no-cardbus-inserted".

2. After booting 2.5.66-mm2-1 with *no* CardBus inserted, inserting my
3CCFE575CT CardBus NIC *does* work nicely (i.e. no freezes and network
working OK). The lspci -vvv for this configuration (booting with no
cardbus adapters at "init 1", inserting the card and bringing up the
network) is attached to this message as "lspci-after-inserting-cardbus".

3. Booting 2.5.66-mm1 with CardBus inserted at "init 1". The lspci -vvv
for this scenario is attached to this message as "lspci-2.5.66-mm1".

Hope this helps. Please, don't hesitate to contact with me for further
information, help or patch-testing :-)

Thanks!.

________________________________________________________________________
        Felipe Alfaro Solana
   Linux Registered User #287198
http://counter.li.org

--=-XzNfdd37qCx2sJY9nv1u
Content-Disposition: attachment; filename=lspci-2.5.66-mm1
Content-Type: text/plain; name=lspci-2.5.66-mm1; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fca00000-feafffff
	Prefetchable memory behind bridge: dc800000-dc8fffff
	BridgeCtl: Parity+ SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at ef80 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:09.0 Multimedia audio controller: Yamaha Corporation YMF-754 [DS-1E Audio Controller]
	Subsystem: NEC Corporation: Unknown device 80b5
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (1250ns min, 6250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at febf0000 (32-bit, non-prefetchable) [size=32K]
	Region 1: I/O ports at ef00 [size=64]
	Region 2: I/O ports at efe4 [size=4]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 CardBus bridge: Texas Instruments PCI4450 PC card Cardbus Controller
	Subsystem: NEC Corporation: Unknown device 80b6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 000002c0-000002c3
	I/O window 1: 00001000-000010ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0c.1 CardBus bridge: Texas Instruments PCI4450 PC card Cardbus Controller
	Subsystem: NEC Corporation: Unknown device 80b6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00001400-000014ff
	I/O window 1: 00001800-000018ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:0c.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8011 (prog-if 10 [OHCI])
	Subsystem: NEC Corporation: Unknown device 80b6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 1000ns max), cache line size 08
	Interrupt: pin C routed to IRQ 5
	Region 0: Memory at febff000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at febf8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Communication controller: Lucent Microelectronics LT WinModem
	Subsystem: NEC Corporation: Unknown device 80a8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (63000ns min, 3500ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at febfff00 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at eff0 [size=8]
	Region 2: I/O ports at e800 [size=256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=160mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64) (prog-if 00 [VGA])
	Subsystem: NEC Corporation: Unknown device 80b7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at feac0000 [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:00.0 Ethernet controller: 3Com Corporation 3CCFE575CT Cyclone CardBus (rev 10)
	Subsystem: 3Com Corporation FE575C-3Com 10/100 LAN CardBus-Fast Ethernet
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1400 [size=256]
	Region 1: Memory at 11000000 (32-bit, non-prefetchable) [size=128]
	Region 2: Memory at 11000080 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 10c00000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-


--=-XzNfdd37qCx2sJY9nv1u
Content-Disposition: attachment; filename=lspci-after-inserting-cardbus
Content-Type: text/plain; name=lspci-after-inserting-cardbus; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fca00000-feafffff
	Prefetchable memory behind bridge: dc800000-dc8fffff
	BridgeCtl: Parity+ SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at ef80 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:09.0 Multimedia audio controller: Yamaha Corporation YMF-754 [DS-1E Audio Controller]
	Subsystem: NEC Corporation: Unknown device 80b5
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (1250ns min, 6250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at febf0000 (32-bit, non-prefetchable) [size=32K]
	Region 1: I/O ports at ef00 [size=64]
	Region 2: I/O ports at efe4 [size=4]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 CardBus bridge: Texas Instruments PCI4450 PC card Cardbus Controller
	Subsystem: NEC Corporation: Unknown device 80b6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 000002c0-000002c3
	I/O window 1: 00001000-000010ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0c.1 CardBus bridge: Texas Instruments PCI4450 PC card Cardbus Controller
	Subsystem: NEC Corporation: Unknown device 80b6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00001400-000014ff
	I/O window 1: 00001800-000018ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:0c.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8011 (prog-if 10 [OHCI])
	Subsystem: NEC Corporation: Unknown device 80b6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 1000ns max), cache line size 08
	Interrupt: pin C routed to IRQ 5
	Region 0: Memory at febff000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at febf8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Communication controller: Lucent Microelectronics LT WinModem
	Subsystem: NEC Corporation: Unknown device 80a8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (63000ns min, 3500ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at febfff00 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at eff0 [size=8]
	Region 2: I/O ports at e800 [size=256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=160mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64) (prog-if 00 [VGA])
	Subsystem: NEC Corporation: Unknown device 80b7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at feac0000 [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:00.0 Ethernet controller: 3Com Corporation 3CCFE575CT Cyclone CardBus (rev 10)
	Subsystem: 3Com Corporation FE575C-3Com 10/100 LAN CardBus-Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1400 [size=256]
	Region 1: Memory at 11000000 (32-bit, non-prefetchable) [size=128]
	Region 2: Memory at 11000080 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 10c00000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-


--=-XzNfdd37qCx2sJY9nv1u
Content-Disposition: attachment; filename=lspci-no-cardbus-inserted
Content-Type: text/plain; name=lspci-no-cardbus-inserted; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fca00000-feafffff
	Prefetchable memory behind bridge: dc800000-dc8fffff
	BridgeCtl: Parity+ SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at ef80 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:09.0 Multimedia audio controller: Yamaha Corporation YMF-754 [DS-1E Audio Controller]
	Subsystem: NEC Corporation: Unknown device 80b5
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (1250ns min, 6250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at febf0000 (32-bit, non-prefetchable) [size=32K]
	Region 1: I/O ports at ef00 [size=64]
	Region 2: I/O ports at efe4 [size=4]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 CardBus bridge: Texas Instruments PCI4450 PC card Cardbus Controller
	Subsystem: NEC Corporation: Unknown device 80b6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 000002c0-000002c3
	I/O window 1: 00001000-000010ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0c.1 CardBus bridge: Texas Instruments PCI4450 PC card Cardbus Controller
	Subsystem: NEC Corporation: Unknown device 80b6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00001400-000014ff
	I/O window 1: 00001800-000018ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0c.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8011 (prog-if 10 [OHCI])
	Subsystem: NEC Corporation: Unknown device 80b6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 1000ns max), cache line size 08
	Interrupt: pin C routed to IRQ 5
	Region 0: Memory at febff000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at febf8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Communication controller: Lucent Microelectronics LT WinModem
	Subsystem: NEC Corporation: Unknown device 80a8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (63000ns min, 3500ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at febfff00 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at eff0 [size=8]
	Region 2: I/O ports at e800 [size=256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=160mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64) (prog-if 00 [VGA])
	Subsystem: NEC Corporation: Unknown device 80b7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at feac0000 [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--=-XzNfdd37qCx2sJY9nv1u--


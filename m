Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbTDWVhT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 17:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbTDWVhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 17:37:19 -0400
Received: from pc3-cmbg5-6-cust177.cmbg.cable.ntl.com ([81.104.203.177]:31988
	"EHLO flat") by vger.kernel.org with ESMTP id S264246AbTDWVhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 17:37:13 -0400
Date: Wed, 23 Apr 2003 22:49:55 +0100
From: cb-lkml@fish.zetnet.co.uk
To: linux-kernel@vger.kernel.org
Subject: [2.5.68-mm2] [3c574_cs] irq 11: nobody cared
Message-ID: <20030423214955.GA602@fish.zetnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.5.68-mm2 gives the following message on ethernet activity. Network appears to
work fine.

lspci -vvv output also follows.

Previously reported problem with APM suspend to disk also still present.

Any more info needed?

Cheers
Charlie

handlers:
[<c8862450>] (el3_interrupt+0x0/0x240 [3c574_cs])
irq 11: nobody cared!
Call Trace:
 [<c010b640>] handle_IRQ_event+0x90/0x100
 [<c010b897>] do_IRQ+0x97/0x120
 [<c0107000>] default_idle+0x0/0x40
 [<c0107000>] default_idle+0x0/0x40
 [<c0109c68>] common_interrupt+0x18/0x20
 [<c0107000>] default_idle+0x0/0x40
 [<c0107000>] default_idle+0x0/0x40
 [<c0107024>] default_idle+0x24/0x40
 [<c01070ba>] cpu_idle+0x3a/0x50
 [<c0105000>] _stext+0x0/0x80
 [<c02d8755>] start_kernel+0x135/0x140
 [<c02d84b0>] unknown_bootoption+0x0/0x120


00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (AGP disabled) (rev 03)
	Subsystem: Sony Corporation: Unknown device 805c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 64
	Region 0: Memory at <unassigned> (32-bit, prefetchable) [size=64M]

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at fc90 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at fca0 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:08.0 FireWire (IEEE 1394): Sony Corporation CXD3222 i.LINK Controller (rev 02) (prog-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 8060
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fedf7000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at fedf7c00 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

00:09.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S Audio Controller] (rev 02)
	Subsystem: Sony Corporation: Unknown device 805e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 6250ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fedf8000 (32-bit, non-prefetchable) [size=32K]
	Region 1: I/O ports at fcc0 [size=64]
	Region 2: I/O ports at fc8c [size=4]
	Capabilities: <available only to root>

00:0a.0 VGA compatible controller: Neomagic Corporation NM2200 [MagicGraph 256AV] (rev 20) (prog-if 00 [VGA])
	Subsystem: Sony Corporation: Unknown device 805d
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at fd000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at fe800000 (32-bit, non-prefetchable) [size=4M]
	Region 2: Memory at fec00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: <available only to root>

00:0c.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
	Subsystem: Sony Corporation: Unknown device 8061
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00001400-000014ff
	I/O window 1: 00001800-000018ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001


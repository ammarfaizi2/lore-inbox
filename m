Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283783AbRK3VNq>; Fri, 30 Nov 2001 16:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283785AbRK3VNh>; Fri, 30 Nov 2001 16:13:37 -0500
Received: from smtp2.libero.it ([193.70.192.52]:64439 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S283783AbRK3VN0>;
	Fri, 30 Nov 2001 16:13:26 -0500
Date: Fri, 30 Nov 2001 22:13:34 +0100
From: Emmanuele Bassi <emmanuele.bassi@iol.it>
To: linux-kernel@vger.kernel.org
Subject: Re: Deadlock on kernels > 2.4.13-pre6
Message-ID: <20011130221334.A15353@wolverine.lohacker.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011130164031.A8741@wolverine.lohacker.net> <E169pzm-0003sq-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E169pzm-0003sq-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
X-Mailer: Mutt 1.3.23i (2001-10-09)
X-OS: Linux 2.4.13-pre6 i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk>:

> You might want to check when the  various VIA chipset fixes went in if you
> are using a VIA chipset

I am, indeed, using a VIA chipset, and I found something in the 2.4.10
ChangeLog, but that does not explain why the 2.4.13-pre6 kernel does
work properly... Unless some corrections, not reported into the
changelogs, did eventually occur between 2.4.13-pre* series and 2.4.13.

I frankly gave up hope about getting an explanation...

+++

Even if it shows up to be a VIA problem, what do I have to do, to get my
system work properly with this chipset?

[Output of lspci -v -v -v -v]
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: d0000000-dfffffff
	Prefetchable memory behind bridge: a0000000-afffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 6400 [size=32]

00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 6800 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation Riva TnT [NV04] (rev 04) (prog-if 00 [VGA])
	Subsystem: Creative Labs Graphics Blaster CT6710
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at a0000000 (32-bit, prefetchable) [size=16M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

Bye,
 Emmanuele.

-- 
Emmanuele Bassi (Zefram)               [ http://digilander.iol.it/ebassi ]
GnuPG Key fingerprint = 4DD0 C90D 4070 F071 5738  08BD 8ECC DB8F A432 0FF4

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWFUK7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWFUK7Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 06:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWFUK7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 06:59:24 -0400
Received: from ACaen-151-1-58-69.w86-205.abo.wanadoo.fr ([86.205.201.69]:52378
	"EHLO mint") by vger.kernel.org with ESMTP id S1751482AbWFUK7Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 06:59:24 -0400
Date: Tue, 20 Jun 2006 15:03:41 +0200
From: Jean-Daniel Pauget <jd@disjunkt.com>
To: linux-kernel-owner@vger.kernel.org
Cc: john stultz <johnstul@us.ibm.com>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       bert hubert <bert.hubert@netherlabs.nl>, george@mvista.com
Subject: Re: Linux 2.6.17: PM-Timer bug warning?
Message-ID: <20060620130341.GC5040@disjunkt.com>
References: <20060620100800.GB5040@disjunkt.com> <20060620101946.GA32658@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060620101946.GA32658@rhlx01.fht-esslingen.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 12:19:46PM +0200, Andreas Mohr wrote:
> On Tue, Jun 20, 2006 at 12:08:00PM +0200, Jean-Daniel Pauget wrote:
> >     though my hardware is in the gray list, it didn't trigger the bug 
> >     with OGAWA's test.
> [dual P4 Xeon board]
> Interesting, so it likely isn't buggy.
> Could you give lspci -v -v or so (to let us see chipset and revisions)?
> Oh wait, you already did:
>  (.../...)

    oups sorry, I think my post interfered with Chris Rankin's post.

    my board is single cpu-ed (asus p4pe), gray-listed but OGAWA's test 
    doesn't trigger the bug :

myboard@asus-p4pe# lspci -v -v

0000:00:00.0 Host bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE DRAM Controller/Host-Hub Interface (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80b2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE Host-to-AGP Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: c6000000-c76fffff
	Prefetchable memory behind bridge: d7700000-dfffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 19
	Region 4: I/O ports at d800 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 20
	Region 4: I/O ports at d400 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 17
	Region 4: I/O ports at d000 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 18
	Region 0: Memory at c5800000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 82) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: c3000000-c57fffff
	Prefetchable memory behind bridge: c7700000-d76fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) LPC Bridge (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) UltraATA-100 IDE Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at f000 [size=16]
	Region 5: Memory at 50000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 0
	Region 4: I/O ports at e800 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80b0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 21
	Region 0: I/O ports at a800 [size=256]
	Region 1: I/O ports at a400 [size=64]
	Region 2: Memory at c2800000 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at c2000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 4200] (rev a3) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 8043
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at c6000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 2: Memory at d7800000 (32-bit, prefetchable) [size=512K]
	Expansion ROM at d77e0000 [disabled] [size=128K]
	Capabilities: <available only to root>

0000:02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at c5000000 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at b800 [size=128]
	Capabilities: <available only to root>

0000:02:05.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702X Gigabit Ethernet (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a9
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at c4800000 (64-bit, non-prefetchable) [size=64K]
	Expansion ROM at d76f0000 [disabled] [size=64K]
	Capabilities: <available only to root>

0000:02:0a.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX 440] (rev a3) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at c3000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at c8000000 (32-bit, prefetchable) [size=128M]
	Region 2: Memory at c7800000 (32-bit, prefetchable) [size=512K]
	Expansion ROM at c77e0000 [disabled] [size=128K]
	Capabilities: <available only to root>

----------------------------------------------

--
    Jean-Daniel Pauget  -  http://disjunkt.com  -  http://nekodune.com
    Tél: +33 (0)2 33 17 20 16
    2, rue André PELCA
    50580 Denneville-Plage
    France

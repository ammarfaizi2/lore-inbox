Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbSLYNvZ>; Wed, 25 Dec 2002 08:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbSLYNvZ>; Wed, 25 Dec 2002 08:51:25 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:53201 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S261836AbSLYNvY>;
	Wed, 25 Dec 2002 08:51:24 -0500
To: linux-kernel@vger.kernel.org
Subject: PCMCIA and hermer/orinoco_cs drivers b0rken?
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 24 Dec 2002 18:10:29 +0100
Message-ID: <87u1h3fim2.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since very early 2.4 somewhere it has been impossible to use my two
wireless cards, a NetGear ME401 and a Lucent card (both
orinoco-based). Both are able to load the modules when pluggen in, but
trying to use them is futile, as nothing gets transmitted, and dmesg
show tons of this:

eth1: Station identity 001f:0006:0001:0003
eth1: Looks like an Intersil firmware version 1.03
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:09:5B:27:DC:F9
eth1: Station name "Prism  I"
eth1: ready
eth1: index 0x01: Vcc 5.0, irq 6, io 0x0100-0x013f
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card. ALLOCFID=0128, TXCOMPLFID=0127, EVSTAT=800c
eth1: Error -110 writing packet to BAP
eth1: Error -110 writing Tx descriptor to BAP
eth1: Error -110 writing Tx descriptor to BAP
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card. ALLOCFID=0128, TXCOMPLFID=0127, EVSTAT=800c

The situation is similar for both cars, and I'm wondering if this is
a known broken setup, or I've messed up?

Currnently I'm on 2.4.20, tried both with and without the ACPI and
preempt patches (vmware deosnt make a difference either), the hardware
is a Compaq Evo n800c notebook and this is the cardbus bridge:

02:06.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
	Subsystem: Compaq Computer Corporation: Unknown device 004a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 20
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 40000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=176
	Memory window 0: 30400000-307ff000 (prefetchable)
	Memory window 1: 30800000-30bff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264577AbRFTTTj>; Wed, 20 Jun 2001 15:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264576AbRFTTT3>; Wed, 20 Jun 2001 15:19:29 -0400
Received: from maestro.symsys.com ([208.223.9.37]:20485 "EHLO
	maestro.symsys.com") by vger.kernel.org with ESMTP
	id <S264575AbRFTTTQ>; Wed, 20 Jun 2001 15:19:16 -0400
Date: Wed, 20 Jun 2001 14:19:00 -0500 (CDT)
From: Greg Ingram <ingram@symsys.com>
To: linux-kernel@vger.kernel.org
Subject: Unknown PCI Net Device
In-Reply-To: <Pine.LNX.4.10.10106202036470.10363-100000@luxik.cdi.cz>
Message-ID: <Pine.LNX.4.21.0106201401060.1874-100000@maestro.symsys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I picked up a network card that claims to use the "most reliable Realtek
LAN chip".  The big chip is labelled "LAN-8139" so naturally I tried the
8139too driver.  It doesn't find the device.  I'm wondering if maybe it's
just something in the device ID tables.  Here's some info:

# lspci -vv 

[snip]

00:0b.0 Ethernet controller: MYSON Technology Inc: Unknown device 0803
	Subsystem: MYSON Technology Inc: Unknown device 0803
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 min, 64 max, 64 set, cache line size 08
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at e400 [size=256]
	Region 1: Memory at e9000000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at e8000000 [disabled] [size=64K]
	Capabilities: [88] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1+ D2- PME-
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

[snip]

The driver disk includes fealnx.[co].  The driver is for 2.0 and has a
reference to Donald Becker's website at NASA.  I don't know if the driver
is based on Becker's work.  There's no GPL.  In fact, there's no license
of any sort in the source.

Any suggestions?

- Greg



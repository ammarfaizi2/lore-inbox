Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130160AbRBWCu1>; Thu, 22 Feb 2001 21:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131002AbRBWCuR>; Thu, 22 Feb 2001 21:50:17 -0500
Received: from [209.143.110.29] ([209.143.110.29]:58894 "HELO
	mail.the-rileys.net") by vger.kernel.org with SMTP
	id <S130160AbRBWCuG>; Thu, 22 Feb 2001 21:50:06 -0500
Message-ID: <3A95D05E.43DBBB73@the-rileys.net>
Date: Thu, 22 Feb 2001 21:52:14 -0500
From: David Riley <oscar@the-rileys.net>
Organization: The Riley Family
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bus mastering troubles with AGP Voodoo3
Content-Type: multipart/mixed;
 boundary="------------1A1278D01CA0EDB35EB57D01"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1A1278D01CA0EDB35EB57D01
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I knew my performance hit had to be coming from somewhere...

I'm using an MSI K7T Pro mtherboard (KT133 chipset) and a Voodoo3 2000. 
I can't seem to set bus mastering on the AGP card at all.  This does not
work:

setpci -s 01:00.0 4.w=0007 (setpci -s 01:00.0 4.w gives me 0003)

Nor does:

setpci -s 01:00.0 COMMAND=0007

No permutation of this works.  No error messages are returned, but the
register remains unchanged at 3.  I have tried using -H1 and -H2, to no
avail (-H2 doesn't even get there, complaining about something on the
normal PCI bus).  I have tried this with the BIOS set on "PnP OS" and
off, with no difference.  My guess is that this is a motherboard
specific problem (broken BIOS, anyone), though I don't think I've heard
of a broken BIOS causing unwriteable PCI config registers.  For what
it's worth, I've attached the output of 'lspci -vv -s 0:1.0' (the AGP
host bridge) and 'lspci -vv -s 1:0.0' (the card).

Thanks for any help you may have...
--------------1A1278D01CA0EDB35EB57D01
Content-Type: text/plain; charset=us-ascii;
 name="foobar"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="foobar"

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: d0000000-d3ffffff
	Prefetchable memory behind bridge: d4000000-d5ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc. Voodoo3 AGP
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=32M]
	Region 1: Memory at d4000000 (32-bit, prefetchable) [size=32M]
	Region 2: I/O ports at c000 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>


--------------1A1278D01CA0EDB35EB57D01--


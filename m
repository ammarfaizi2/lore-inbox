Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWBRF1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWBRF1B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 00:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWBRF04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 00:26:56 -0500
Received: from marsha.pcisys.net ([216.229.32.146]:22670 "EHLO
	marsha.pcisys.net") by vger.kernel.org with ESMTP id S1750821AbWBRF04
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 00:26:56 -0500
Date: Fri, 17 Feb 2006 22:27:20 -0700
From: Brian Hall <brihall@pcisys.net>
To: linux-kernel@vger.kernel.org
Cc: linux@syskonnect.de
Subject: Help: DGE-560T not recognized by Linux
Message-Id: <20060217222720.a08a2bc1.brihall@pcisys.net>
X-Mailer: Sylpheed version 2.2.0beta8 (GTK+ 2.8.12; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have just built a new system, based on an Asrock 939Dual-Sata
motherboard. It only has 100MB built-in networking (uli526x), so I
purchased a D-Link DGE-560T PCI-e gigabit NIC ($81 at Newegg) thinking
it was supported by Linux. Looking at the card, it appears to be a
Marvell chip, but neither the sk98lin or skge drivers worked. I tried
other GBe drivers as well, they didn't recognize it either.

Is there a place where I can just add this card's ID and use one of the
sk* drivers? I paged through the source but didn't see an obvious place
to add a card ID, but it must be in there somewhere.

I'm not subscribed to linux-kernel, please CC: me on replies, thanks.

Here's the info from the card:
big M on the chip (Marvell I assume)
88E8052-NNC
GMAA17011A1
0442 A2P

and on the back of the card:

00005A708649 0592
DLink
531CL00467 DGE-560T 70-13-001-001

from lspci:

02:00.0 0200: 1186:4b00 (rev 11)
	Subsystem: 1186:4b00

02:00.0 Ethernet controller: D-Link System Inc Unknown device 4b00 (rev
11) Subsystem: D-Link System Inc Unknown device 4b00
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- Status: Cap+ 66MHz- UDF- FastB2B-
ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR- Latency:
0, Cache Line Size 10 Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ff3fc000 (64-bit, non-prefetchable)
[size=16K] Region 2: I/O ports at 9800 [size=256]
	Expansion ROM at 50000000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1
+,D2+,D3hot+,D3cold+) Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [5c] Message Signalled Interrupts: 64bit+
Queue=0/1 Enable- Address: 0000000000000000  Data: 0000
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0,
ExtTag- Device: Latency L0s unlimited, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal-
Unsupported- Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port
214 Link: Latency L0s <256ns, L1 unlimited
		Link: ASPM Disabled RCB 128 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1


--
Brian Hall, Linux Consultant       http://pcisys.net/~brihall
"Smoke may indicate you have exceeded maximum performance levels."

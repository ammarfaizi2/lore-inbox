Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVJYSQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVJYSQg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 14:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbVJYSQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 14:16:36 -0400
Received: from qproxy.gmail.com ([72.14.204.192]:18271 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932283AbVJYSQf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 14:16:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QvyZQUIo1suB9f+RhCX+17EC7Wn0ZaiCNo8mwvtNsDnqF6idGjD/rhBsrHK4PRiOBJIM5fHvYENTy8YnODD0O9kjQTU8GeYCygtcpXS3qgsoEdR9+RpwEis6qX3xNwfv7RaRpRiidGRJtVc0y7vsFa6fZMiFDQ54tlmDIYQMxUY=
Message-ID: <3aa654a40510251116k78a3b260i9f9ec3914e0de051@mail.gmail.com>
Date: Tue, 25 Oct 2005 11:16:31 -0700
From: Avuton Olrich <avuton@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.14-rc5-mm1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1130265540.25191.55.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051024014838.0dd491bb.akpm@osdl.org>
	 <3aa654a40510251055r33b2b8a5kbd5c53471a243851@mail.gmail.com>
	 <1130265540.25191.55.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-10-25 at 10:55 -0700, Avuton Olrich wrote:
> > After upgrading to 2.6.14-rc5-mm1 I have been greeted with:
> > PCI-Bridge- Detected Parity Error on 0000:00:08.0 0000:00:08.0
>
> > ... I probably get a new one every minute or so. Is this new, perhaps
> > part of the new EDAC stuff? And what kind of adverse effect does this
> > have on my computer (the actual parity error)?
>
> If the parity error is real then it would indicate a bad PCI transfer
> has occurred and data corrupted in the transfer. Unfortunately because
> some vendors don't use PCI parity checking much and some card vendors
> don't debug their products except on that OS there are some cards that
> generate spurious parity errors.
>
> Can you send an lspci -vxx. That'll help the EDAC folk build up a view
> of what needs to be blacklisted.

Thanks for the answer, here's the lspci -vxx:

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different
version?) (rev a2)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80ac
	Flags: bus master, 66Mhz, fast devsel, latency 0
	Memory at e0000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [40] AGP version 2.0
	Capabilities: [60] #08 [2001]
00: de 10 e0 01 06 00 b0 00 a2 00 00 06 00 00 80 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ac 80
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00

0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev a2)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80ac
	Flags: 66Mhz, fast devsel
00: de 10 eb 01 00 00 20 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ac 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00

0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev a2)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80ac
	Flags: 66Mhz, fast devsel
00: de 10 ee 01 00 00 20 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ac 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00

0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev a2)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80ac
	Flags: 66Mhz, fast devsel
00: de 10 ed 01 00 00 20 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ac 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev a2)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80ac
	Flags: 66Mhz, fast devsel
00: de 10 ec 01 00 00 20 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ac 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00

0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev a2)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80ac
	Flags: 66Mhz, fast devsel
00: de 10 ef 01 00 00 20 00 a2 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ac 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00

0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
	Subsystem: ASUSTeK Computer Inc. A7N8X Mainboard
	Flags: bus master, 66Mhz, fast devsel, latency 0
	Capabilities: [48] #08 [01e1]
00: de 10 60 00 0f 00 b0 00 a3 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ad 80
30: 00 00 00 00 48 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 0c11
	Flags: 66Mhz, fast devsel, IRQ 5
	I/O ports at c800 [size=32]
	Capabilities: [44] Power Management version 2
00: de 10 64 00 01 00 b0 00 a2 00 05 0c 00 00 80 00
10: 01 c8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 11 0c
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 03 01

0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a3) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. A7N8X Mainboard
	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 17
	Memory at e9080000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
00: de 10 67 00 07 00 b0 00 a3 10 03 0c 00 00 80 00
10: 00 00 08 e9 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 11 0c
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 03 01

0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a3) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. A7N8X Mainboard
	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 18
	Memory at e9082000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
00: de 10 67 00 07 00 b0 00 a3 10 03 0c 00 00 80 00
10: 00 20 08 e9 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 11 0c
30: 00 00 00 00 44 00 00 00 00 00 00 00 0c 02 03 01

0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a3) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. A7N8X Mainboard
	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 16
	Memory at e9083000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] #0a [2080]
	Capabilities: [80] Power Management version 2
00: de 10 68 00 06 00 b0 00 a3 20 03 0c 00 00 80 00
10: 00 30 08 e9 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 11 0c
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 03 03 01

0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
Controller (rev a1)
	Subsystem: ASUSTeK Computer Inc. A7N8X Mainboard onboard nForce2 Ethernet
	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 17
	Memory at e9084000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at cc00 [size=8]
	Capabilities: [44] Power Management version 2
00: de 10 66 00 07 00 b0 00 a1 00 00 02 00 00 00 00
10: 00 40 08 e9 01 cc 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 a7 80
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 01 14

0000:00:05.0 Multimedia audio controller: nVidia Corporation nForce
Audio Processing Unit (rev a2)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 0c11
	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 3
	Memory at e9000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [44] Power Management version 2
00: de 10 6b 00 06 00 b0 00 a2 00 01 04 00 00 00 00
10: 00 00 00 e9 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 11 0c
30: 00 00 00 00 44 00 00 00 00 00 00 00 03 01 01 0c

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2
AC97 Audio Controler (MCP) (rev a1)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 8095
	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 11
	I/O ports at c000 [size=256]
	I/O ports at c400 [size=128]
	Memory at e9081000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
00: de 10 6a 00 07 00 b0 00 a1 00 01 04 00 00 00 00
10: 01 c0 00 00 01 c4 00 00 00 10 08 e9 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 95 80
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 02 05

0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI
Bridge (rev a3) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00009000-0000afff
	Memory behind bridge: e2000000-e5ffffff
	Prefetchable memory behind bridge: e6000000-e6ffffff
00: de 10 6c 00 07 01 a0 00 a3 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 90 a0 80 a2
20: 00 e2 f0 e5 00 e6 f0 e6 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a 06

0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
(prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 0c11
	Flags: bus master, 66Mhz, fast devsel, latency 0
	I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2
00: de 10 65 00 05 00 b0 00 a2 8a 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 f0 00 00 00 00 00 00 00 00 00 00 43 10 11 0c
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 03 01

0000:00:0c.0 PCI bridge: nVidia Corporation nForce2 PCI Bridge (rev
a3) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: e7000000-e8ffffff
	Prefetchable memory behind bridge: 30000000-300fffff
00: de 10 6d 00 07 01 a0 00 a3 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 20 b0 b0 80 02
20: 00 e7 f0 e8 00 30 00 30 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00

0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev a2)
(prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 32
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
00: de 10 e8 01 07 01 20 02 a2 00 04 06 00 20 01 00
10: 00 00 00 00 00 00 00 00 00 03 03 20 f0 00 20 22
20: f0 ff 00 00 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00

0000:01:07.0 VGA compatible controller: Matrox Graphics, Inc. MGA
1064SG [Mystique] (rev 03) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc.: Unknown device 0000
	Flags: bus master, stepping, medium devsel, latency 32, IRQ 7
	Memory at e6000000 (32-bit, prefetchable) [size=8M]
	Memory at e2000000 (32-bit, non-prefetchable) [size=16K]
	Memory at e3000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at e68a0000 [disabled] [size=64K]
00: 2b 10 1a 05 87 00 80 02 03 00 00 03 00 20 00 00
10: 08 00 00 e6 00 00 00 e2 00 00 00 e3 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 07 01 00 00

0000:01:09.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
	Subsystem: Creative Labs SB Audigy 2 ZS (SB0350)
	Flags: bus master, medium devsel, latency 32, IRQ 21
	I/O ports at 9000 [size=64]
	Capabilities: [dc] Power Management version 2
00: 02 11 04 00 05 00 90 02 04 00 01 04 00 20 80 00
10: 01 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 02 20
30: 00 00 00 00 dc 00 00 00 00 00 00 00 04 01 02 14

0000:01:09.1 Input device controller: Creative Labs SB Audigy
MIDI/Game port (rev 04)
	Subsystem: Creative Labs SB Audigy MIDI/Game Port
	Flags: bus master, medium devsel, latency 32
	I/O ports at 9400 [size=8]
	Capabilities: [dc] Power Management version 2
00: 02 11 03 70 05 00 90 02 04 00 80 09 00 20 80 00
10: 01 94 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 40 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 00 00

0000:01:09.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire
Port (rev 04) (prog-if 10 [OHCI])
	Subsystem: Creative Labs SB Audigy FireWire Port
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at e5004000 (32-bit, non-prefetchable) [size=2K]
	Memory at e5000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
00: 02 11 01 40 06 00 10 02 04 10 00 0c 08 20 80 00
10: 00 40 00 e5 00 00 00 e5 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 10 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 02 02 04

0000:01:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8169 Gigabit Ethernet (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 19
	I/O ports at 9800 [size=256]
	Memory at e5005000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at e6880000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
00: ec 10 69 81 17 00 b0 02 10 00 00 02 10 20 00 00
10: 01 98 00 00 00 50 00 e5 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 69 81
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0c 01 20 40

0000:01:0b.0 RAID bus controller: Silicon Image, Inc. SiI 3112
[SATALink/SATARaid] Serial ATA Controller (rev 01)
	Subsystem: Silicon Image, Inc. SiI 3112 SATARaid Controller
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 20
	I/O ports at 9c00 [size=8]
	I/O ports at a000 [size=4]
	I/O ports at a400 [size=8]
	I/O ports at a800 [size=4]
	I/O ports at ac00 [size=16]
	Memory at e5006000 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at e6800000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
00: 95 10 12 31 07 00 b0 02 01 00 04 01 08 20 00 00
10: 01 9c 00 00 01 a0 00 00 01 a4 00 00 01 a8 00 00
20: 01 ac 00 00 00 60 00 e5 00 00 00 00 95 10 12 61
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 00 00

0000:02:01.0 Ethernet controller: 3Com Corporation 3C920B-EMB
Integrated Fast Ethernet Controller [Tornado] (rev 40)
	Subsystem: ASUSTeK Computer Inc. A7N8X Deluxe onboard 3C920B-EMB
Integrated Fast Ethernet Controller
	Flags: bus master, medium devsel, latency 32, IRQ 16
	I/O ports at b000 [size=128]
	Memory at e8000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 30000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
00: b7 10 01 92 07 00 10 02 40 00 00 02 08 20 00 00
10: 01 b0 00 00 00 00 00 e8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 ab 80
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 0a 0a



--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310654AbSEELai>; Sun, 5 May 2002 07:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310666AbSEELai>; Sun, 5 May 2002 07:30:38 -0400
Received: from edu.joroinen.fi ([195.156.135.125]:60423 "HELO edu.joroinen.fi")
	by vger.kernel.org with SMTP id <S310654AbSEELag> convert rfc822-to-8bit;
	Sun, 5 May 2002 07:30:36 -0400
Date: Sun, 5 May 2002 14:30:34 +0300 (EEST)
From: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
X-X-Sender: <pk@edu.joroinen.fi>
To: <linux-kernel@vger.kernel.org>
Subject: Tulip driver broken in 2.4.18
Message-ID: <Pine.LNX.4.33.0205051421070.32094-100000@edu.joroinen.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

Tulip driver included in 2.4.18 doesn't work for me. I have tulip-based
card which is connected to 10Mbps HUB. The driver fails to set 10Mbps
halfduplex, and because of that the link between computer and HUB doesn't
work. HUB keeps flashing it's lights wildly (because my tulip tries to
enable 100Mbps..), and the link-led doesn't turn on..

Tulip driver 0.9.14 (available from sourceforge) works OK and correctly
sets 10Mbps halfduplex.

This is what mii-diag says when using 2.4.18:

Basic registers of MII PHY #32:  2000 7848 0000 0000 01e1 0000 0000 0000.
 Basic mode control register 0x2000: Auto-negotiation disabled, with
 Speed fixed at 100 mbps, half-duplex.
 Basic mode status register 0x7848 ... 7848.
   Link status: not established.
 Link partner information information is not exchanged when in fixed speed
mode.   End of basic transceiver informaion.


And after a couple of seconds it says this:


Basic registers of MII PHY #32:  1000 7848 0000 0000 01e1 0000 0000 0000.
 Basic mode control register 0x1000: Auto-negotiation enabled.
 Basic mode status register 0x7848 ... 7848.
   Link status: not established.
   End of basic transceiver informaion.


And then after a couple of seconds comes the 100Mbps again (the first
mii-diag paste) and loop continues..


Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
PCI: Found IRQ 5 for device 00:09.0
PCI: Sharing IRQ 5 with 00:04.2
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media 10baseT (#0) described by a 21142 Serial PHY (2) block.
tulip0:  Index #1 - Media 10baseT-FDX (#4) described by a 21142 Serial PHY  (2) block.
tulip0:  Index #2 - Media 100baseTx (#3) described by a 21143 SYM PHY (4) block.
tulip0:  Index #3 - Media 100baseTx-FDX (#5) described by a 21143  SYM PHY (4) block.
eth1: Digital DS21143 Tulip rev 65 at 0xb000, 00:C0:CA:20:3C:A5, IRQ 5.


Any ideas?


- Pasi Kärkkäinen

                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.


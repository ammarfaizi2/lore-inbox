Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264933AbRGABW3>; Sat, 30 Jun 2001 21:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264936AbRGABWS>; Sat, 30 Jun 2001 21:22:18 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:15876
	"EHLO Opus.bloom.county") by vger.kernel.org with ESMTP
	id <S264933AbRGABWE>; Sat, 30 Jun 2001 21:22:04 -0400
Date: Sat, 30 Jun 2001 18:21:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Broken tulip in 2.4.5+
Message-ID: <20010630182110.A1144@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  The current tulip driver in 2.4.5 and up no longer works with my
'tulip' ethernet card.  0.9.14 (what's in prior to 2.4.5-pre6, iirc) works
fine with the card, as does de4x5.  Version 0.9.15-pre5 (2.4.6-pre8) and
1.1.8 (from sourceforge) both don't work.  The card is:
01:15.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
        Flags: bus master, medium devsel, latency 96, IRQ 58
        I/O ports at 0400 [size=128]
        Memory at 80080000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=256K]
The error(s) are as follows, for both 0.9.15-pre5 and 1.1.8:
Linux Tulip driver version 0.9.15-pre5 (June 16, 2001)
tulip0:  EEPROM default media type 10baseT.
tulip0:  Index #0 - Media 10baseT (#0) described by a 21140 non-MII (0) block.
tulip0:  Index #1 - Media 100baseTx (#3) described by a 21140 non-MII (0) block.
tulip0:  Index #2 - Media 10baseT-FDX (#4) described by a 21140 non-MII (0) block.
tulip0:  Index #3 - Media 100baseTx-FDX (#5) described by a 21140 non-MII (0) block.
tulip0:  MII transceiver #1 config 1000 status 782d advertising 05e1.
eth1: Digital DS21140 Tulip rev 34 at 0xd2118000, 00:00:94:A3:FA:0D, IRQ 58.
eth1: Using EEPROM-set media 10baseT.
eth1: Setting full-duplex based on MII#1 link partner capability of 41e1.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: 21140 transmit timed out, status fc680000, SIA ffffff0b ffffffff 1c09fdc0 fffffec8, resetting.
..
eth1: transmit timed out, switching to 100baseTx-FDX media.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

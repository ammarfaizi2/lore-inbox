Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317004AbSFFQYR>; Thu, 6 Jun 2002 12:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317005AbSFFQYQ>; Thu, 6 Jun 2002 12:24:16 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:3461 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S317004AbSFFQYP>;
	Thu, 6 Jun 2002 12:24:15 -0400
Date: Thu, 6 Jun 2002 18:24:13 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200206061624.SAA17598@harpo.it.uu.se>
To: jgarzik@mandrakesoft.com
Subject: 2.5.20 tulip bogosities
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.5.19 tulip says the following for my 21143:

Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Found IRQ 5 for device 02:0a.0
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #1 config 3000 status 782d advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at 0xd800, 00:40:C7:99:3A:5B, IRQ 5.

But 2.5.20 tulip now spews the following and then misidentifies
the NIC as a 21140:

Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Found IRQ 5 for device 02:0a.0
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media 100baseTx (#3) described by a 21140 non-MII (0) block.
tulip0:  Index #1 - Media 10baseT (#0) described by a 21140 non-MII (0) block.
...
[136 lines deleted]
...
tulip0:  Index #139 - Media 10baseT (#0) described by a 21140 non-MII (0) block.
tulip0:  Index #140 - Media 10baseT (#0) described by a 21140 non-MII (0) block.
eth%d:  Invalid media table selection 255.
tulip0:  MII transceiver #1 config 3000 status 782d advertising 01e1.
eth0: Digital DS21140 Tulip rev 65 at 0xd800, 00:40:C7:99:3A:5B, IRQ 5.

Also note the obviously broken "eth%d" printk format string.

/Mikael

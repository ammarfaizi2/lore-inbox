Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129805AbQKNArg>; Mon, 13 Nov 2000 19:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130411AbQKNArb>; Mon, 13 Nov 2000 19:47:31 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:17175 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S129805AbQKNArO>; Mon, 13 Nov 2000 19:47:14 -0500
Date: Mon, 13 Nov 2000 19:17:10 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.2.18-21 tulip.c fix for ADMtek AN985 Comet
Message-ID: <20001113191710.A1644@sectionIV.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Lee Bradshaw <lee@sectionIV.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo for the pci id for the ADMtek AN985 Comet. I have two
cards working with this patch (a 2 card/hub package deal), but I also
have to "ifconfig eth0 promisc" to get the cards working properly.

--- kernel-source-2.2.18-21/drivers/net/tulip.c	Mon Nov 13 18:05:51 2000
+++ linux/drivers/net/tulip.c	Mon Nov 13 17:34:01 2000
@@ -345,7 +345,7 @@
   { "ADMtek AN981 Comet",
 	0x1317, 0x0981, 0xffff, PCI_ADDR0_IO, 256, 32, tulip_probe1 },
   { "ADMtek AN985 Comet",
-	0x1317, 0x0981, 0xffff, PCI_ADDR0_IO, 256, 32, tulip_probe1 },
+	0x1317, 0x0985, 0xffff, PCI_ADDR0_IO, 256, 32, tulip_probe1 },
   { "Compex RL100-TX",
 	0x11F6, 0x9881, 0xffff, PCI_ADDR0_IO, 128, 32, tulip_probe1 },
   { "Intel 21145 Tulip",

-- 
Lee Bradshaw                 lee@sectionIV.com (preferred)
Texas Instruments            bradshaw@ti.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267530AbSKQRhm>; Sun, 17 Nov 2002 12:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267531AbSKQRhm>; Sun, 17 Nov 2002 12:37:42 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:39852 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S267530AbSKQRhl>; Sun, 17 Nov 2002 12:37:41 -0500
Message-ID: <3DD7D577.3030308@quark.didntduck.org>
Date: Sun, 17 Nov 2002 12:44:23 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Emu10k1 gameport fix
Content-Type: multipart/mixed;
 boundary="------------070407050706090908030408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070407050706090908030408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Change from PCI name to generic device name.

--
				Brian Gerst

--------------070407050706090908030408
Content-Type: text/plain;
 name="emugp-name-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="emugp-name-1"

diff -urN -X scripts/dontdiff linux-2.5.47-bk3/drivers/input/gameport/emu10k1-gp.c linux/drivers/input/gameport/emu10k1-gp.c
--- linux-2.5.47-bk3/drivers/input/gameport/emu10k1-gp.c	Mon Oct 14 19:47:27 2002
+++ linux/drivers/input/gameport/emu10k1-gp.c	Sun Nov 17 11:46:25 2002
@@ -84,7 +84,7 @@
 	emu->dev = pdev;
 
 	emu->gameport.io = ioport;
-	emu->gameport.name = pdev->name;
+	emu->gameport.name = pdev->dev.name;
 	emu->gameport.phys = emu->phys;
 	emu->gameport.id.bustype = BUS_PCI;
 	emu->gameport.id.vendor = pdev->vendor;
@@ -95,7 +95,7 @@
 	gameport_register_port(&emu->gameport);
 
 	printk(KERN_INFO "gameport: %s at pci%s speed %d kHz\n",
-		pdev->name, pdev->slot_name, emu->gameport.speed);
+		emu->gameport.name, pdev->slot_name, emu->gameport.speed);
 
 	return 0;
 }

--------------070407050706090908030408--


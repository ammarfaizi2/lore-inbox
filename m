Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130006AbRAKPxQ>; Thu, 11 Jan 2001 10:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132315AbRAKPxG>; Thu, 11 Jan 2001 10:53:06 -0500
Received: from web.sajt.cz ([212.71.160.9]:33803 "EHLO web.sajt.cz")
	by vger.kernel.org with ESMTP id <S132138AbRAKPxE>;
	Thu, 11 Jan 2001 10:53:04 -0500
Date: Thu, 11 Jan 2001 16:47:32 +0100 (CET)
From: Pavel Rabel <pavel@web.sajt.cz>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] dmfe.c cleanup for 2.4.0-pre1
Message-ID: <Pine.LNX.4.21.0101111644330.31464-100000@web.sajt.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/dmfe.c changed slighly in 2.4.0-pre1 and can be cleaned
afterwards.

Pavel Rabel

--- drivers/net/dmfe.c.old	Thu Jan 11 15:42:57 2001
+++ drivers/net/dmfe.c	Thu Jan 11 15:44:06 2001
@@ -1599,12 +1599,10 @@
 	rc = pci_module_init(&dmfe_driver);
 	if (rc < 0)
 		return rc;
-	if (rc >= 0) {
-		printk (KERN_INFO "Davicom DM91xx net driver loaded, version "
-			DMFE_VERSION "\n");
-		return 0;
-	}
-	return -ENODEV;
+
+	printk (KERN_INFO "Davicom DM91xx net driver loaded, version "
+		DMFE_VERSION "\n");
+	return 0;
 }
 
 /*

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129708AbQKNArH>; Mon, 13 Nov 2000 19:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbQKNAq5>; Mon, 13 Nov 2000 19:46:57 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:47620 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129708AbQKNAqu>;
	Mon, 13 Nov 2000 19:46:50 -0500
Date: Tue, 14 Nov 2000 01:16:43 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] tulip oops
Message-ID: <Pine.LNX.4.21.0011140111480.20014-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes tulip/eeprom.c more robust.

/Tobias

--- eeprom.c.orig	Mon Jun 19 22:42:39 2000
+++ eeprom.c	Tue Nov 14 01:19:19 2000
@@ -237,6 +237,7 @@
 			printk(KERN_INFO "%s:  Index #%d - Media %s (#%d) described "
 				   "by a %s (%d) block.\n",
 				   dev->name, i, medianame[leaf->media], leaf->media,
+				   leaf->type >= ARRAY_SIZE(block_name) ? "UNKNOWN" :
 				   block_name[leaf->type], leaf->type);
 		}
 		if (new_advertise)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

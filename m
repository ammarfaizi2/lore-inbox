Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbTEODpb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263785AbTEODTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:19:43 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:16364 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263788AbTEODSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:22 -0400
Date: Thu, 15 May 2003 04:31:08 +0100
Message-Id: <200305150331.h4F3V8fQ000634@deviant.impure.org.uk>
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: iphase fix.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This went into 2.4 nearly a year back with the wonderfully
descriptive  "Fix from maintainer" comment.


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/fc/iph5526.c linux-2.5/drivers/net/fc/iph5526.c
--- bk-linus/drivers/net/fc/iph5526.c	2003-04-22 00:40:43.000000000 +0100
+++ linux-2.5/drivers/net/fc/iph5526.c	2003-04-22 01:23:14.000000000 +0100
@@ -2984,8 +2984,7 @@ static int iph5526_send_packet(struct sk
 	 */
 	if ((type == ETH_P_ARP) || (status == 0))
 		dev_kfree_skb(skb);
-	else
-		netif_wake_queue(dev);
+	netif_wake_queue(dev);
 	LEAVE("iph5526_send_packet");
 	return 0;
 }

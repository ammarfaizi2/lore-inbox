Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVCGWmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVCGWmi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 17:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVCGWlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 17:41:20 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:55286 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261814AbVCGVsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:48:13 -0500
Date: Mon, 7 Mar 2005 13:48:08 -0800
From: Frank Rowand <frowand@mvista.com>
Message-Id: <200503072148.j27Lm8UL006325@localhost.localdomain>
To: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: [PATCH 4/5] ppc RT: ibm_emac_core.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Source: MontaVista Software, Inc.
Signed-off-by: Frank Rowand <frowand@mvista.com>

Index: linux-2.6.10/drivers/net/ibm_emac/ibm_emac_core.c
===================================================================
--- linux-2.6.10.orig/drivers/net/ibm_emac/ibm_emac_core.c
+++ linux-2.6.10/drivers/net/ibm_emac/ibm_emac_core.c
@@ -912,7 +912,6 @@ static int emac_start_xmit(struct sk_buf
 		PKT_DEBUG(("emac_start_xmit() stopping queue\n"));
 		netif_stop_queue(dev);
 		spin_unlock_irqrestore(&fep->lock, flags);
-		restore_flags(flags);
 		return -EBUSY;
 	}
 

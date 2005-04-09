Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVDISDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVDISDv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 14:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVDISDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 14:03:51 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6148 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261361AbVDISDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 14:03:49 -0400
Date: Sat, 9 Apr 2005 20:03:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       "James P. Ketrenos" <ipw2100-admin@linux.intel.com>, netdev@oss.sgi.com,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: [-mm patch] net/ieee80211/ieee80211_tx.c: swapped memset arguments
Message-ID: <20050409180348.GC3632@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix swapped memset() arguments in  net/ieee80211/ieee80211_tx.c  
found by Maciej Soltysiak.

Patch by Jesper Juhl.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Jesper Juhl on:
- 3 Apr 2005

--- linux-2.6.12-rc1-mm4-orig/net/ieee80211/ieee80211_tx.c	2005-03-31 21:20:08.000000000 +0200
+++ linux-2.6.12-rc1-mm4/net/ieee80211/ieee80211_tx.c	2005-04-03 00:34:22.000000000 +0200
@@ -223,7 +223,7 @@ struct ieee80211_txb *ieee80211_alloc_tx
 	if (!txb)
 		return NULL;
 
-	memset(txb, sizeof(struct ieee80211_txb), 0);
+	memset(txb, 0, sizeof(struct ieee80211_txb));
 	txb->nr_frags = nr_frags;
 	txb->frag_size = txb_size;
 



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbVHYAXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbVHYAXN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 20:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVHYAXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 20:23:13 -0400
Received: from mail-red.bigfish.com ([216.148.222.61]:45691 "EHLO
	mail2-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932416AbVHYAXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 20:23:12 -0400
X-BigFish: V
Message-ID: <430D0F6F.1030903@am.sony.com>
Date: Wed, 24 Aug 2005 17:23:11 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davem@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] fix minor bug in sungem.h
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This changes the Sun Gem Ether driver's tx ring buffer 
length to the proper constant.  Currently TX_RING_SIZE 
and RX_RING_SIZE are equal, so no malfunction occurs.


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

--- a/drivers/net/sungem.h	2005-08-19 14:35:50.000000000 -0700
+++ b/drivers/net/sungem.h	2005-08-24 17:14:18.000000000 -0700
@@ -1020,7 +1020,7 @@
 		
 	struct gem_init_block	*init_block;
 	struct sk_buff		*rx_skbs[RX_RING_SIZE];
-	struct sk_buff		*tx_skbs[RX_RING_SIZE];
+	struct sk_buff		*tx_skbs[TX_RING_SIZE];
 	dma_addr_t		gblock_dvma;
 
 	struct pci_dev		*pdev;


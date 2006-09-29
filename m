Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWI2XPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWI2XPS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 19:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWI2XPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 19:15:18 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:54493 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750862AbWI2XPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 19:15:16 -0400
Date: Fri, 29 Sep 2006 18:15:11 -0500
To: jeff@garzik.org, akpm@osdl.org
Cc: netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 1/6]: powerpc/cell spidernet burst alignment patch.
Message-ID: <20060929231511.GI6433@austin.ibm.com>
References: <20060929230552.GG6433@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929230552.GG6433@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch increases the Burst Address alignment from 64 to 1024 in the
Spidernet driver. This improves transmit performance for large packets.

From: James K Lewis <jklewis@us.ibm.com>
Signed-off-by: James K Lewis <jklewis@us.ibm.com>
Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.h
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.h	2006-09-29 14:11:21.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.h	2006-09-29 16:33:49.000000000 -0500
@@ -209,7 +209,7 @@ extern char spider_net_driver_name[];
 #define SPIDER_NET_DMA_RX_FEND_VALUE	0x00030003
 /* to set TX_DMA_EN */
 #define SPIDER_NET_TX_DMA_EN		0x80000000
-#define SPIDER_NET_GDTDCEIDIS		0x00000002
+#define SPIDER_NET_GDTDCEIDIS		0x00000302
 #define SPIDER_NET_DMA_TX_VALUE		SPIDER_NET_TX_DMA_EN | \
 					SPIDER_NET_GDTDCEIDIS
 #define SPIDER_NET_DMA_TX_FEND_VALUE	0x00030003

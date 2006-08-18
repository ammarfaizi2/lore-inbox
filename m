Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbWHRWUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWHRWUm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbWHRWUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:20:42 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:32454 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751522AbWHRWUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:20:41 -0400
Date: Fri, 18 Aug 2006 17:20:38 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, ens Osterkamp <Jens.Osterkamp@de.ibm.com>
Subject: [PATCH 1/6]: powerpc/cell spidernet burst alignment patch
Message-ID: <20060818222038.GH26889@austin.ibm.com>
References: <20060818220700.GG26889@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060818220700.GG26889@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch increases the Burst Address alignment from 64 to 1024 in the
Spidernet driver. This improves transmit performance for arge packets
from about 100Mbps to 300-400Mbps.

From: James K Lewis <jklewis@us.ibm.com>
Signed-off-by: James K Lewis <jklewis@us.ibm.com>
Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Utz Bacher <utz.bacher@de.ibm.com>
Cc: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-rc3-mm2/drivers/net/spider_net.h
===================================================================
--- linux-2.6.18-rc3-mm2.orig/drivers/net/spider_net.h	2006-08-07 14:37:10.000000000 -0500
+++ linux-2.6.18-rc3-mm2/drivers/net/spider_net.h	2006-08-11 11:09:57.000000000 -0500
@@ -209,7 +209,7 @@ extern char spider_net_driver_name[];
 #define SPIDER_NET_DMA_RX_FEND_VALUE	0x00030003
 /* to set TX_DMA_EN */
 #define SPIDER_NET_TX_DMA_EN		0x80000000
-#define SPIDER_NET_GDTDCEIDIS		0x00000002
+#define SPIDER_NET_GDTDCEIDIS		0x00000302
 #define SPIDER_NET_DMA_TX_VALUE		SPIDER_NET_TX_DMA_EN | \
 					SPIDER_NET_GDTDCEIDIS
 #define SPIDER_NET_DMA_TX_FEND_VALUE	0x00030003

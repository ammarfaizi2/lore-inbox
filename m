Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWHKRGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWHKRGd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 13:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWHKRGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 13:06:33 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:11475 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751196AbWHKRGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 13:06:32 -0400
Date: Fri, 11 Aug 2006 12:06:30 -0500
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Cc: James K Lewis <jklewis@us.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
       Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
Subject: [PATCH 1/4]: powerpc/cell spidernet burst alignment patch.
Message-ID: <20060811170630.GI10638@austin.ibm.com>
References: <20060811170337.GH10638@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060811170337.GH10638@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch increases the Burst Address alignment from 64 to 1024 in the
Spidernet driver. This improves transmit performance for large packets
from about 100Mbps to 300-400Mbps.

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

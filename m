Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWILIzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWILIzm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 04:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWILIzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 04:55:41 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:34032 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751406AbWILIzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 04:55:40 -0400
Subject: [patch 1/3]  Add tsi108 on Chip Ethernet device driver support
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Andrew Morton <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1157962200.10526.10.camel@localhost.localdomain>
References: <A0CDBA58F226D911B202000BDBAD46730A1B1410@zch01exm23.fsl.freescale.net>
	 <1157962200.10526.10.camel@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1158051327.14448.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Sep 2006 16:55:27 +0800
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2006 08:55:37.0362 (UTC) FILETIME=[37320720:01C6D649]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Kconfig and Makefile

Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com> 

---
 drivers/net/Kconfig      |    8 
 drivers/net/Makefile     |    1 
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index a2bd811..eb17060 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2221,6 +2221,14 @@ config SPIDER_NET
 	  This driver supports the Gigabit Ethernet chips present on the
 	  Cell Processor-Based Blades from IBM.
 
+config TSI108_ETH
+	   tristate "Tundra TSI108 gigabit Ethernet support"
+	   depends on TSI108_BRIDGE
+	   help
+	     This driver supports Tundra TSI108 gigabit Ethernet ports.
+	     To compile this driver as a module, choose M here: the module
+	     will be called tsi108_eth.
+
 config GIANFAR
 	tristate "Gianfar Ethernet"
 	depends on 85xx || 83xx || PPC_86xx
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 8427bf9..da199e7 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -112,6 +112,7 @@ obj-$(CONFIG_B44) += b44.o
 obj-$(CONFIG_FORCEDETH) += forcedeth.o
 obj-$(CONFIG_NE_H8300) += ne-h8300.o 8390.o
 
+obj-$(CONFIG_TSI108_ETH) += tsi108_eth.o
 obj-$(CONFIG_MV643XX_ETH) += mv643xx_eth.o
 
 obj-$(CONFIG_PPP) += ppp_generic.o slhc.o




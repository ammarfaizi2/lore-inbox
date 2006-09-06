Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWIFOVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWIFOVE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWIFOVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:21:03 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:9787 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751143AbWIFOU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:20:59 -0400
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [2.6.19 PATCH 7/7] ehea: Makefile & Kconfig
Date: Wed, 6 Sep 2006 15:38:34 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
To: netdev <netdev@vger.kernel.org>
Cc: Christoph Raisch <raisch@de.ibm.com>,
       "Jan-Bernd Themann" <themann@de.ibm.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-ppc" <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200609061538.34319.ossthema@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com> 


 drivers/net/Kconfig  |    9 +++++++++
 drivers/net/Makefile |    1 +
 2 files changed, 10 insertions(+)



diff -Nurp -X dontdiff linux-2.6.18-rc6/drivers/net/Kconfig patched_kernel/drivers/net/Kconfig
--- linux-2.6.18-rc6/drivers/net/Kconfig	2006-09-04 04:19:48.000000000 +0200
+++ patched_kernel/drivers/net/Kconfig	2006-09-04 11:38:59.000000000 +0200
@@ -2318,6 +2318,15 @@ config CHELSIO_T1
           To compile this driver as a module, choose M here: the module
           will be called cxgb.
 
+config EHEA
+	tristate "eHEA Ethernet support"
+	depends on IBMEBUS
+	---help---
+	  This driver supports the IBM pSeries eHEA ethernet adapter.
+
+	  To compile the driver as a module, choose M here. The module
+	  will be called ehea.
+
 config IXGB
 	tristate "Intel(R) PRO/10GbE support"
 	depends on PCI
diff -Nurp -X dontdiff linux-2.6.18-rc6/drivers/net/Makefile patched_kernel/drivers/net/Makefile
--- linux-2.6.18-rc6/drivers/net/Makefile	2006-09-04 04:19:48.000000000 +0200
+++ patched_kernel/drivers/net/Makefile	2006-09-04 11:39:06.000000000 +0200
@@ -10,6 +10,7 @@ obj-$(CONFIG_E1000) += e1000/
 obj-$(CONFIG_IBM_EMAC) += ibm_emac/
 obj-$(CONFIG_IXGB) += ixgb/
 obj-$(CONFIG_CHELSIO_T1) += chelsio/
+obj-$(CONFIG_EHEA) += ehea/
 obj-$(CONFIG_BONDING) += bonding/
 obj-$(CONFIG_GIANFAR) += gianfar_driver.o
 

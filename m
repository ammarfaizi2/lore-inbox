Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWHVNhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWHVNhh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 09:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWHVNhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 09:37:36 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:15564 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932233AbWHVNhe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 09:37:34 -0400
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [2.6.19 PATCH 7/7] ehea: Makefile & Kconfig
Date: Tue, 22 Aug 2006 14:57:26 +0200
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
Message-Id: <200608221457.26681.ossthema@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com> 


 drivers/net/Kconfig  |    9 +++++++++
 drivers/net/Makefile |    1 +
 2 files changed, 10 insertions(+)



diff -Nurp -X dontdiff linux-2.6.18-rc4-git1/drivers/net/Kconfig patched_kernel/drivers/net/Kconfig
--- linux-2.6.18-rc4-git1/drivers/net/Kconfig	2006-08-06 11:20:11.000000000 -0700
+++ patched_kernel/drivers/net/Kconfig	2006-08-22 06:00:49.545435280 -0700
@@ -2277,6 +2277,15 @@ config CHELSIO_T1
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
diff -Nurp -X dontdiff linux-2.6.18-rc4-git1/drivers/net/Makefile patched_kernel/drivers/net/Makefile
--- linux-2.6.18-rc4-git1/drivers/net/Makefile	2006-08-06 11:20:11.000000000 -0700
+++ patched_kernel/drivers/net/Makefile	2006-08-22 05:53:59.254861851 -0700
@@ -10,6 +10,7 @@ obj-$(CONFIG_E1000) += e1000/
 obj-$(CONFIG_IBM_EMAC) += ibm_emac/
 obj-$(CONFIG_IXGB) += ixgb/
 obj-$(CONFIG_CHELSIO_T1) += chelsio/
+obj-$(CONFIG_EHEA) += ehea/
 obj-$(CONFIG_BONDING) += bonding/
 obj-$(CONFIG_GIANFAR) += gianfar_driver.o
 

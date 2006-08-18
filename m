Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030347AbWHRMRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbWHRMRQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWHRMRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:17:16 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:14470 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030347AbWHRMRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:17:14 -0400
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [2.6.19 PATCH 7/7] ehea: Makefile & Kconfig
Date: Fri, 18 Aug 2006 13:37:44 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
To: netdev <netdev@vger.kernel.org>
Cc: Christoph Raisch <raisch@de.ibm.com>,
       "Jan-Bernd Themann" <themann@de.ibm.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-ppc" <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>, Thomas Klein <tklein@de.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200608181337.44153.ossthema@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com> 


 drivers/net/Kconfig  |    6 ++++++
 drivers/net/Makefile |    1 +
 2 files changed, 7 insertions(+)



diff -Nurp -X dontdiff linux-2.6.18-rc4/drivers/net/Kconfig patched_kernel/drivers/net/Kconfig
--- linux-2.6.18-rc4/drivers/net/Kconfig	2006-08-06 11:20:11.000000000 -0700
+++ patched_kernel/drivers/net/Kconfig	2006-08-08 03:00:49.526421944 -0700
@@ -2277,6 +2277,12 @@ config CHELSIO_T1
           To compile this driver as a module, choose M here: the module
           will be called cxgb.
 
+config EHEA
+        tristate "eHEA Ethernet support"
+        depends on IBMEBUS
+        ---help---
+          This driver supports the IBM pSeries ethernet adapter
+
 config IXGB
 	tristate "Intel(R) PRO/10GbE support"
 	depends on PCI
diff -Nurp -X dontdiff linux-2.6.18-rc4/drivers/net/Makefile patched_kernel/drivers/net/Makefile
--- linux-2.6.18-rc4/drivers/net/Makefile	2006-08-06 11:20:11.000000000 -0700
+++ patched_kernel/drivers/net/Makefile	2006-08-08 03:00:30.061451584 -0700
@@ -10,6 +10,7 @@ obj-$(CONFIG_E1000) += e1000/
 obj-$(CONFIG_IBM_EMAC) += ibm_emac/
 obj-$(CONFIG_IXGB) += ixgb/
 obj-$(CONFIG_CHELSIO_T1) += chelsio/
+obj-$(CONFIG_EHEA) += ehea/
 obj-$(CONFIG_BONDING) += bonding/
 obj-$(CONFIG_GIANFAR) += gianfar_driver.o
 

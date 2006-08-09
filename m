Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030470AbWHIIkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbWHIIkz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 04:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030584AbWHIIky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 04:40:54 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:59077 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030581AbWHIIkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 04:40:52 -0400
Message-ID: <44D99F92.60407@de.ibm.com>
Date: Wed, 09 Aug 2006 10:40:50 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: netdev <netdev@vger.kernel.org>
CC: linux-ppc <linuxppc-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: [PATCH 6/6] ehea: Kernel build (Kconfig / Makefile)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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




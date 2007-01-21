Return-Path: <linux-kernel-owner+w=401wt.eu-S1751623AbXAUVF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbXAUVF3 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 16:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbXAUVF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 16:05:29 -0500
Received: from imf16aec.mail.bellsouth.net ([205.152.59.64]:36552 "EHLO
	imf16aec.mail.bellsouth.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751622AbXAUVF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 16:05:27 -0500
Date: Sun, 21 Jan 2007 15:05:23 -0600
From: Jay Cliburn <jacliburn@bellsouth.net>
To: jeff@garzik.org
Cc: shemminger@osdl.org, csnook@redhat.com, hch@infradead.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       atl1-devel@lists.sourceforge.net
Subject: [PATCH 1/4] atl1: Build files for Attansic L1 driver
Message-ID: <20070121210523.GB2702@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jay Cliburn <jacliburn@bellsouth.net>
From: Chris Snook <csnook@redhat.com>

This patch contains the build files for the Attansic L1 gigabit ethernet
adapter driver.

Signed-off-by: Jay Cliburn <jacliburn@bellsouth.net>
Signed-off-by: Chris Snook <csnook@redhat.com>
---

 Kconfig       |   11 +++++++++++
 Makefile      |    1 +
 atl1/Makefile |    2 ++
 3 files changed, 14 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 8aa8dd0..0bb3c1e 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2348,6 +2348,17 @@ config QLA3XXX
 	  To compile this driver as a module, choose M here: the module
 	  will be called qla3xxx.
 
+config ATL1
+	tristate "Attansic L1 Gigabit Ethernet support (EXPERIMENTAL)"
+	depends on NET_PCI && PCI && EXPERIMENTAL
+	select CRC32
+	select MII
+	help
+	  This driver supports the Attansic L1 gigabit ethernet adapter.
+
+	  To compile this driver as a module, choose M here.  The module
+	  will be called atl1.
+
 endmenu
 
 #
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 4c0d4e5..d0beced 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_IXGB) += ixgb/
 obj-$(CONFIG_CHELSIO_T1) += chelsio/
 obj-$(CONFIG_EHEA) += ehea/
 obj-$(CONFIG_BONDING) += bonding/
+obj-$(CONFIG_ATL1) += atl1/
 obj-$(CONFIG_GIANFAR) += gianfar_driver.o
 
 gianfar_driver-objs := gianfar.o \
diff --git a/drivers/net/atl1/Makefile b/drivers/net/atl1/Makefile
new file mode 100644
index 0000000..a6b707e
--- /dev/null
+++ b/drivers/net/atl1/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_ATL1)	+= atl1.o
+atl1-y			+= atl1_main.o atl1_hw.o atl1_ethtool.o atl1_param.o

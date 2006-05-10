Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbWEJVoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWEJVoI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 17:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbWEJVoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 17:44:08 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:8633 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S964997AbWEJVoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 17:44:06 -0400
Message-ID: <44625E9B.3090509@myri.com>
Date: Wed, 10 May 2006 23:43:55 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: netdev@vger.kernel.org, Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       "Andrew J. Gallatin" <gallatin@myri.com>
Subject: [PATCH 6/6] myri10ge - Kconfig and Makefile
References: <446259A0.8050504@myri.com>
In-Reply-To: <446259A0.8050504@myri.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 6/6] myri10ge - Kconfig and Makefile

Add Kconfig and Makefile support for the myri10ge driver.

Signed-off-by: Brice Goglin <brice@myri.com>
Signed-off-by: Andrew J. Gallatin <gallatin@myri.com>

 Kconfig           |   16 ++++++++++++++++
 Makefile          |    1 +
 myri10ge/Makefile |    5 +++++
 3 files changed, 22 insertions(+)

--- linux-mm/drivers/net/Kconfig.old	2006-04-10 03:44:01.000000000 -0700
+++ linux-mm/drivers/net/Kconfig	2006-04-18 03:49:11.000000000 -0700
@@ -2327,6 +2327,23 @@ config S2IO_NAPI
 
 	  If in doubt, say N.
 
+config MYRI10GE
+	tristate "Myricom Myri-10G Ethernet support"
+	depends on PCI
+	select FW_LOADER
+	select CRC32
+	---help---
+	  This driver supports Myricom Myri-10G Dual Protocol interface in
+	  Ethernet mode. If the eeprom on your board is not recent enough,
+	  you will need a newer firmware image.
+	  You may get this image or more information, at:
+
+	  <http://www.myri.com/Myri-10G/>
+
+	  To compile this driver as a module, choose M here and read
+	  <file:Documentation/networking/net-modules.txt>.  The module
+	  will be called myri10ge.
+
 endmenu
 
 source "drivers/net/tokenring/Kconfig"
--- linux-mm/drivers/net/Makefile.old	2006-04-08 04:49:53.000000000 -0700
+++ linux-mm/drivers/net/Makefile	2006-04-21 08:10:27.000000000 -0700
@@ -192,6 +192,7 @@ obj-$(CONFIG_R8169) += r8169.o
 obj-$(CONFIG_AMD8111_ETH) += amd8111e.o
 obj-$(CONFIG_IBMVETH) += ibmveth.o
 obj-$(CONFIG_S2IO) += s2io.o
+obj-$(CONFIG_MYRI10GE) += myri10ge/
 obj-$(CONFIG_SMC91X) += smc91x.o
 obj-$(CONFIG_SMC911X) += smc911x.o
 obj-$(CONFIG_DM9000) += dm9000.o
--- /dev/null	2006-04-21 00:45:09.064430000 -0700
+++ linux-mm/drivers/net/myri10ge/Makefile	2006-04-21 08:14:21.000000000 -0700
@@ -0,0 +1,5 @@
+#
+# Makefile for the Myricom Myri-10G ethernet driver
+#
+
+obj-$(CONFIG_MYRI10GE) += myri10ge.o



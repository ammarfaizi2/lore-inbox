Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266860AbUAXC3M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 21:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266858AbUAXC2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 21:28:50 -0500
Received: from palrel13.hp.com ([156.153.255.238]:64714 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S266854AbUAXCZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 21:25:47 -0500
Date: Fri, 23 Jan 2004 18:25:45 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] 11/11: Kconfig/Makefile changes for #5-10
Message-ID: <20040124022545.GL22410@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir262_dongles-11_makefile-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<apply after all other patches>
		<Patch from Martin Diehl>
* include build information for new dongle drivers (5->10)


diff -u -p linux/drivers/net/irda.d6/Kconfig  linux/drivers/net/irda/Kconfig
--- linux/drivers/net/irda.d6/Kconfig	Wed Dec 17 18:59:16 2003
+++ linux/drivers/net/irda/Kconfig	Thu Jan 22 16:43:56 2004
@@ -65,6 +65,75 @@ config TEKRAM_DONGLE
 	  dongles you will have to start irattach like this:
 	  "irattach -d tekram".
 
+config LITELINK_DONGLE
+	tristate "Parallax LiteLink dongle"
+	depends on DONGLE && IRDA
+	help
+	  Say Y here if you want to build support for the Parallax Litelink
+	  dongle.  To compile it as a module, choose M here.  The Parallax
+	  dongle attaches to the normal 9-pin serial port connector, and can
+	  currently only be used by IrTTY.  To activate support for Parallax
+	  dongles you will have to start irattach like this:
+	  "irattach -d litelink".
+
+config MA600_DONGLE
+	tristate "Mobile Action MA600 dongle"
+	depends on DONGLE && IRDA && EXPERIMENTAL
+	help
+	  Say Y here if you want to build support for the Mobile Action MA600
+	  dongle.  To compile it as a module, choose M here. The MA600 dongle
+	  attaches to the normal 9-pin serial port connector, and can
+	  currently only be used by IrTTY.  The driver should also support
+	  the MA620 USB version of the dongle, if the integrated USB-to-RS232
+	  converter is supported by usbserial. To activate support for
+	  MA600 dongle you will have to start irattach like this:
+	  "irattach -d ma600".
+
+config GIRBIL_DONGLE
+	tristate "Greenwich GIrBIL dongle"
+	depends on DONGLE && IRDA && EXPERIMENTAL
+	help
+	  Say Y here if you want to build support for the Greenwich GIrBIL
+	  dongle.  If you want to compile it as a module, choose M here.
+	  The Greenwich dongle attaches to the normal 9-pin serial port
+	  connector, and can currently only be used by IrTTY.  To activate
+	  support for Greenwich dongles you will have to start irattach
+	  like this: "irattach -d girbil".
+
+config MCP2120_DONGLE
+	tristate "Microchip MCP2120"
+	depends on DONGLE && IRDA && EXPERIMENTAL
+	help
+	  Say Y here if you want to build support for the Microchip MCP2120
+	  dongle.  If you want to compile it as a module, choose M here.
+	  The MCP2120 dongle attaches to the normal 9-pin serial port
+	  connector, and can currently only be used by IrTTY.  To activate
+	  support for MCP2120 dongles you will have to start irattach
+	  like this: "irattach -d mcp2120".
+
+	  You must build this dongle yourself.  For more information see:
+	  <http://www.eyetap.org/~tangf/irda_sir_linux.html>
+
+config OLD_BELKIN_DONGLE
+	tristate "Old Belkin dongle"
+	depends on DONGLE && IRDA && EXPERIMENTAL
+	help
+	  Say Y here if you want to build support for the Adaptec Airport 1000
+	  and 2000 dongles.  If you want to compile it as a module, choose
+	  M here. Some information is contained in the comments
+	  at the top of <file:drivers/net/irda/old_belkin.c>.
+
+config ACT200L_DONGLE
+	tristate "ACTiSYS IR-200L dongle"
+	depends on DONGLE && IRDA && EXPERIMENTAL
+	help
+	  Say Y here if you want to build support for the ACTiSYS IR-200L
+	  dongle. If you want to compile it as a module, choose M here.
+	  The ACTiSYS IR-200L dongle attaches to the normal 9-pin serial
+	  port connector, and can currently only be used by IrTTY.
+	  To activate support for ACTiSYS IR-200L dongle you will have to
+	  start irattach like this: "irattach -d act200l".
+
 comment "Old SIR device drivers"
 
 config IRPORT_SIR
@@ -130,7 +199,7 @@ config TEKRAM_DONGLE_OLD
 	  dongles you will have to start irattach like this:
 	  "irattach -d tekram".
 
-config GIRBIL_DONGLE
+config GIRBIL_DONGLE_OLD
 	tristate "Greenwich GIrBIL dongle"
 	depends on DONGLE_OLD && IRDA
 	help
@@ -141,7 +210,7 @@ config GIRBIL_DONGLE
 	  dongles you will have to insert "irattach -d girbil" in the
 	  /etc/irda/drivers script.
 
-config LITELINK_DONGLE
+config LITELINK_DONGLE_OLD
 	tristate "Parallax LiteLink dongle"
 	depends on DONGLE_OLD && IRDA
 	help
@@ -152,7 +221,7 @@ config LITELINK_DONGLE
 	  dongles you will have to start irattach like this:
 	  "irattach -d litelink".
 
-config MCP2120_DONGLE
+config MCP2120_DONGLE_OLD
 	tristate "Microchip MCP2120"
 	depends on DONGLE_OLD && IRDA
 	help
@@ -166,7 +235,7 @@ config MCP2120_DONGLE
 	  You must build this dongle yourself.  For more information see:
 	  <http://www.eyetap.org/~tangf/irda_sir_linux.html>
 
-config OLD_BELKIN_DONGLE
+config OLD_BELKIN_DONGLE_OLD
 	tristate "Old Belkin dongle"
 	depends on DONGLE_OLD && IRDA
 	help
@@ -175,11 +244,7 @@ config OLD_BELKIN_DONGLE
 	  will be called old_belkin.  Some information is contained in the
 	  comments at the top of <file:drivers/net/irda/old_belkin.c>.
 
-config EP7211_IR
-	tristate "EP7211 I/R support"
-	depends on DONGLE_OLD && ARCH_EP7211 && IRDA
-
-config ACT200L_DONGLE
+config ACT200L_DONGLE_OLD
 	tristate "ACTiSYS IR-200L dongle (EXPERIMENTAL)"
 	depends on DONGLE_OLD && EXPERIMENTAL && IRDA
 	help
@@ -190,7 +255,7 @@ config ACT200L_DONGLE
 	  ACTiSYS IR-200L dongles you will have to start irattach like this:
 	  "irattach -d act200l".
 
-config MA600_DONGLE
+config MA600_DONGLE_OLD
 	tristate "Mobile Action MA600 dongle (EXPERIMENTAL)"
 	depends on DONGLE_OLD && EXPERIMENTAL && IRDA
 	---help---
@@ -205,6 +270,10 @@ config MA600_DONGLE
 
 	  There is a pre-compiled module on
 	  <http://engsvr.ust.hk/~eetwl95/download/ma600-2.4.x.tar.gz>
+
+config EP7211_IR
+	tristate "EP7211 I/R support"
+	depends on DONGLE_OLD && ARCH_EP7211 && IRDA
 
 comment "FIR device drivers"
 
diff -u -p linux/drivers/net/irda.d6/Makefile  linux/drivers/net/irda/Makefile
--- linux/drivers/net/irda.d6/Makefile	Wed Dec 17 18:58:48 2003
+++ linux/drivers/net/irda/Makefile	Thu Jan 22 16:43:56 2004
@@ -21,20 +21,26 @@ obj-$(CONFIG_VIA_FIR)		+= via-ircc.o
 obj-$(CONFIG_ESI_DONGLE_OLD)		+= esi.o
 obj-$(CONFIG_TEKRAM_DONGLE_OLD)	+= tekram.o
 obj-$(CONFIG_ACTISYS_DONGLE_OLD)	+= actisys.o
-obj-$(CONFIG_GIRBIL_DONGLE)	+= girbil.o
-obj-$(CONFIG_LITELINK_DONGLE)	+= litelink.o
-obj-$(CONFIG_OLD_BELKIN_DONGLE)	+= old_belkin.o
+obj-$(CONFIG_GIRBIL_DONGLE_OLD)	+= girbil.o
+obj-$(CONFIG_LITELINK_DONGLE_OLD)	+= litelink.o
+obj-$(CONFIG_OLD_BELKIN_DONGLE_OLD)	+= old_belkin.o
+obj-$(CONFIG_MCP2120_DONGLE_OLD)	+= mcp2120.o
+obj-$(CONFIG_ACT200L_DONGLE_OLD)	+= act200l.o
+obj-$(CONFIG_MA600_DONGLE_OLD)	+= ma600.o
 obj-$(CONFIG_EP7211_IR)		+= ep7211_ir.o
-obj-$(CONFIG_MCP2120_DONGLE)	+= mcp2120.o
 obj-$(CONFIG_AU1000_FIR)	+= au1k_ir.o
-obj-$(CONFIG_ACT200L_DONGLE)	+= act200l.o
-obj-$(CONFIG_MA600_DONGLE)	+= ma600.o
 # New SIR drivers
 obj-$(CONFIG_IRTTY_SIR)		+= irtty-sir.o	sir-dev.o
 # New dongles drivers for new SIR drivers
 obj-$(CONFIG_ESI_DONGLE)	+= esi-sir.o
 obj-$(CONFIG_TEKRAM_DONGLE)	+= tekram-sir.o
 obj-$(CONFIG_ACTISYS_DONGLE)	+= actisys-sir.o
+obj-$(CONFIG_LITELINK_DONGLE)	+= litelink-sir.o
+obj-$(CONFIG_GIRBIL_DONGLE)	+= girbil-sir.o
+obj-$(CONFIG_OLD_BELKIN_DONGLE)	+= old_belkin-sir.o
+obj-$(CONFIG_MCP2120_DONGLE)	+= mcp2120-sir.o
+obj-$(CONFIG_ACT200L_DONGLE)	+= act200l-sir.o
+obj-$(CONFIG_MA600_DONGLE)	+= ma600-sir.o
 
 # The SIR helper module
 sir-dev-objs := sir_core.o sir_dev.o sir_dongle.o sir_kthread.o

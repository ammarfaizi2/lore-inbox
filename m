Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269374AbUI3R5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269374AbUI3R5p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 13:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269389AbUI3R5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 13:57:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21200 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269374AbUI3R4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 13:56:22 -0400
Date: Thu, 30 Sep 2004 13:56:05 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: PATCH: resend: VIA Velocity belongs under gigabit ethernet
Message-ID: <20040930175605.GA1472@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc3/drivers/net/Kconfig linux-2.6.9rc3/drivers/net/Kconfig
--- linux.vanilla-2.6.9rc3/drivers/net/Kconfig	2004-09-30 16:13:08.969321872 +0100
+++ linux-2.6.9rc3/drivers/net/Kconfig	2004-09-30 16:35:00.637917936 +0100
@@ -1742,18 +1742,6 @@
 
 	  If unsure, say Y.
 
-config VIA_VELOCITY
-	tristate "VIA Velocity support"
-	depends on NET_PCI && PCI
-	select CRC32
-	select CRC_CCITT
-	select MII
-	help
-	  If you have a VIA "Velocity" based network card say Y here.
-
-	  To compile this driver as a module, choose M here. The module
-	  will be called via-velocity.
-
 config LAN_SAA9730
 	bool "Philips SAA9730 Ethernet support (EXPERIMENTAL)"
 	depends on NET_PCI && EXPERIMENTAL && MIPS
@@ -2140,6 +2128,18 @@
 	  say M here and read Documentation/kbuild/modules.txt. The module will
 	  be called sk98lin. This is recommended.
 
+config VIA_VELOCITY
+	tristate "VIA Velocity support"
+	depends on NET_PCI && PCI
+	select CRC32
+	select CRC_CCITT
+	select MII
+	help
+	  If you have a VIA "Velocity" based network card say Y here.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called via-velocity.
+
 config TIGON3
 	tristate "Broadcom Tigon3 support"
 	depends on PCI

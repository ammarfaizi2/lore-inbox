Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266347AbUHODAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266347AbUHODAo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 23:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUHODAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 23:00:35 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:39931 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266141AbUHODAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 23:00:25 -0400
Date: Sat, 14 Aug 2004 23:04:23 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6] Move Sungem to gige menu
Message-ID: <Pine.LNX.4.58.0408141412550.22077@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move Sun GEM driver option to the gigabit ethernet section.

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.8/drivers/net/Kconfig
===================================================================
RCS file: /home/cvsroot/linux-2.6.8/drivers/net/Kconfig,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Kconfig
--- linux-2.6.8/drivers/net/Kconfig	14 Aug 2004 17:53:39 -0000	1.1.1.1
+++ linux-2.6.8/drivers/net/Kconfig	14 Aug 2004 18:12:05 -0000
@@ -562,14 +562,6 @@ config SUNQE
 	  To compile this driver as a module, choose M here: the module
 	  will be called sunqe.

-config SUNGEM
-	tristate "Sun GEM support"
-	depends on NET_ETHERNET && PCI
-	select CRC32
-	help
-	  Support for the Sun GEM chip, aka Sun GigabitEthernet/P 2.0.  See also
-	  <http://www.sun.com/products-n-solutions/hardware/docs/pdf/806-3985-10.pdf>.
-
 config NET_VENDOR_3COM
 	bool "3COM cards"
 	depends on NET_ETHERNET && (ISA || EISA || MCA || PCI)
@@ -2131,6 +2123,13 @@ config TIGON3
 	  To compile this driver as a module, choose M here: the module
 	  will be called tg3.  This is recommended.

+config SUNGEM
+	tristate "Sun GEM support"
+	depends on NET_ETHERNET && PCI
+	select CRC32
+	help
+	  Support for the Sun GEM chip, aka Sun GigabitEthernet/P 2.0.  See also
+	  <http://www.sun.com/products-n-solutions/hardware/docs/pdf/806-3985-10.pdf>.
 endmenu

 #

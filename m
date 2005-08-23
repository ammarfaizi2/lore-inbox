Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbVHWVn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbVHWVn5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbVHWVns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:43:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4534 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932426AbVHWVnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:43:33 -0400
To: torvalds@osdl.org
Subject: [PATCH] (22/43) Kconfig fix (ppc 4xx and early serial)
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Message-Id: <E1E7gbM-0007By-RK@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:46:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a bunch of ppc 4xx variants unconditionally calls early_serial_setup() and
therefore needs SERIAL_8250

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-mv64360-irq/arch/ppc/platforms/4xx/Kconfig RC13-rc6-git13-4xx-early-serial/arch/ppc/platforms/4xx/Kconfig
--- RC13-rc6-git13-mv64360-irq/arch/ppc/platforms/4xx/Kconfig	2005-08-10 10:37:46.000000000 -0400
+++ RC13-rc6-git13-4xx-early-serial/arch/ppc/platforms/4xx/Kconfig	2005-08-21 13:17:05.000000000 -0400
@@ -3,6 +3,11 @@
 	depends on 40x || 44x
 	default y
 
+config WANT_EARLY_SERIAL
+	bool
+	select SERIAL_8250
+	default n
+
 menu "IBM 4xx options"
 	depends on 4xx
 
@@ -18,6 +23,7 @@
 
 config BUBINGA
 	bool "Bubinga"
+	select WANT_EARLY_SERIAL
 	help
 	  This option enables support for the IBM 405EP evaluation board.
 
@@ -70,21 +76,25 @@
 
 config BAMBOO
 	bool "Bamboo"
+	select WANT_EARLY_SERIAL
 	help
 	  This option enables support for the IBM PPC440EP evaluation board.
 
 config EBONY
 	bool "Ebony"
+	select WANT_EARLY_SERIAL
 	help
 	  This option enables support for the IBM PPC440GP evaluation board.
 
 config LUAN
 	bool "Luan"
+	select WANT_EARLY_SERIAL
 	help
 	  This option enables support for the IBM PPC440SP evaluation board.
 
 config OCOTEA
 	bool "Ocotea"
+	select WANT_EARLY_SERIAL
 	help
 	  This option enables support for the IBM PPC440GX evaluation board.
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbVHWVnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbVHWVnB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbVHWVmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:42:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55477 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932407AbVHWVmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:42:22 -0400
To: torvalds@osdl.org
Subject: [PATCH] (8/43) Kconfig fix (PMAC_BACKLIGHT on ppc64)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gaE-00079G-78@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:45:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PMAC_BACKLIGHT is broken on ppc64; marked as such

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-ppc64-isdn/drivers/macintosh/Kconfig RC13-rc6-git13-ppc64-backlight/drivers/macintosh/Kconfig
--- RC13-rc6-git13-ppc64-isdn/drivers/macintosh/Kconfig	2005-08-10 10:37:49.000000000 -0400
+++ RC13-rc6-git13-ppc64-backlight/drivers/macintosh/Kconfig	2005-08-21 13:16:51.000000000 -0400
@@ -103,7 +103,7 @@
 # on non-powerbook machines (but only on PMU based ones AFAIK)
 config PMAC_BACKLIGHT
 	bool "Backlight control for LCD screens"
-	depends on ADB_PMU
+	depends on ADB_PMU && (BROKEN || !PPC64)
 	help
 	  Say Y here to build in code to manage the LCD backlight on a
 	  Macintosh PowerBook.  With this code, the backlight will be turned

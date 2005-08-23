Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbVHWV4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVHWV4r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVHWVmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:42:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50101 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932407AbVHWVl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:41:57 -0400
To: torvalds@osdl.org
Subject: [PATCH] (3/43) Kconfig fix (epca on 64bit)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gZp-00078R-1G@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:45:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

epca is broken on 64bit; marked as such

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-rio/drivers/char/Kconfig RC13-rc6-git13-epca/drivers/char/Kconfig
--- RC13-rc6-git13-rio/drivers/char/Kconfig	2005-08-21 13:16:46.000000000 -0400
+++ RC13-rc6-git13-epca/drivers/char/Kconfig	2005-08-21 13:16:46.000000000 -0400
@@ -138,7 +138,7 @@
 
 config DIGIEPCA
 	tristate "Digiboard Intelligent Async Support"
-	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP && (!64BIT || BROKEN)
 	---help---
 	  This is a driver for Digi International's Xx, Xeve, and Xem series
 	  of cards which provide multiple serial ports. You would need

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbVHWVnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbVHWVnB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVHWVmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:42:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54453 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932402AbVHWVmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:42:17 -0400
To: torvalds@osdl.org
Subject: [PATCH] (7/43) Kconfig fix (HISAX_FRITZPCI on ppc64)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7ga9-000796-5y@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:45:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HISAX_FRITZPCI is broken on ppc64; marked as such

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-m32r-genrtc/drivers/isdn/hisax/Kconfig RC13-rc6-git13-ppc64-isdn/drivers/isdn/hisax/Kconfig
--- RC13-rc6-git13-m32r-genrtc/drivers/isdn/hisax/Kconfig	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-ppc64-isdn/drivers/isdn/hisax/Kconfig	2005-08-21 13:16:50.000000000 -0400
@@ -134,6 +134,7 @@
 
 config HISAX_FRITZPCI
 	bool "AVM PnP/PCI (Fritz!PnP/PCI)"
+	depends on BROKEN || !PPC64
 	help
 	  This enables HiSax support for the AVM "Fritz!PnP" and "Fritz!PCI".
 	  See <file:Documentation/isdn/README.HiSax> on how to configure it.

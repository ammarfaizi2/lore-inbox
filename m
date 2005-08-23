Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbVHWVzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVHWVzf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbVHWVyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:54:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60341 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932417AbVHWVms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:42:48 -0400
To: torvalds@osdl.org
Subject: [PATCH] (13/43) Kconfig fix (tms380tr and ISA_DMA_API)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gad-0007AC-EN@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:45:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ISA parts of tms380tr are using ISA DMA helpers and should depend on
ISA_DMA_API.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-m32r-smc/drivers/net/tokenring/Kconfig RC13-rc6-git13-tms380tr/drivers/net/tokenring/Kconfig
--- RC13-rc6-git13-m32r-smc/drivers/net/tokenring/Kconfig	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-tms380tr/drivers/net/tokenring/Kconfig	2005-08-21 13:16:56.000000000 -0400
@@ -84,7 +84,7 @@
 
 config TMS380TR
 	tristate "Generic TMS380 Token Ring ISA/PCI adapter support"
-	depends on TR && (PCI || ISA)
+	depends on TR && (PCI || ISA && ISA_DMA_API)
 	select FW_LOADER
 	---help---
 	  This driver provides generic support for token ring adapters

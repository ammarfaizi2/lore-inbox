Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbVHWVls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbVHWVls (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVHWVls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:41:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48821 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932399AbVHWVlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:41:47 -0400
To: torvalds@osdl.org
Subject: [PATCH] (1/43) Kconfig fix (alpha NUMA)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gZe-00077v-UJ@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:44:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NUMA is broken on alpha; marked as such

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-disable-DI/arch/alpha/Kconfig RC13-rc6-git13-alpha-NUMA/arch/alpha/Kconfig
--- RC13-rc6-git13-disable-DI/arch/alpha/Kconfig	2005-08-10 10:37:45.000000000 -0400
+++ RC13-rc6-git13-alpha-NUMA/arch/alpha/Kconfig	2005-08-21 13:16:44.000000000 -0400
@@ -522,7 +522,7 @@
 
 config NUMA
 	bool "NUMA Support (EXPERIMENTAL)"
-	depends on DISCONTIGMEM
+	depends on DISCONTIGMEM && BROKEN
 	help
 	  Say Y to compile the kernel to support NUMA (Non-Uniform Memory
 	  Access).  This option is for configuring high-end multiprocessor

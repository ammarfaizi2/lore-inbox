Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbVHWVmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVHWVmR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVHWVmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:42:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49333 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932402AbVHWVlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:41:53 -0400
To: torvalds@osdl.org
Subject: [PATCH] (2/43) Kconfig fix (arm SMP)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gZj-000783-VA@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:44:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SMP is broken on arm; marked as such

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-alpha-NUMA/arch/arm/Kconfig RC13-rc6-git13-arm-SMP/arch/arm/Kconfig
--- RC13-rc6-git13-alpha-NUMA/arch/arm/Kconfig	2005-08-10 10:37:45.000000000 -0400
+++ RC13-rc6-git13-arm-SMP/arch/arm/Kconfig	2005-08-21 13:16:45.000000000 -0400
@@ -310,7 +310,7 @@
 
 config SMP
 	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
-	depends on EXPERIMENTAL #&& n
+	depends on EXPERIMENTAL && BROKEN #&& n
 	help
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, like most personal computers, say N. If

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbVHWVyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVHWVyy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVHWVmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:42:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58037 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932417AbVHWVmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:42:38 -0400
To: torvalds@osdl.org
Subject: [PATCH] (11/43) Kconfig fix (infiniband and PCI)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gaT-00079k-Ax@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:45:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

infiniband uses PCI helpers all over the place (including the core parts) and
won't build without PCI.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-m32r-pagealloc/drivers/infiniband/Kconfig RC13-rc6-git13-infiniband/drivers/infiniband/Kconfig
--- RC13-rc6-git13-m32r-pagealloc/drivers/infiniband/Kconfig	2005-08-10 10:37:48.000000000 -0400
+++ RC13-rc6-git13-infiniband/drivers/infiniband/Kconfig	2005-08-21 13:16:54.000000000 -0400
@@ -1,6 +1,7 @@
 menu "InfiniBand support"
 
 config INFINIBAND
+	depends on PCI || BROKEN
 	tristate "InfiniBand support"
 	---help---
 	  Core support for InfiniBand (IB).  Make sure to also select

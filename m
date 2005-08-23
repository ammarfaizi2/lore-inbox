Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbVHWV4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbVHWV4v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVHWV4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:56:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52405 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932409AbVHWVmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:42:10 -0400
To: torvalds@osdl.org
Subject: [PATCH] (5/43) Kconfig fix (m32r NUMA)
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Message-Id: <E1E7gZz-00078k-3L@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:45:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NUMA is broken on m32r; marked as such

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-floppy/arch/m32r/Kconfig RC13-rc6-git13-m32r-NUMA/arch/m32r/Kconfig
--- RC13-rc6-git13-floppy/arch/m32r/Kconfig	2005-08-10 10:37:46.000000000 -0400
+++ RC13-rc6-git13-m32r-NUMA/arch/m32r/Kconfig	2005-08-21 13:16:49.000000000 -0400
@@ -269,7 +269,7 @@
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation Support"
-	depends on SMP
+	depends on SMP && BROKEN
 	default n
 
 # turning this on wastes a bunch of space.

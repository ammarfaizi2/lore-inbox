Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbVH2UaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbVH2UaX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 16:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVH2UaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 16:30:23 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:49376 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750946AbVH2UaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 16:30:23 -0400
Message-Id: <200508292007.j7TK76gI029932@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 5/9] UML - Remove duplicated exports
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Aug 2005 16:07:06 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro spotted a bunch of duplicated exports - this removes them.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-rc6/arch/um/kernel/ksyms.c
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/kernel/ksyms.c	2005-08-15 12:03:00.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/kernel/ksyms.c	2005-08-15 14:07:43.000000000 -0400
@@ -114,22 +114,3 @@
 EXPORT_SYMBOL(__read_lock_failed);
 
 #endif
-
-#ifdef CONFIG_HIGHMEM
-EXPORT_SYMBOL(kmap);
-EXPORT_SYMBOL(kunmap);
-EXPORT_SYMBOL(kmap_atomic);
-EXPORT_SYMBOL(kunmap_atomic);
-EXPORT_SYMBOL(kmap_atomic_to_page);
-#endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVGZUM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVGZUM5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 16:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVGZUKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 16:10:43 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:17932 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261998AbVGZUKa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 16:10:30 -0400
Message-Id: <200507262004.j6QK4DH8010080@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/4] UML - Fix misdeclared function
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Jul 2005 16:04:13 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an interface which differed from its declaration, and includes
the relevant header so that this doesn't happen again.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/kernel/helper.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/helper.c	2005-07-25 17:22:14.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/helper.c	2005-07-26 16:01:52.000000000 -0400
@@ -13,6 +13,7 @@
 #include "user.h"
 #include "kern_util.h"
 #include "user_util.h"
+#include "helper.h"
 #include "os.h"
 
 struct helper_data {
@@ -149,7 +150,7 @@
 	return(pid);
 }
 
-int helper_wait(int pid, int block)
+int helper_wait(int pid)
 {
 	int ret;
 
@@ -160,14 +161,3 @@
 	}
 	return(ret);
 }
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


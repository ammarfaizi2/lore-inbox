Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbTE2WXy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 18:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbTE2WXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 18:23:53 -0400
Received: from air-2.osdl.org ([65.172.181.6]:57062 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262946AbTE2WXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 18:23:52 -0400
Subject: [2.5.70][PATCH][TRIVIAL] kernel/suspend.c : eliminate 2 compile
	time warnings
From: Andy Pfiffer <andyp@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054247801.12933.5.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 29 May 2003 15:36:42 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or
higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1429  -> 1.1430 
#	    kernel/suspend.c	1.39    -> 1.40   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/29	andyp@andyp.pdx.osdl.net	1.1430
# Remove compile-time warnings.
# --------------------------------------------
#
diff -Nru a/kernel/suspend.c b/kernel/suspend.c
--- a/kernel/suspend.c	Thu May 29 15:16:34 2003
+++ b/kernel/suspend.c	Thu May 29 15:16:34 2003
@@ -95,9 +95,11 @@
 /* Variables to be preserved over suspend */
 static int new_loglevel = 7;
 static int orig_loglevel = 0;
-static int orig_fgconsole, orig_kmsg;
 static int pagedir_order_check;
 static int nr_copy_pages_check;
+#ifdef CONFIG_VT
+static int orig_fgconsole, orig_kmsg;
+#endif
 
 static int resume_status = 0;
 static char resume_file[256] = "";			/* For resume= kernel option */




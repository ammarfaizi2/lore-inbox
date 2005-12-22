Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbVLVAKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbVLVAKY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 19:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbVLVAKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 19:10:24 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:23241 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965018AbVLVAKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 19:10:23 -0500
Subject: [PATCH] Un-deprecate inter_module_*
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 19:14:30 -0500
Message-Id: <1135210470.31433.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I am also sick of looking at "inter_module_foo is deprecated" warnings.
They have been deprecated for 6-12 months and obviously no one is fixing
it.  I don't have the time or the inclination to fix it so here's a
patch to un-deprecate inter_module_*.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--- include/linux/module.h~	2005-12-16 14:45:27.000000000 -0500
+++ include/linux/module.h	2005-12-21 19:10:16.000000000 -0500
@@ -567,11 +567,11 @@
 
 /* Use symbol_get and symbol_put instead.  You'll thank me. */
 #define HAVE_INTER_MODULE
-extern void __deprecated inter_module_register(const char *,
+extern void inter_module_register(const char *,
 		struct module *, const void *);
-extern void __deprecated inter_module_unregister(const char *);
-extern const void * __deprecated inter_module_get_request(const char *,
+extern void inter_module_unregister(const char *);
+extern const void * inter_module_get_request(const char *,
 		const char *);
-extern void __deprecated inter_module_put(const char *);
+extern void inter_module_put(const char *);
 
 #endif /* _LINUX_MODULE_H */



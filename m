Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269213AbUISKN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269213AbUISKN5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 06:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269210AbUISKN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 06:13:56 -0400
Received: from verein.lst.de ([213.95.11.210]:53673 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S269209AbUISKNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 06:13:45 -0400
Date: Sun, 19 Sep 2004 12:13:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mark inter_module_* deprecated
Message-ID: <20040919101337.GA5910@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These had been officially deprecated since Rusty's module rewrite, but
never got the __deprecated marker.  The only remaining users are drm and
mtd, so we'll get some warnings for common builds.  But maybe that's the
only way to get the drm people to fix the mess :)


--- 1.79/include/linux/module.h	2004-06-27 09:19:28 +02:00
+++ edited/include/linux/module.h	2004-09-19 11:52:33 +02:00
@@ -580,10 +580,12 @@
 
 /* Use symbol_get and symbol_put instead.  You'll thank me. */
 #define HAVE_INTER_MODULE
-extern void inter_module_register(const char *, struct module *, const void *);
-extern void inter_module_unregister(const char *);
-extern const void *inter_module_get(const char *);
-extern const void *inter_module_get_request(const char *, const char *);
-extern void inter_module_put(const char *);
+extern void __deprecated inter_module_register(const char *,
+		struct module *, const void *);
+extern void __deprecated inter_module_unregister(const char *);
+extern const void * __deprecated inter_module_get(const char *);
+extern const void * __deprecated inter_module_get_request(const char *,
+		const char *);
+extern void __deprecated inter_module_put(const char *);
 
 #endif /* _LINUX_MODULE_H */

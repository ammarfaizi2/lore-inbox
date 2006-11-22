Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031444AbWKVESS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031444AbWKVESS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 23:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031199AbWKVESJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 23:18:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19469 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030683AbWKVERk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 23:17:40 -0500
Date: Wed, 22 Nov 2006 05:17:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/fscache/main.c: cleanups
Message-ID: <20061122041740.GC5200@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- remove the unused global variable fscache_debug
- make the needlessly global struct fscache_kset static

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/fscache/main.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- linux-2.6.19-rc5-mm2/fs/fscache/main.c.old	2006-11-22 03:08:53.000000000 +0100
+++ linux-2.6.19-rc5-mm2/fs/fscache/main.c	2006-11-22 03:09:23.000000000 +0100
@@ -16,8 +16,6 @@
 #include <linux/slab.h>
 #include "fscache-int.h"
 
-int fscache_debug;
-
 static int fscache_init(void);
 static void fscache_exit(void);
 
@@ -41,14 +39,12 @@ static struct kobj_type fscache_ktype = 
 	.default_attrs	= NULL,
 };
 
-struct kset fscache_kset = {
+static struct kset fscache_kset = {
 	.kobj.name	= "fscache",
 	.kobj.kset	= &fs_subsys.kset,
 	.ktype		= &fscache_ktype,
 };
 
-EXPORT_SYMBOL(fscache_kset);
-
 /*****************************************************************************/
 /*
  * initialise the fs caching module


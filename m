Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265018AbSIRCNX>; Tue, 17 Sep 2002 22:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbSIRCMX>; Tue, 17 Sep 2002 22:12:23 -0400
Received: from dp.samba.org ([66.70.73.150]:60333 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265018AbSIRCMN>;
	Tue, 17 Sep 2002 22:12:13 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
Subject: [PATCH] In-kernel module loader 5/7
Date: Wed, 18 Sep 2002 12:08:38 +1000
Message-Id: <20020918021714.DDDF02C129@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Every module needs module_init
Author: Rusty Russell
Status: Trivial

D: Every module needs a module_init now, so insert a trivial one where
D: needed.  This is not exhaustive.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17783-2.5.35-modbase-try-i386.pre/lib/zlib_deflate/deflate_syms.c .17783-2.5.35-modbase-try-i386/lib/zlib_deflate/deflate_syms.c
--- .17783-2.5.35-modbase-try-i386.pre/lib/zlib_deflate/deflate_syms.c	2002-02-20 17:56:17.000000000 +1100
+++ .17783-2.5.35-modbase-try-i386/lib/zlib_deflate/deflate_syms.c	2002-09-18 11:45:27.000000000 +1000
@@ -19,3 +19,9 @@ EXPORT_SYMBOL(zlib_deflateReset);
 EXPORT_SYMBOL(zlib_deflateCopy);
 EXPORT_SYMBOL(zlib_deflateParams);
 MODULE_LICENSE("GPL");
+
+static int init(void)
+{
+	return 0;
+}
+module_init(init);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17783-2.5.35-modbase-try-i386.pre/lib/zlib_inflate/inflate_syms.c .17783-2.5.35-modbase-try-i386/lib/zlib_inflate/inflate_syms.c
--- .17783-2.5.35-modbase-try-i386.pre/lib/zlib_inflate/inflate_syms.c	2002-02-20 17:56:42.000000000 +1100
+++ .17783-2.5.35-modbase-try-i386/lib/zlib_inflate/inflate_syms.c	2002-09-18 11:45:27.000000000 +1000
@@ -20,3 +20,9 @@ EXPORT_SYMBOL(zlib_inflateReset);
 EXPORT_SYMBOL(zlib_inflateSyncPoint);
 EXPORT_SYMBOL(zlib_inflateIncomp); 
 MODULE_LICENSE("GPL");
+
+static int init(void)
+{
+	return 0;
+}
+module_init(init);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312412AbSCURV5>; Thu, 21 Mar 2002 12:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312415AbSCURVn>; Thu, 21 Mar 2002 12:21:43 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:7299 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S312401AbSCURVU>; Thu, 21 Mar 2002 12:21:20 -0500
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel@vger.kernel.org
cc: linux-alpha@vger.kernel.org
Subject: [PATCH] Needed to get 2.5.7 to compile and link on Alpha [4/10]
Message-Id: <E16o6CB-0005O7-00@lightning.hereintown.net>
Date: Thu, 21 Mar 2002 12:17:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Needed to link.  I'm not sure if check_pgt_cache should be a NOP on the
Alpha but most the rest of the functions in pgalloc.h are, and it seems
to work for me.  But someone who really knows what they are doing should
check it.

-Chris


--- linux-2.5.7/include/asm-alpha/pgalloc.h~	Wed Mar 20 15:49:19 2002
+++ linux-2.5.7/include/asm-alpha/pgalloc.h	Wed Mar 20 15:48:10 2002
@@ -292,4 +292,6 @@
 	__free_page(page);
 }
 
+#define check_pgt_cache()	do { } while (0)
+
 #endif /* _ALPHA_PGALLOC_H */

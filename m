Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317092AbSEXGBX>; Fri, 24 May 2002 02:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317093AbSEXGBW>; Fri, 24 May 2002 02:01:22 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:17812 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317092AbSEXGBW>; Fri, 24 May 2002 02:01:22 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: [PATCH] FIX for XBUG(comment) BUG enhancement
Date: Fri, 24 May 2002 16:02:01 +1000
Message-Id: <E17B89J-0006ex-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for two-character typo (noticed by Stephen Rothwell).
Applies on top of XBUG patch.

--- working-2.5.17-xbug/include/linux/jbd.h.~1~	Fri May 24 15:58:39 2002
+++ working-2.5.17-xbug/include/linux/jbd.h	Fri May 24 16:01:20 2002
@@ -27,6 +27,7 @@
 
 #include <linux/journal-head.h>
 #include <linux/stddef.h>
+#include <linux/stringify.h>
 #include <asm/semaphore.h>
 #endif
 
@@ -200,7 +201,7 @@
 do {									\
 	if (!(assert)) {						\
 		XBUG("Assertion failure in " __FUNCTION__		\
-		     "() at " __FILE__ ":" __stringize(__LINE__)	\
+		     "() at " __FILE__ ":" __stringify(__LINE__)	\
 		     ": " #assert);					\
 	}								\
 } while (0)
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

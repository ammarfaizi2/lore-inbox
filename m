Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317279AbSFCFly>; Mon, 3 Jun 2002 01:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317280AbSFCFlx>; Mon, 3 Jun 2002 01:41:53 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:20669 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317279AbSFCFlw>; Mon, 3 Jun 2002 01:41:52 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] TRIVIAL: TAGS creation should go into arch dirs
Date: Mon, 03 Jun 2002 15:45:40 +1000
Message-Id: <E17Ekey-0005lj-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Playing with arch stuff does this to you.

Rusty.

--- trivial-2.5.20/Makefile.orig	Mon Jun  3 15:25:05 2002
+++ trivial-2.5.20/Makefile	Mon Jun  3 15:25:05 2002
@@ -369,7 +369,7 @@
 TAGS: FORCE
 	{ find include/asm-${ARCH} -name '*.h' -print ; \
 	find include -type d \( -name "asm-*" -o -name config \) -prune -o -name '*.h' -print ; \
-	find $(SUBDIRS) init -name '*.[ch]' ; } | grep -v SCCS | etags -
+	find $(SUBDIRS) init arch/${ARCH} -name '*.[chS]' ; } | grep -v SCCS | etags -
 
 # 	Exuberant ctags works better with -I
 tags: FORCE

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

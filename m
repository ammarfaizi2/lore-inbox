Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317049AbSFFVVr>; Thu, 6 Jun 2002 17:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317187AbSFFVVq>; Thu, 6 Jun 2002 17:21:46 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:7858 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S317049AbSFFVVo>; Thu, 6 Jun 2002 17:21:44 -0400
Date: Thu, 6 Jun 2002 14:21:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Include <linux/gfp.h> directly instead of via <linux/mm.h>
Message-ID: <20020606212121.GI14252@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change to including <linux/gfp.h> directly when possible.

These files used <linux/mm.h> to just get at <linux/gfp.h>, so include
it directly.  This is part of what's needed to remove it from
<linux/mm.h>.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


===== include/linux/pagemap.h 1.20 vs edited =====
--- 1.20/include/linux/pagemap.h	Mon May  6 09:21:54 2002
+++ edited/include/linux/pagemap.h	Thu Jun  6 14:05:07 2002
@@ -4,7 +4,7 @@
 /*
  * Copyright 1995 Linus Torvalds
  */
-#include <linux/mm.h>
+#include <linux/gfp.h>
 #include <linux/fs.h>
 #include <linux/list.h>
 #include <linux/highmem.h>
===== kernel/futex.c 1.6 vs edited =====
--- 1.6/kernel/futex.c	Thu Jun  6 10:13:05 2002
+++ edited/kernel/futex.c	Thu Jun  6 14:05:07 2002
@@ -26,7 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/sched.h>
-#include <linux/mm.h>
+#include <linux/gfp.h>
 #include <linux/hash.h>
 #include <linux/init.h>
 #include <linux/fs.h>
===== kernel/ptrace.c 1.11 vs edited =====
--- 1.11/kernel/ptrace.c	Sat Mar 23 15:57:49 2002
+++ edited/kernel/ptrace.c	Thu Jun  6 14:05:07 2002
@@ -9,7 +9,7 @@
 
 #include <linux/sched.h>
 #include <linux/errno.h>
-#include <linux/mm.h>
+#include <linux/gfp.h>
 #include <linux/highmem.h>
 #include <linux/smp_lock.h>
 

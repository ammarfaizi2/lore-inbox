Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWCLVeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWCLVeG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 16:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWCLVeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 16:34:06 -0500
Received: from main.gmane.org ([80.91.229.2]:20160 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932232AbWCLVeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 16:34:04 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: [PATCH][TRIVIAL] Fix comments in 2.6.16-rc6: s/granuality/granularity/
Date: Mon, 13 Mar 2006 05:39:24 +0900
Message-ID: <dv20tt$46a$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mail/News 1.5 (X11/20060209)
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,
I was grepping through the code and some `grep ganularity -R .` didn't
catch what I thought. Then looking closer I saw the term "granuality"
used in only four places (in comments) and granularity in many more
places describing the same idea. Some other facts:

dictionary.com does not know such a word
define:granuality on google is not found (and pages for granuality are
mostly related to patches to the kernel)
it has not been discussed as a term on LKML, AFAICS (=Can Search)

To be consistent, I think granularity should be used everywhere.

Here is the patch for the latest 2.6.16-rc6.
All trivial, all comments only, not "affecting kernel stability".
If somebody can take care to push it for rc7, if not for later.

I reading LKML, but please CC me if you decide to to (not) accept it.

Kalin.
-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

Signed-off-by: Kalin KOZHUHAROV <kalin@thinrope.net>

diff -Nru linux-2.6.16-rc6-V/include/linux/fs.h linux-2.6.16-rc6-K/include/linux/fs.h
--- linux-2.6.16-rc6-V/include/linux/fs.h	2006-03-13 03:04:36.000000000 +0900
+++ linux-2.6.16-rc6-K/include/linux/fs.h	2006-03-13 03:12:46.000000000 +0900
@@ -849,7 +849,7 @@
 	 */
 	struct semaphore s_vfs_rename_sem;	/* Kludge */
 
-	/* Granuality of c/m/atime in ns.
+	/* Granularity of c/m/atime in ns.
 	   Cannot be worse than a second */
 	u32		   s_time_gran;
 };
diff -Nru linux-2.6.16-rc6-V/kernel/time.c linux-2.6.16-rc6-K/kernel/time.c
--- linux-2.6.16-rc6-V/kernel/time.c	2006-03-13 03:04:40.000000000 +0900
+++ linux-2.6.16-rc6-K/kernel/time.c	2006-03-13 03:11:58.000000000 +0900
@@ -437,7 +437,7 @@
  * current_fs_time - Return FS time
  * @sb: Superblock.
  *
- * Return the current time truncated to the time granuality supported by
+ * Return the current time truncated to the time granularity supported by
  * the fs.
  */
 struct timespec current_fs_time(struct super_block *sb)
@@ -448,11 +448,11 @@
 EXPORT_SYMBOL(current_fs_time);
 
 /**
- * timespec_trunc - Truncate timespec to a granuality
+ * timespec_trunc - Truncate timespec to a granularity
  * @t: Timespec
- * @gran: Granuality in ns.
+ * @gran: Granularity in ns.
  *
- * Truncate a timespec to a granuality. gran must be smaller than a second.
+ * Truncate a timespec to a granularity. gran must be smaller than a second.
  * Always rounds down.
  *
  * This function should be only used for timestamps returned by



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264118AbTDWQcG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264120AbTDWQbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:31:51 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:10255 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S264118AbTDWQaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:30:39 -0400
Date: Wed, 23 Apr 2003 10:20:16 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for fs/proc/proc_misc.c
Message-ID: <20030423152016.GB5681@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a patch that switches the file to use C99 initializers. The patch
is against the current BK.

Art Haas

===== fs/proc/proc_misc.c 1.75 vs edited =====
--- 1.75/fs/proc/proc_misc.c	Sun Apr 20 01:22:58 2003
+++ edited/fs/proc/proc_misc.c	Wed Apr 23 10:12:19 2003
@@ -339,10 +339,10 @@
 	return seq_open(file, &diskstats_op);
 }
 static struct file_operations proc_diskstats_operations = {
-	open:		diskstats_open,
-	read:		seq_read,
-	llseek:		seq_lseek,
-	release:	seq_release,
+	.open		= diskstats_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
 };
 
 #ifdef CONFIG_MODULES
-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
 -- Theodore Roosevelt, Kansas City Star, 1918

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265636AbTGDByw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 21:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265655AbTGDByw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:54:52 -0400
Received: from granite.he.net ([216.218.226.66]:23054 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265636AbTGDBys convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:54:48 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10572845542321@kroah.com>
Subject: Re: [PATCH] PCI and sysfs fixes for 2.5.74
In-Reply-To: <10572845533715@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Jul 2003 19:09:14 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1371, 2003/07/03 16:06:08-07:00, greg@kroah.com

[PATCH] sysfs: change print() to pr_debug() to not annoy everyone.


 fs/sysfs/bin.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff -Nru a/fs/sysfs/bin.c b/fs/sysfs/bin.c
--- a/fs/sysfs/bin.c	Thu Jul  3 18:16:09 2003
+++ b/fs/sysfs/bin.c	Thu Jul  3 18:16:09 2003
@@ -2,6 +2,8 @@
  * bin.c - binary file operations for sysfs.
  */
 
+#undef DEBUG
+
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/kobject.h>
@@ -48,7 +50,7 @@
 	if (copy_to_user(userbuf, buffer + offs, count) != 0)
 		return -EINVAL;
 
-	printk("offs = %lld, *off = %lld, count = %zd\n", offs, *off, count);
+	pr_debug("offs = %lld, *off = %lld, count = %zd\n", offs, *off, count);
 
 	*off = offs + count;
 


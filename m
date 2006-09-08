Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWIHW5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWIHW5t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWIHWzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:55:12 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:17547 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751238AbWIHWy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:54:59 -0400
From: Zach Brown <zach.brown@oracle.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-Id: <20060908225458.9340.81041.sendpatchset@kaori.pdx.zabbo.net>
In-Reply-To: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
References: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
Subject: [PATCH 4/10] sysfs: use size_t length modifier in pr_debug format arguments
Date: Fri,  8 Sep 2006 15:54:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs: use size_t length modifier in pr_debug format arguments

Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 fs/sysfs/file.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: 2.6.18-rc6-debug-args/fs/sysfs/file.c
===================================================================
--- 2.6.18-rc6-debug-args.orig/fs/sysfs/file.c
+++ 2.6.18-rc6-debug-args/fs/sysfs/file.c
@@ -157,8 +157,8 @@ sysfs_read_file(struct file *file, char 
 		if ((retval = fill_read_buffer(file->f_dentry,buffer)))
 			goto out;
 	}
-	pr_debug("%s: count = %d, ppos = %lld, buf = %s\n",
-		 __FUNCTION__,count,*ppos,buffer->page);
+	pr_debug("%s: count = %zd, ppos = %lld, buf = %s\n",
+		 __FUNCTION__, count, *ppos, buffer->page);
 	retval = flush_read_buffer(buffer,buf,count,ppos);
 out:
 	up(&buffer->sem);

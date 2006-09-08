Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWIHW5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWIHW5t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWIHWzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:55:14 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:17035 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751237AbWIHWyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:54:54 -0400
From: Zach Brown <zach.brown@oracle.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-Id: <20060908225453.9340.85458.sendpatchset@kaori.pdx.zabbo.net>
In-Reply-To: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
References: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
Subject: [PATCH 3/10] configfs: use size_t length modifier in pr_debug format argument
Date: Fri,  8 Sep 2006 15:54:53 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

configfs: use size_t length modifier in pr_debug format argument

Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 fs/configfs/file.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: 2.6.18-rc6-debug-args/fs/configfs/file.c
===================================================================
--- 2.6.18-rc6-debug-args.orig/fs/configfs/file.c
+++ 2.6.18-rc6-debug-args/fs/configfs/file.c
@@ -137,8 +137,8 @@ configfs_read_file(struct file *file, ch
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

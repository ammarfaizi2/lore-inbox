Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030627AbVIBBXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030627AbVIBBXs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 21:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030628AbVIBBXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 21:23:48 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28688 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030627AbVIBBXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 21:23:47 -0400
Date: Fri, 2 Sep 2005 03:23:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/filemap.c: make two functions static
Message-ID: <20050902012346.GK3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 20 Aug 2005

--- linux-2.6.13-rc6-mm1/mm/filemap.c.old	2005-08-20 14:37:27.000000000 +0200
+++ linux-2.6.13-rc6-mm1/mm/filemap.c	2005-08-20 14:46:24.000000000 +0200
@@ -2034,7 +2034,7 @@
 }
 EXPORT_SYMBOL(generic_file_buffered_write);
 
-ssize_t
+static ssize_t
 __generic_file_aio_write_nolock(struct kiocb *iocb, const struct iovec *iov,
 				unsigned long nr_segs, loff_t *ppos)
 {
@@ -2134,7 +2134,7 @@
 	return ret;
 }
 
-ssize_t
+static ssize_t
 __generic_file_write_nolock(struct file *file, const struct iovec *iov,
 				unsigned long nr_segs, loff_t *ppos)
 {


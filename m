Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268180AbUIGPFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268180AbUIGPFU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268298AbUIGPDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:03:15 -0400
Received: from verein.lst.de ([213.95.11.210]:22426 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268209AbUIGPAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:00:32 -0400
Date: Tue, 7 Sep 2004 17:00:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] unexport do_execve/do_select
Message-ID: <20040907150028.GA9235@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are basically shared code for native/32bit compat code, but as
CONFIG_COMPAT is a bool there's no need to export them.


--- 1.132/fs/exec.c	2004-08-27 09:02:34 +02:00
+++ edited/fs/exec.c	2004-09-07 14:25:35 +02:00
@@ -1187,8 +1187,6 @@
 	return retval;
 }
 
-EXPORT_SYMBOL(do_execve);
-
 int set_binfmt(struct linux_binfmt *new)
 {
 	struct linux_binfmt *old = current->binfmt;
--- 1.23/fs/select.c	2004-08-27 09:02:39 +02:00
+++ edited/fs/select.c	2004-09-07 14:26:58 +02:00
@@ -267,8 +267,6 @@
 	return retval;
 }
 
-EXPORT_SYMBOL(do_select);
-
 static void *select_bits_alloc(int size)
 {
 	return kmalloc(6 * size, GFP_KERNEL);

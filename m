Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWCaEGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWCaEGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 23:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWCaEGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 23:06:20 -0500
Received: from havoc.gtf.org ([69.61.125.42]:38884 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751212AbWCaEGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 23:06:19 -0500
Date: Thu, 30 Mar 2006 23:06:13 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] splice exports
Message-ID: <20060331040613.GA23511@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Woe be unto he who builds their filesystems as modules.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/fs/splice.c b/fs/splice.c
index 4a026f9..7c2bbf1 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -22,6 +22,7 @@
 #include <linux/pipe_fs_i.h>
 #include <linux/mm_inline.h>
 #include <linux/swap.h>
+#include <linux/module.h>
 
 /*
  * Passed to the actors
@@ -567,6 +568,9 @@ ssize_t generic_splice_sendpage(struct i
 	return move_from_pipe(inode, out, len, flags, pipe_to_sendpage);
 }
 
+EXPORT_SYMBOL(generic_file_splice_write);
+EXPORT_SYMBOL(generic_file_splice_read);
+
 static long do_splice_from(struct inode *pipe, struct file *out, size_t len,
 			   unsigned int flags)
 {

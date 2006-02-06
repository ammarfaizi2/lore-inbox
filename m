Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWBFTgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWBFTgh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWBFTgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:36:37 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:52129 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932314AbWBFTgg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:36:36 -0500
Subject: [RFC/PATCH] block: undeprecate ll_rw_block()
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Christoph Hellwig <hch@infradead.org>
Date: Mon, 06 Feb 2006 21:36:30 +0200
Message-Id: <1139254591.17774.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch removes the DEPRECATED comment from ll_rw_block(). The function
is still in active use and there isn't any real replacement for it.

Cc: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 fs/buffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: 2.6/fs/buffer.c
===================================================================
--- 2.6.orig/fs/buffer.c
+++ 2.6/fs/buffer.c
@@ -2830,7 +2830,7 @@ int submit_bh(int rw, struct buffer_head
 }
 
 /**
- * ll_rw_block: low-level access to block devices (DEPRECATED)
+ * ll_rw_block: low-level access to block devices
  * @rw: whether to %READ or %WRITE or %SWRITE or maybe %READA (readahead)
  * @nr: number of &struct buffer_heads in the array
  * @bhs: array of pointers to &struct buffer_head



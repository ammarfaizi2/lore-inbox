Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315929AbSEZK1m>; Sun, 26 May 2002 06:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315935AbSEZK1l>; Sun, 26 May 2002 06:27:41 -0400
Received: from adsl.hlfl.org ([62.212.107.116]:516 "HELO adsl.hlfl.org")
	by vger.kernel.org with SMTP id <S315929AbSEZK1l>;
	Sun, 26 May 2002 06:27:41 -0400
Date: Sun, 26 May 2002 12:27:41 +0200
From: Arnaud Launay <asl@launay.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.5.18] Re: Modules unresolved symbols
Message-ID: <20020526122741.A5578@launay.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020526022051.15390.qmail@web14207.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
X-PGP-Key: http://launay.org/pgpkey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sat, May 25, 2002 at 07:20:51PM -0700, Erik McKee a écrit:
> There is a missing export for the ext2 case as a mod.  I posted
> a patch here recently and forwarded it to linux....perhaps it
> got lost ;)

Dunno. Here are two patches which corrects the ide and ext2 cases:


--- fs/buffer.c.old	Sun May 26 12:09:38 2002
+++ fs/buffer.c	Sun May 26 12:09:52 2002
@@ -835,6 +835,7 @@
 out:
 	return ret;
 }
+EXPORT_SYMBOL(write_mapping_buffers);
 
 void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
 {




--- drivers/block/ll_rw_blk.c.old	Sun May 26 12:20:30 2002
+++ drivers/block/ll_rw_blk.c	Sun May 26 12:18:05 2002
@@ -1880,6 +1880,7 @@
 EXPORT_SYMBOL(end_that_request_first);
 EXPORT_SYMBOL(end_that_request_last);
 EXPORT_SYMBOL(blk_init_queue);
+EXPORT_SYMBOL(blk_get_request);
 EXPORT_SYMBOL(bdev_get_queue);
 EXPORT_SYMBOL(blk_cleanup_queue);
 EXPORT_SYMBOL(blk_queue_make_request);


	Arnaud.
-- 
No colors anymore, I want them to turn black.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316803AbSGVLPX>; Mon, 22 Jul 2002 07:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316820AbSGVLPX>; Mon, 22 Jul 2002 07:15:23 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:63953 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S316803AbSGVLPV>;
	Mon, 22 Jul 2002 07:15:21 -0400
Date: Mon, 22 Jul 2002 13:17:38 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@zip.com.au>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.27 writeback scalability improvements
Message-ID: <Pine.GSO.4.21.0207221315180.19526-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kill warning by adding a missing prototype.

--- linux-2.5.27/include/linux/writeback.h.orig	Mon Jul  8 10:19:15 2002
+++ linux-2.5.27/include/linux/writeback.h	Mon Jul 22 13:09:14 2002
@@ -34,6 +34,10 @@
 void writeback_unlocked_inodes(int *nr_to_write,
 			       enum writeback_sync_modes sync_mode,
 			       unsigned long *older_than_this);
+extern void writeback_backing_dev(struct backing_dev_info *bdi,
+				  int *nr_to_write,
+				  enum writeback_sync_modes sync_mode,
+				  unsigned long *older_than_this);
 void wake_up_inode(struct inode *inode);
 void __wait_on_inode(struct inode * inode);
 void sync_inodes_sb(struct super_block *, int wait);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTFIK1Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 06:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTFIK1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 06:27:24 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:330 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S261773AbTFIK1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 06:27:23 -0400
Date: Mon, 9 Jun 2003 12:37:50 +0200
Message-Id: <200306091037.h59AboMC012143@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] ext2fs warning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext2fs: Fix incorrect printf() format (already fixed in 2.5)

--- linux-2.4.x/fs/ext2/balloc.c	Tue Apr 22 11:54:53 2003
+++ linux-m68k-2.4.x/fs/ext2/balloc.c	Tue Apr 22 15:39:59 2003
@@ -520,7 +520,7 @@
 	    in_range (tmp, le32_to_cpu(gdp->bg_inode_table),
 		      EXT2_SB(sb)->s_itb_per_group)) {
 		ext2_error (sb, "ext2_new_block",
-			    "Allocating block in system zone - block = %lu",
+			    "Allocating block in system zone - block = %u",
 			    tmp);
 		ext2_set_bit(j, bh->b_data);
 		DQUOT_FREE_BLOCK(inode, 1);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbTLAUbc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 15:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbTLAUbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 15:31:32 -0500
Received: from witte.sonytel.be ([80.88.33.193]:44019 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263946AbTLAUba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 15:31:30 -0500
Date: Mon, 1 Dec 2003 21:31:02 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Stephen Tweedie <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>
cc: ext3-users@redhat.com,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.23 ext3 warning
Message-ID: <Pine.GSO.4.21.0312012129260.25040-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kill warning if CONFIG_QUOTA is disabled.

--- linux-2.4.23/fs/ext3/super.c.orig	Fri Nov 28 21:04:40 2003
+++ linux-2.4.23/fs/ext3/super.c	Sun Nov 30 12:16:00 2003
@@ -449,7 +449,6 @@
 }
 
 static struct dquot_operations ext3_qops;
-static int (*old_sync_dquot)(struct dquot *dquot);
 
 static struct super_operations ext3_sops = {
 	read_inode:	ext3_read_inode,	/* BKL held */
@@ -1773,6 +1772,8 @@
  */
 
 #ifdef CONFIG_QUOTA
+
+static int (*old_sync_dquot)(struct dquot *dquot);
 
 /* Blocks: (2 data blocks) * (3 indirect + 1 descriptor + 1 bitmap) + superblock */
 #define EXT3_OLD_QFMT_BLOCKS 11

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


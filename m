Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbUJXKLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUJXKLI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 06:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUJXKLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 06:11:08 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:35151 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S261422AbUJXKJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 06:09:15 -0400
Date: Sun, 24 Oct 2004 12:08:58 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Anton Altaparmakov <aia21@cantab.net>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
cc: linux-ntfs-dev@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] NTFS: missing #include <linux/vmalloc.h>
Message-ID: <Pine.LNX.4.61.0410241200550.12609@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


fs/ntfs/compress.c calls v{malloc,free}() without including <linux/vmalloc.h>

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/fs/ntfs/compress.c.orig	2004-10-23 10:33:30.000000000 +0200
+++ linux-2.6.10-rc1/fs/ntfs/compress.c	2004-10-24 11:58:41.000000000 +0200
@@ -24,6 +24,7 @@
 #include <linux/fs.h>
 #include <linux/buffer_head.h>
 #include <linux/blkdev.h>
+#include <linux/vmalloc.h>
 
 #include "attrib.h"
 #include "inode.h"

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

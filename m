Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbUJ0GMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbUJ0GMr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUJ0GMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:12:39 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:49826 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261698AbUJ0GIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:08:55 -0400
Date: Tue, 26 Oct 2004 23:08:37 -0700
To: LKML <linux-kernel@vger.kernel.org>
Cc: Chris Wedgwood <cw@taniwha.stupidest.org>, hirofumi@mail.parknet.co.jp
Subject: [RFC] Rename SECTOR_SIZE to MSDOS_SECTOR_SIZE
Message-ID: <20041027060837.GB32396@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: cw@f00f.org (Chris Wedgwood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The token SECTOR_SIZE is used in multiple places that have (almost)
the same defintion everywhere.

How do people feel about rename this vague token?



===== include/linux/msdos_fs.h 1.42 vs edited =====
--- 1.42/include/linux/msdos_fs.h	2004-10-20 01:12:10 -07:00
+++ edited/include/linux/msdos_fs.h	2004-10-26 17:10:24 -07:00
@@ -6,11 +6,11 @@
  */
 #include <asm/byteorder.h>
 
-#define SECTOR_SIZE	512		/* sector size (bytes) */
-#define SECTOR_BITS	9		/* log2(SECTOR_SIZE) */
+#define MSDOS_SECTOR_SIZE	512	/* sector size (bytes) */
+#define MSDOS_SECTOR_BITS	9	/* log2(SECTOR_SIZE) */
 #define MSDOS_DPB	(MSDOS_DPS)	/* dir entries per block */
 #define MSDOS_DPB_BITS	4		/* log2(MSDOS_DPB) */
-#define MSDOS_DPS	(SECTOR_SIZE / sizeof(struct msdos_dir_entry))
+#define MSDOS_DPS	(MSDOS_SECTOR_SIZE / sizeof(struct msdos_dir_entry))
 #define MSDOS_DPS_BITS	4		/* log2(MSDOS_DPS) */
 
 

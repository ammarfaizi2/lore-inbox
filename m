Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVATD05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVATD05 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 22:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVATDZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 22:25:06 -0500
Received: from news.suse.de ([195.135.220.2]:31699 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262033AbVATDX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 22:23:28 -0500
Message-Id: <20050120032510.759333000@suse.de>
References: <20050120020124.110155000@suse.de>
Date: Thu, 20 Jan 2005 03:01:24 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Cc: Andrew Tridgell <tridge@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel@vger.kernel.org
Subject: [patch 3/5] Documentation fix
Content-Disposition: inline; filename=ea-xattr-doc.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-inode xattr entry descriptors are unsorted.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-latest/fs/ext3/xattr.c
===================================================================
--- linux-2.6.11-latest.orig/fs/ext3/xattr.c
+++ linux-2.6.11-latest/fs/ext3/xattr.c
@@ -37,9 +37,9 @@
  *   | value 2          | |
  *   +------------------+
  *
- * The header is followed by multiple entry descriptors. Descriptors are
- * kept sorted. The attribute values are aligned to the end of the block
- * in no specific order.
+ * The header is followed by multiple entry descriptors. In disk blocks, the
+ * entry descriptors are kept sorted. In inodes, they are unsorted. The
+ * attribute values are aligned to the end of the block in no specific order.
  *
  * Locking strategy
  * ----------------

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH


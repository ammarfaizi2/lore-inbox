Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264766AbSKEGFi>; Tue, 5 Nov 2002 01:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264957AbSKEGFi>; Tue, 5 Nov 2002 01:05:38 -0500
Received: from dp.samba.org ([66.70.73.150]:50382 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264766AbSKEGFh>;
	Tue, 5 Nov 2002 01:05:37 -0500
Date: Tue, 5 Nov 2002 17:11:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [TRIVIAL] Removed unused variables in fs/partitions/check.c
Message-ID: <20021105061147.GL13707@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This squashes a bunch of unused variable warnings in
fs/partitions/check.c.

diff -urN /home/dgibson/kernel/linuxppc-2.5/fs/partitions/check.c linux-bluefish/fs/partitions/check.c
--- /home/dgibson/kernel/linuxppc-2.5/fs/partitions/check.c	2002-11-04 14:23:07.000000000 +1100
+++ linux-bluefish/fs/partitions/check.c	2002-11-05 16:48:54.000000000 +1100
@@ -190,8 +190,6 @@
 	unsigned int devfs_flags = DEVFS_FL_DEFAULT;
 	char dirname[64], symlink[16];
 	static devfs_handle_t devfs_handle;
-	int part, max_p = dev->minors;
-	struct hd_struct *p = dev->part;
 
 	if (dev->flags & GENHD_FL_REMOVABLE)
 		devfs_flags |= DEVFS_FL_REMOVABLE;
@@ -227,10 +225,6 @@
 static void devfs_create_cdrom(struct gendisk *dev)
 {
 #ifdef CONFIG_DEVFS_FS
-	int pos = 0;
-	devfs_handle_t dir, slave;
-	unsigned int devfs_flags = DEVFS_FL_DEFAULT;
-	char dirname[64], symlink[16];
 	char vname[23];
 
 	if (!cdroms)


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

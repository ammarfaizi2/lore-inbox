Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261458AbSJACmM>; Mon, 30 Sep 2002 22:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261459AbSJACmL>; Mon, 30 Sep 2002 22:42:11 -0400
Received: from dp.samba.org ([66.70.73.150]:13704 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261458AbSJACmK>;
	Mon, 30 Sep 2002 22:42:10 -0400
Date: Tue, 1 Oct 2002 12:47:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Squash warnings in fs/partitions/check.c
Message-ID: <20021001024739.GP10265@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  This removes a bundle of unused variables from
fs/partitions/check.c:devfs_create_cdrom().  Some of them,
confusingly, were unused because they were overriden by variables with
the same name in an inner scope.

diff -urN /home/dgibson/kernel/linuxppc-2.5/fs/partitions/check.c linux-bluefish/fs/partitions/check.c
--- /home/dgibson/kernel/linuxppc-2.5/fs/partitions/check.c	2002-10-01 10:17:33.000000000 +1000
+++ linux-bluefish/fs/partitions/check.c	2002-10-01 12:42:28.000000000 +1000
@@ -338,10 +338,6 @@
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

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261945AbSJQSwY>; Thu, 17 Oct 2002 14:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbSJQSwY>; Thu, 17 Oct 2002 14:52:24 -0400
Received: from smtp01.web.de ([194.45.170.210]:41760 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S261945AbSJQSwX> convert rfc822-to-8bit;
	Thu, 17 Oct 2002 14:52:23 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?Ren=E9=20Scharfe?= <l.s.r@web.de>
To: linux-kernel@vger.kernel.org
Subject: Remove unused variables from fs/partitions/check.c
Date: Thu, 17 Oct 2002 20:58:40 +0200
User-Agent: KMail/1.4.2
Cc: trivial@rustcorp.com.au
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210172058.40939.l.s.r@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there's a surprising number of unused variables in fs/partitions/check.c
of kernel 2.5.43. This patch removes them.

René



--- linux-2.5.43/fs/partitions/check.c~	Wed Oct 16 18:51:31 2002
+++ linux-2.5.43/fs/partitions/check.c	Thu Oct 17 20:46:00 2002
@@ -189,8 +189,6 @@ static void devfs_create_partitions(stru
 	unsigned int devfs_flags = DEVFS_FL_DEFAULT;
 	char dirname[64], symlink[16];
 	static devfs_handle_t devfs_handle;
-	int part, max_p = dev->minors;
-	struct hd_struct *p = dev->part;
 
 	if (dev->flags & GENHD_FL_REMOVABLE)
 		devfs_flags |= DEVFS_FL_REMOVABLE;
@@ -226,10 +224,6 @@ static void devfs_create_partitions(stru
 static void devfs_create_cdrom(struct gendisk *dev)
 {
 #ifdef CONFIG_DEVFS_FS
-	int pos = 0;
-	devfs_handle_t dir, slave;
-	unsigned int devfs_flags = DEVFS_FL_DEFAULT;
-	char dirname[64], symlink[16];
 	char vname[23];
 
 	if (!cdroms)


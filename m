Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263918AbTCUTuW>; Fri, 21 Mar 2003 14:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263917AbTCUTtU>; Fri, 21 Mar 2003 14:49:20 -0500
Received: from smtp01.web.de ([217.72.192.180]:42259 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S263915AbTCUTsq> convert rfc822-to-8bit;
	Fri, 21 Mar 2003 14:48:46 -0500
Date: Fri, 21 Mar 2003 21:10:13 +0100
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] Typo in isofs/inode.c
Message-Id: <20030321211013.185a75e7.l.s.r@web.de>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch fixes a trivial error in isofs/inode.c, and reformats
the surrounding code a bit to (hopefully) enhance clarity.

René


--- linux-2.5.65/fs/isofs/inode.c~	2003-01-17 13:54:01.000000000 +0100
+++ linux-2.5.65/fs/isofs/inode.c	2003-03-21 20:05:57.000000000 +0100
@@ -1279,11 +1279,12 @@
 	}
 #endif
 
-	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode->i_ctime.tv_sec =
-		iso_date(de->date, high_sierra);
-	inode->i_mtime.tv_nsec = 0;
-	inode->i_atime.tv_nsec = 0;
-	inode->i_mtime.tv_nsec = 0;
+	inode->i_mtime.tv_sec =
+	inode->i_atime.tv_sec =
+	inode->i_ctime.tv_sec = iso_date(de->date, high_sierra);
+	inode->i_mtime.tv_nsec =
+	inode->i_atime.tv_nsec =
+	inode->i_ctime.tv_nsec = 0;
 
 	ei->i_first_extent = (isonum_733 (de->extent) +
 			      isonum_711 (de->ext_attr_length));

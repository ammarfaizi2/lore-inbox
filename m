Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSEEMEr>; Sun, 5 May 2002 08:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311121AbSEEMEq>; Sun, 5 May 2002 08:04:46 -0400
Received: from rm-f.net ([216.227.60.122]:23309 "EHLO SirDrinkalot.rm-f.net")
	by vger.kernel.org with ESMTP id <S311025AbSEEMEp>;
	Sun, 5 May 2002 08:04:45 -0400
Date: Sun, 5 May 2002 05:04:33 -0700
From: Dec <dec@rm-f.net>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: [PATCH] linux-2.4.19-pre8/fs/ufs/super.c
Message-ID: <20020505050432.A17330@SirDrinkalot.rm-f.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an UFS enabled 2.4.19-pre8 kernel compile problem.
Some printk() calls' format strings and their variable
arguments haven't been properly separated with commas.


--- linux-2.4.19-pre8/fs/ufs/super.c.orig	Sun May  5 14:27:16 2002
+++ linux-2.4.19-pre8/fs/ufs/super.c	Sun May  5 14:21:21 2002
@@ -663,12 +663,12 @@
 		goto failed;
 	}
 	if (uspi->s_bsize < 512) {
-		printk("ufs_read_super: fragment size %u is too small\n"
+		printk("ufs_read_super: fragment size %u is too small\n",
 			uspi->s_fsize);
 		goto failed;
 	}
 	if (uspi->s_bsize > 4096) {
-		printk("ufs_read_super: fragment size %u is too large\n"
+		printk("ufs_read_super: fragment size %u is too large\n",
 			uspi->s_fsize);
 		goto failed;
 	}
@@ -678,12 +678,12 @@
 		goto failed;
 	}
 	if (uspi->s_bsize < 4096) {
-		printk("ufs_read_super: block size %u is too small\n"
+		printk("ufs_read_super: block size %u is too small\n",
 			uspi->s_fsize);
 		goto failed;
 	}
 	if (uspi->s_bsize / uspi->s_fsize > 8) {
-		printk("ufs_read_super: too many fragments per block (%u)\n"
+		printk("ufs_read_super: too many fragments per block (%u)\n",
 			uspi->s_bsize / uspi->s_fsize);
 		goto failed;
 	}

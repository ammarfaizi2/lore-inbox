Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313157AbSEML4n>; Mon, 13 May 2002 07:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313122AbSEML4m>; Mon, 13 May 2002 07:56:42 -0400
Received: from elixir.e.kth.se ([130.237.48.5]:23820 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S313114AbSEML4l>;
	Mon, 13 May 2002 07:56:41 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix typos in fs/ufs/super.c
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 13 May 2002 13:56:41 +0200
Message-ID: <yw1xbsbk1csm.fsf@xq513.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a few typos in fs/ufs/super.c, unless it's already been done.

--- /tmp/linux/fs/ufs/super.c	Mon May 13 13:43:11 2002
+++ super.c	Mon May 13 13:30:17 2002
@@ -662,13 +662,13 @@
 			uspi->s_fsize);
 		goto failed;
 	}
-	if (uspi->s_bsize < 512) {
-		printk("ufs_read_super: fragment size %u is too small\n"
+	if (uspi->s_fsize < 512) {
+		printk("ufs_read_super: fragment size %u is too small\n",
 			uspi->s_fsize);
 		goto failed;
 	}
-	if (uspi->s_bsize > 4096) {
-		printk("ufs_read_super: fragment size %u is too large\n"
+	if (uspi->s_fsize > 4096) {
+		printk("ufs_read_super: fragment size %u is too large\n",
 			uspi->s_fsize);
 		goto failed;
 	}
@@ -678,12 +678,12 @@
 		goto failed;
 	}
 	if (uspi->s_bsize < 4096) {
-		printk("ufs_read_super: block size %u is too small\n"
-			uspi->s_fsize);
+		printk("ufs_read_super: block size %u is too small\n",
+			uspi->s_bsize);
 		goto failed;
 	}
 	if (uspi->s_bsize / uspi->s_fsize > 8) {
-		printk("ufs_read_super: too many fragments per block (%u)\n"
+		printk("ufs_read_super: too many fragments per block (%u)\n",
 			uspi->s_bsize / uspi->s_fsize);
 		goto failed;
 	}



-- 
Måns Rullgård
mru@users.sf.net

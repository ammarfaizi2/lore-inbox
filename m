Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315478AbSECAC4>; Thu, 2 May 2002 20:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315482AbSECACy>; Thu, 2 May 2002 20:02:54 -0400
Received: from horkos.telenet-ops.be ([195.130.132.45]:2534 "EHLO
	horkos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S315478AbSECACL>; Thu, 2 May 2002 20:02:11 -0400
Date: Fri, 3 May 2002 02:02:08 +0200
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] UFS compile fix.
Message-ID: <20020503020208.A6228@ping.be>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Seems that someone forgot to add some commas in ufs/super.c.


Kurt


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ufs.diff"

--- fs/ufs/super.c.bak	Fri May  3 01:53:30 2002
+++ fs/ufs/super.c	Fri May  3 01:53:54 2002
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

--BOKacYhQ+x31HxR3--

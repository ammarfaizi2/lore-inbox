Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315693AbSETBvP>; Sun, 19 May 2002 21:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315695AbSETBvO>; Sun, 19 May 2002 21:51:14 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:65004 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315693AbSETBvN>; Sun, 19 May 2002 21:51:13 -0400
From: Marc-Christian Petersen <mcp@linux-systeme.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.19-pre8 UFS Compile Fix
Date: Mon, 20 May 2002 03:49:23 +0200
X-Mailer: KMail [version 1.4]
Organization: Linux-Systeme GmbH
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Message-Id: <200205200346.06521.mcp@linux-systeme.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_BQZDOH72MMVDRY00QL0F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_BQZDOH72MMVDRY00QL0F
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

UFS isn't buildable with 2.4.19-pre8.
Patch is attached, fixes missing 4 commas.

This is also CC'ed to Marcello.

If this was reported before, i don't get it.

--=20
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/408B2D54947750EC
Fingerprint: 8602 69E0 A9C2 A509 8661  2B0B 408B 2D54 9477 50EC
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.


--------------Boundary-00=_BQZDOH72MMVDRY00QL0F
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ufs-compile-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ufs-compile-fix.patch"

--- linux-jp12/fs/ufs/super.c	Wed May 15 00:27:01 2002
+++ linux/fs/ufs/super.c	Mon May 20 00:32:22 2002
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

--------------Boundary-00=_BQZDOH72MMVDRY00QL0F--



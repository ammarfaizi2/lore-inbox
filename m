Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317257AbSFRA6M>; Mon, 17 Jun 2002 20:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSFRA6K>; Mon, 17 Jun 2002 20:58:10 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:48329 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S317257AbSFRA5w>;
	Mon, 17 Jun 2002 20:57:52 -0400
Date: Tue, 18 Jun 2002 02:57:53 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200206180057.CAA11561@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.22] typo in fs/ufs/super.c:ufs_fill_super()
Cc: trivial@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Obvious typo: checking block size but printing fragment size.

/Mikael

--- linux-2.5.22/fs/ufs/super.c.~1~	Thu May 30 16:33:02 2002
+++ linux-2.5.22/fs/ufs/super.c	Tue Jun 18 00:40:08 2002
@@ -673,7 +673,7 @@
 	}
 	if (uspi->s_bsize < 4096) {
 		printk("ufs_read_super: block size %u is too small\n",
-			uspi->s_fsize);
+			uspi->s_bsize);
 		goto failed;
 	}
 	if (uspi->s_bsize / uspi->s_fsize > 8) {

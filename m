Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263044AbUJ1Wbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263044AbUJ1Wbn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 18:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUJ1W2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 18:28:51 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32527 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263097AbUJ1WZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 18:25:15 -0400
Date: Fri, 29 Oct 2004 00:24:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: shaggy@austin.ibm.com
Cc: jfs-discussion@oss.software.ibm.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] jfs_metapage.c: remove an unused function
Message-ID: <20041028222444.GQ3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from fs/jfs/jfs_metapage.c


diffstat output:
 fs/jfs/jfs_metapage.c |    5 -----
 1 files changed, 5 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/fs/jfs/jfs_metapage.c.old	2004-10-28 22:41:29.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/fs/jfs/jfs_metapage.c	2004-10-28 22:41:42.000000000 +0200
@@ -108,11 +108,6 @@
 	}
 }
 
- -static inline struct metapage *alloc_metapage(int no_wait)
- -{
- -	return mempool_alloc(metapage_mempool, no_wait ? GFP_ATOMIC : GFP_NOFS);
- -}
- -
 static inline void free_metapage(struct metapage *mp)
 {
 	mp->flag = 0;

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgXGsmfzqmE8StAARApqPAKCKO56icieQVYa4/2bVv9QATXy3wgCgpuxF
r2f/jTAlTJE1y4PwstB9aLU=
=O6wB
-----END PGP SIGNATURE-----

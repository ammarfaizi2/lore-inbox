Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbUJ1XOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbUJ1XOO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbUJ1XNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:13:53 -0400
Received: from zeus.kernel.org ([204.152.189.113]:18130 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263025AbUJ1XL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:11:27 -0400
Date: Fri, 29 Oct 2004 01:09:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: neilb@cse.unsw.edu.au
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] NFS: remove an unused function
Message-ID: <20041028230948.GA3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from fs/nfsd/nfs3xdr.c


diffstat output:
 fs/nfsd/nfs3xdr.c |   16 ----------------
 1 files changed, 16 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/fs/nfsd/nfs3xdr.c.old	2004-10-28 22:42:11.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/fs/nfsd/nfs3xdr.c	2004-10-28 22:42:25.000000000 +0200
@@ -102,22 +102,6 @@
 }
 
 static inline u32 *
- -decode_pathname(u32 *p, char **namp, int *lenp)
- -{
- -	char		*name;
- -	int		i;
- -
- -	if ((p = xdr_decode_string_inplace(p, namp, lenp, NFS3_MAXPATHLEN)) != NULL) {
- -		for (i = 0, name = *namp; i < *lenp; i++, name++) {
- -			if (*name == '\0')
- -				return NULL;
- -		}
- -	}
- -
- -	return p;
- -}
- -
- -static inline u32 *
 decode_sattr3(u32 *p, struct iattr *iap)
 {
 	u32	tmp;

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgXw8mfzqmE8StAARAmywAJ9mfv9fbjzamV3AmhVvOfSzoq38/wCdF6a+
5uGTDApcyBwpTZQRPsHnWdQ=
=K4wS
-----END PGP SIGNATURE-----

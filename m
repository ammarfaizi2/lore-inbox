Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbULFXHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbULFXHq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 18:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbULFXFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 18:05:08 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39685 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261692AbULFXCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 18:02:53 -0500
Date: Tue, 7 Dec 2004 00:02:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: neilb@cse.unsw.edu.au, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] NFS: remove an unused function (fwd)
Message-ID: <20041206230249.GS7250@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm4.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Fri, 29 Oct 2004 02:23:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: neilb@cse.unsw.edu.au
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] NFS: remove an unused function

The patch below removes an unused function from fs/nfsd/nfs3xdr.c


diffstat output:
 fs/nfsd/nfs3xdr.c |   16 ----------------
 1 files changed, 16 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/fs/nfsd/nfs3xdr.c.old	2004-10-28 22:42:11.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/fs/nfsd/nfs3xdr.c	2004-10-28 22:42:25.000000000 +0200
@@ -102,22 +102,6 @@
 }
 
 static inline u32 *
-decode_pathname(u32 *p, char **namp, int *lenp)
-{
-	char		*name;
-	int		i;
-
-	if ((p = xdr_decode_string_inplace(p, namp, lenp, NFS3_MAXPATHLEN)) != NULL) {
-		for (i = 0, name = *namp; i < *lenp; i++, name++) {
-			if (*name == '\0')
-				return NULL;
-		}
-	}
-
-	return p;
-}
-
-static inline u32 *
 decode_sattr3(u32 *p, struct iattr *iap)
 {
 	u32	tmp;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVDKUFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVDKUFN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVDKUFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:05:13 -0400
Received: from mail.dif.dk ([193.138.115.101]:52420 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261912AbVDKUEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:04:45 -0400
Date: Mon, 11 Apr 2005 22:07:23 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steven French <sfrench@us.ibm.com>
Cc: Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cifs: md4 cleanup - long lines and spaces
Message-ID: <Pine.LNX.4.62.0504112205340.2480@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove blank line, break long lines and line up two lines.

Patch is also available here:
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_md4-lines-and-spaces.patch


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc2-mm2/fs/cifs/md4.c.with_patch1	2005-04-09 10:07:28.000000000 +0200
+++ linux-2.6.12-rc2-mm2/fs/cifs/md4.c	2005-04-09 10:12:41.000000000 +0200
@@ -47,8 +47,10 @@ static __u32 lshift(__u32 x, int s)
 }
 
 #define ROUND1(a,b,c,d,k,s) (*a) = lshift((*a) + F(*b,*c,*d) + X[k], s)
-#define ROUND2(a,b,c,d,k,s) (*a) = lshift((*a) + G(*b,*c,*d) + X[k] + (__u32)0x5A827999,s)
-#define ROUND3(a,b,c,d,k,s) (*a) = lshift((*a) + H(*b,*c,*d) + X[k] + (__u32)0x6ED9EBA1,s)
+#define ROUND2(a,b,c,d,k,s) (*a) = lshift((*a) + G(*b,*c,*d) + X[k] \
+					  + (__u32)0x5A827999,s)
+#define ROUND3(a,b,c,d,k,s) (*a) = lshift((*a) + H(*b,*c,*d) + X[k] \
+					  + (__u32)0x6ED9EBA1,s)
 
 /* this applies md4 to 64 byte chunks */
 static void mdfour64(__u32 *M, __u32 *A, __u32 *B, __u32 *C, __u32 *D)
@@ -57,7 +59,6 @@ static void mdfour64(__u32 *M, __u32 *A,
 	__u32 AA, BB, CC, DD;
 	__u32 X[16];
 
-
 	for (j = 0; j < 16; j++)
 		X[j] = M[j];
 
@@ -137,7 +138,7 @@ static void copy64(__u32 *M, unsigned ch
 
 	for (i = 0; i < 16; i++)
 		M[i] = (in[i * 4 + 3] << 24) | (in[i * 4 + 2] << 16) |
-		    (in[i * 4 + 1] << 8) | (in[i * 4 + 0] << 0);
+		       (in[i * 4 + 1] << 8) | (in[i * 4 + 0] << 0);
 }
 
 static void copy4(unsigned char *out, __u32 x)



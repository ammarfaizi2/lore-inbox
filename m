Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbTAJGCE>; Fri, 10 Jan 2003 01:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbTAJGCE>; Fri, 10 Jan 2003 01:02:04 -0500
Received: from dp.samba.org ([66.70.73.150]:49123 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262838AbTAJGCD>;
	Fri, 10 Jan 2003 01:02:03 -0500
Date: Fri, 10 Jan 2003 17:11:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [TRIVIAL] Squash unused function in fs/nfs/mount_clnt.c
Message-ID: <20030110061144.GM19829@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  The xdr_error() function in fs/nfs/mount_clnt.c
is never used, so this patch removes it.

diff -urN /home/dgibson/kernel/linuxppc-2.5/fs/nfs/mount_clnt.c linux-bluefish/fs/nfs/mount_clnt.c
--- /home/dgibson/kernel/linuxppc-2.5/fs/nfs/mount_clnt.c	2002-12-04 10:58:01.000000000 +1100
+++ linux-bluefish/fs/nfs/mount_clnt.c	2003-01-10 16:43:03.000000000 +1100
@@ -93,12 +93,6 @@
  * XDR encode/decode functions for MOUNT
  */
 static int
-xdr_error(struct rpc_rqst *req, u32 *p, void *dummy)
-{
-	return -EIO;
-}
-
-static int
 xdr_encode_dirpath(struct rpc_rqst *req, u32 *p, const char *path)
 {
 	p = xdr_encode_string(p, path);


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

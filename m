Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269330AbUJQXRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269330AbUJQXRa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 19:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269329AbUJQXR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 19:17:29 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41477 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269325AbUJQXQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 19:16:30 -0400
Date: Mon, 18 Oct 2004 01:15:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Mark Goodman <mgoodman@CSUA.Berkeley.EDU>, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fix NFS3 krb5 clients on x86-64 (fwd)
Message-ID: <20041017231557.GP2466@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below by Mark Goodman (already ACK'ed bt Trond) still applies 
against both 2.6.9-rc4 and 2.6.9-rc4-mm1.

I've rediffed it since the original patch seems to have suffered from 
some whitespace damage.



----- Forwarded message from Mark Goodman <mgoodman@CSUA.Berkeley.EDU> -----

Date:	Mon, 20 Sep 2004 18:32:50 -0700
From: Mark Goodman <mgoodman@CSUA.Berkeley.EDU>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix NFS3 krb5 clients on x86-64

This patch is necessary to make NFS3 krb5 clients work on x86-64. It 
applies to 2.6.9-rc2. Please apply.

Signed-off-by: Mark Goodman <mgoodman@csua.berkeley.edu>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.9-rc4-full/net/sunrpc/auth_gss/auth_gss.c.old	2004-10-18 01:06:10.000000000 +0200
+++ linux-2.6.9-rc4-full/net/sunrpc/auth_gss/auth_gss.c	2004-10-18 01:08:14.000000000 +0200
@@ -246,7 +246,7 @@
 	spin_lock_init(&ctx->gc_seq_lock);
 	atomic_set(&ctx->count,1);
 
-	if (simple_get_bytes(&p, end, uid, sizeof(uid)))
+	if (simple_get_bytes(&p, end, uid, sizeof(*uid)))
 		goto err_free_ctx;
 	/* FIXME: discarded timeout for now */
 	if (simple_get_bytes(&p, end, &timeout, sizeof(timeout)))

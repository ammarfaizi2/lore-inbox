Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVB0Rts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVB0Rts (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 12:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVB0RsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 12:48:02 -0500
Received: from mail.suse.de ([195.135.220.2]:9379 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261457AbVB0RXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 12:23:04 -0500
Message-Id: <20050227170312.031622000@blunzn.suse.de>
References: <20050227165954.566746000@blunzn.suse.de>
Date: Sun, 27 Feb 2005 17:59:58 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
Subject: [nfsacl v2 04/16] Add missing -EOPNOTSUPP => NFS3ERR_NOTSUPP mapping in nfsd
Content-Disposition: inline; filename=nfsacl-add-missing-eopnotsupp-=-nfs3err_notsupp-mapping-in-nfsd.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing NFS3ERR_NOTSUPP error code (defined in NFSv3) to the
system-to-protocol-error table in nfsd.  The nfsacl extension uses this error
code.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
Signed-off-by: Olaf Kirch <okir@suse.de>

Index: linux-2.6.11-rc5/fs/nfsd/nfsproc.c
===================================================================
--- linux-2.6.11-rc5.orig/fs/nfsd/nfsproc.c
+++ linux-2.6.11-rc5/fs/nfsd/nfsproc.c
@@ -590,6 +590,7 @@ nfserrno (int errno)
 		{ nfserr_dropit, -EAGAIN },
 		{ nfserr_dropit, -ENOMEM },
 		{ nfserr_badname, -ESRCH },
+		{ nfserr_notsupp, -EOPNOTSUPP },
 		{ -1, -EIO }
 	};
 	int	i;

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH


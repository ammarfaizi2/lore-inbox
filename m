Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVB0P7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVB0P7M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 10:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVB0P5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 10:57:30 -0500
Received: from news.suse.de ([195.135.220.2]:22484 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261419AbVB0P4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 10:56:55 -0500
Message-Id: <20050227152350.480929000@blunzn.suse.de>
References: <20050227152243.083308000@blunzn.suse.de>
Date: Sun, 27 Feb 2005 16:22:47 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch 04/16] Add missing -EOPNOTSUPP => NFS3ERR_NOTSUPP mapping in nfsd
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
@@ -591,6 +591,7 @@ nfserrno (int errno)
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


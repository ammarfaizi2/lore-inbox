Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVAVUgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVAVUgU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 15:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVAVUgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 15:36:01 -0500
Received: from ns.suse.de ([195.135.220.2]:45264 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262727AbVAVUea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 15:34:30 -0500
Message-Id: <20050122203619.162776000@blunzn.suse.de>
References: <20050122203326.402087000@blunzn.suse.de>
Date: Sat, 22 Jan 2005 21:34:03 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: [patch 3/13] Add missing -EOPNOTSUPP => NFS3ERR_NOTSUPP mapping in nfsd
Content-Disposition: inline; filename=patches.suse/sunrpc-enotsupp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing NFS3ERR_NOTSUPP error code (defined in NFSv3) to the
system-to-protocol-error table in nfsd. The nfsacl extension uses
this error code.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
Signed-off-by: Olaf Kirch <okir@suse.de>

Index: linux-2.6.11-rc2/fs/nfsd/nfsproc.c
===================================================================
--- linux-2.6.11-rc2.orig/fs/nfsd/nfsproc.c
+++ linux-2.6.11-rc2/fs/nfsd/nfsproc.c
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


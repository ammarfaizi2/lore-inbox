Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbTDTSTn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 14:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263658AbTDTSTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 14:19:43 -0400
Received: from hera.cwi.nl ([192.16.191.8]:8122 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263653AbTDTSTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 14:19:41 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 20 Apr 2003 20:31:40 +0200 (MEST)
Message-Id: <UTC200304201831.h3KIVe118127.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] compilation fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two compiler warnings for compilation of nfs4proc.c.

diff -u --recursive --new-file -X /linux/dontdiff a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
--- a/fs/nfsd/nfs4proc.c	Sun Apr 20 12:59:32 2003
+++ b/fs/nfsd/nfs4proc.c	Sun Apr 20 20:10:52 2003
@@ -51,6 +51,7 @@
 #include <linux/nfsd/cache.h>
 #include <linux/nfs4.h>
 #include <linux/nfsd/xdr4.h>
+#include <linux/nfsd/state.h>
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/nfsd/xdr4.h b/include/linux/nfsd/xdr4.h
--- a/include/linux/nfsd/xdr4.h	Mon Feb 24 23:02:57 2003
+++ b/include/linux/nfsd/xdr4.h	Sun Apr 20 20:10:10 2003
@@ -344,6 +344,7 @@
 int nfsd4_encode_fattr(struct svc_fh *fhp, struct svc_export *exp,
 		       struct dentry *dentry, u32 *buffer, int *countp, u32 *bmval);
 
+int nfsd4_setclientid_confirm(struct svc_rqst *, struct nfsd4_setclientid_confirm *);
 #endif
 
 /*

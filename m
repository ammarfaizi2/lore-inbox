Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWJJDNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWJJDNF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWJJDMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:12:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:22189 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964824AbWJJDMb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:12:31 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 12/25] nfs_common endianness annotations
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX82h-0004Dx-5S@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:12:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs_common/nfsacl.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs_common/nfsacl.c b/fs/nfs_common/nfsacl.c
index 0c2be8c..c11f537 100644
--- a/fs/nfs_common/nfsacl.c
+++ b/fs/nfs_common/nfsacl.c
@@ -46,7 +46,7 @@ xdr_nfsace_encode(struct xdr_array2_desc
 {
 	struct nfsacl_encode_desc *nfsacl_desc =
 		(struct nfsacl_encode_desc *) desc;
-	u32 *p = (u32 *) elem;
+	__be32 *p = elem;
 
 	struct posix_acl_entry *entry =
 		&nfsacl_desc->acl->a_entries[nfsacl_desc->count++];
@@ -127,7 +127,7 @@ xdr_nfsace_decode(struct xdr_array2_desc
 {
 	struct nfsacl_decode_desc *nfsacl_desc =
 		(struct nfsacl_decode_desc *) desc;
-	u32 *p = (u32 *) elem;
+	__be32 *p = elem;
 	struct posix_acl_entry *entry;
 
 	if (!nfsacl_desc->acl) {
-- 
1.4.2.GIT



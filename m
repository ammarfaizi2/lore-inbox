Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbULPBxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbULPBxp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbULPAys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:54:48 -0500
Received: from mail.dif.dk ([193.138.115.101]:44196 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262572AbULPA06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:26:58 -0500
Date: Thu, 16 Dec 2004 01:37:24 +0100 (CET)
From: Jesper Juhl <juhl@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 23/30] return statement cleanup - kill pointless parentheses
 in fs/nfsd/nfs4state.c
Message-ID: <Pine.LNX.4.61.0412160136380.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
fs/nfsd/nfs4state.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/fs/nfsd/nfs4state.c	2004-12-06 22:24:44.000000000 +0100
+++ linux-2.6.10-rc3-bk8/fs/nfsd/nfs4state.c	2004-12-15 23:54:04.000000000 +0100
@@ -267,24 +267,24 @@ static int
 cmp_name(struct xdr_netobj *n1, struct xdr_netobj *n2) {
 	if (!n1 || !n2)
 		return 0;
-	return((n1->len == n2->len) && !memcmp(n1->data, n2->data, n2->len));
+	return ((n1->len == n2->len) && !memcmp(n1->data, n2->data, n2->len));
 }
 
 static int
 cmp_verf(nfs4_verifier *v1, nfs4_verifier *v2) {
-	return(!memcmp(v1->data,v2->data,sizeof(v1->data)));
+	return !memcmp(v1->data,v2->data,sizeof(v1->data));
 }
 
 static int
 cmp_clid(clientid_t * cl1, clientid_t * cl2) {
-	return((cl1->cl_boot == cl2->cl_boot) &&
+	return ((cl1->cl_boot == cl2->cl_boot) &&
 	   	(cl1->cl_id == cl2->cl_id));
 }
 
 /* XXX what about NGROUP */
 static int
 cmp_creds(struct svc_cred *cr1, struct svc_cred *cr2){
-	return(cr1->cr_uid == cr2->cr_uid);
+	return (cr1->cr_uid == cr2->cr_uid);
 
 }
 
@@ -1034,7 +1034,7 @@ find_openstateowner_str(unsigned int has
 		if (!cmp_owner_str(local, &open->op_owner, &open->op_clientid))
 			continue;
 		*op = local;
-		return(1);
+		return 1;
 	}
 	return 0;
 }
@@ -1064,7 +1064,7 @@ find_file(unsigned int hashval, struct i
 	list_for_each_entry(local, &file_hashtbl[hashval], fi_hash) {
 		if (local->fi_inode == ino) {
 			*fp = local;
-			return(1);
+			return 1;
 		}
 	}
 	return 0;
@@ -2040,7 +2040,7 @@ find_lockstateowner_str(unsigned int has
 		if (!cmp_owner_str(local, owner, clid))
 			continue;
 		*op = local;
-		return(1);
+		return 1;
 	}
 	*op = NULL;
 	return 0;




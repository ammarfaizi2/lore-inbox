Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWJJDM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWJJDM1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWJJDM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:12:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:21421 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964904AbWJJDMV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:12:21 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 11/25] xdr annotations: mount_clnt
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX82X-0004De-3N@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:12:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[pulled from Alexey's patch]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/mount_clnt.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/mount_clnt.c b/fs/nfs/mount_clnt.c
index d507b02..f75fe72 100644
--- a/fs/nfs/mount_clnt.c
+++ b/fs/nfs/mount_clnt.c
@@ -95,7 +95,7 @@ mnt_create(char *hostname, struct sockad
  * XDR encode/decode functions for MOUNT
  */
 static int
-xdr_encode_dirpath(struct rpc_rqst *req, u32 *p, const char *path)
+xdr_encode_dirpath(struct rpc_rqst *req, __be32 *p, const char *path)
 {
 	p = xdr_encode_string(p, path);
 
@@ -104,7 +104,7 @@ xdr_encode_dirpath(struct rpc_rqst *req,
 }
 
 static int
-xdr_decode_fhstatus(struct rpc_rqst *req, u32 *p, struct mnt_fhstatus *res)
+xdr_decode_fhstatus(struct rpc_rqst *req, __be32 *p, struct mnt_fhstatus *res)
 {
 	struct nfs_fh *fh = res->fh;
 
@@ -116,7 +116,7 @@ xdr_decode_fhstatus(struct rpc_rqst *req
 }
 
 static int
-xdr_decode_fhstatus3(struct rpc_rqst *req, u32 *p, struct mnt_fhstatus *res)
+xdr_decode_fhstatus3(struct rpc_rqst *req, __be32 *p, struct mnt_fhstatus *res)
 {
 	struct nfs_fh *fh = res->fh;
 
-- 
1.4.2.GIT



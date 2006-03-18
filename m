Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWCRSpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWCRSpf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 13:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWCRSpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 13:45:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46863 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750796AbWCRSpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 13:45:18 -0500
Date: Sat, 18 Mar 2006 19:45:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] nfs4proc.c: make _nfs4_proc_setclientid_confirm() static
Message-ID: <20060318184517.GF14608@stusta.de>
References: <20060318044056.350a2931.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060318044056.350a2931.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 04:40:56AM -0800, Andrew Morton wrote:
>...
> Boilerplate:
>...
> Changes since 2.6.16-rc6-mm1:
>...
>  git-nfs.patch
>...
>  git trees.
>...


This patch makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc6-mm2-full/fs/nfs/nfs4proc.c.old	2006-03-18 18:40:47.000000000 +0100
+++ linux-2.6.16-rc6-mm2-full/fs/nfs/nfs4proc.c	2006-03-18 18:41:01.000000000 +0100
@@ -2849,7 +2849,8 @@
 	return status;
 }
 
-int _nfs4_proc_setclientid_confirm(struct nfs4_client *clp, struct rpc_cred *cred)
+static int _nfs4_proc_setclientid_confirm(struct nfs4_client *clp,
+					  struct rpc_cred *cred)
 {
 	struct nfs_fsinfo fsinfo;
 	struct rpc_message msg = {


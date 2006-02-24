Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWBXUuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWBXUuy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWBXUuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:50:01 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:28449 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932488AbWBXUt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:49:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=N2C0hoOKtwJqJojQ366/9bml5cJBsnZhgh7ZGztsjpDsDvi7D7hzqBM0YhaHCaweqH2S4KWSPRhxSccoO7hLoEBxeEZrDVIn1ghDaUeQ1Uc3zIpYgVUmt0IA3/ilDrHf/jsJmqlhe6UEhJ2aLNnGXFqFAy+8BuzIJRARa/0L/qk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 12/13] "const static" vs "static const" in nfs4
Date: Fri, 24 Feb 2006 21:49:42 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Kendrick Smith <kmsmith@umich.edu>,
       Andy Adamson <andros@umich.edu>, neilb@cse.unsw.edu.au,
       trond.myklebust@fys.uio.no, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602242149.42735.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My previous "const static" vs "static const" cleanup missed a single case,
patch below takes care of it.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/nfs/nfs4proc.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16-rc4-mm2-orig/fs/nfs/nfs4proc.c	2006-02-24 19:25:39.000000000 +0100
+++ linux-2.6.16-rc4-mm2/fs/nfs/nfs4proc.c	2006-02-24 19:38:28.000000000 +0100
@@ -2958,7 +2958,7 @@ static void nfs4_delegreturn_release(voi
 	kfree(calldata);
 }
 
-const static struct rpc_call_ops nfs4_delegreturn_ops = {
+static const struct rpc_call_ops nfs4_delegreturn_ops = {
 	.rpc_call_prepare = nfs4_delegreturn_prepare,
 	.rpc_call_done = nfs4_delegreturn_done,
 	.rpc_release = nfs4_delegreturn_release,

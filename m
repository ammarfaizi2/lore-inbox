Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVCWXja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVCWXja (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbVCWXj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:39:29 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46095 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262104AbVCWXhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:37:22 -0500
Date: Thu, 24 Mar 2005 00:37:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/nfs/nfs4proc.c: small simplification
Message-ID: <20050323233718.GE1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker noticed that such a simplification was possible.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/fs/nfs/nfs4proc.c.old	2005-03-23 00:56:05.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/fs/nfs/nfs4proc.c	2005-03-23 00:56:29.000000000 +0100
@@ -124,7 +124,7 @@
 
 	BUG_ON(readdir->count < 80);
 	if (cookie > 2) {
-		readdir->cookie = (cookie > 2) ? cookie : 0;
+		readdir->cookie = cookie;
 		memcpy(&readdir->verifier, verifier, sizeof(readdir->verifier));
 		return;
 	}


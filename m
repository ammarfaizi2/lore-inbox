Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVARK3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVARK3g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 05:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVARK3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 05:29:36 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63239 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261212AbVARK3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 05:29:34 -0500
Date: Tue, 18 Jan 2005 11:29:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport xfrm_policy_delete
Message-ID: <20050118102932.GD4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't found any way how xfrm_policy_delete could be called from 
modular code in 2.6.11-rc1-mm1.

Unless I'm wrong or a patch for a modular usage is pending, I'm 
therefore suggesting this patch for removing the EXPORT_SYMBOL.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc1-mm1-full/net/xfrm/xfrm_policy.c.old	2005-01-18 11:11:34.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/net/xfrm/xfrm_policy.c	2005-01-18 11:11:39.000000000 +0100
@@ -549,8 +549,6 @@
 	}
 }
 
-EXPORT_SYMBOL(xfrm_policy_delete);
-
 int xfrm_sk_policy_insert(struct sock *sk, int dir, struct xfrm_policy *pol)
 {
 	struct xfrm_policy *old_pol;


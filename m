Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161132AbWJPWAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161132AbWJPWAz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 18:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161129AbWJPWAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 18:00:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:29836 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161135AbWJPWAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 18:00:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=aPjdxmwl6m1jqS/guKMJVCHFG9Vi+eiyJxkofj8kGJgLvOb0xf/1ua/1z0WDpVFjfNvf9qonT7Fu8KTUydEbcO6yiUtXACzb7dOPMdR3nsmyycFTKG+zsM3zi04OY1XyuUKSfA/4Zgw/+yG26cVXyBAsdzxIXZU2XWCdcMsfhCs=
Date: Tue, 17 Oct 2006 00:01:10 +0200
From: Luca Tettamanti <kronos.it@gmail.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19-git] Add missing space to 'license taints' message
Message-ID: <20061016220110.GA17398@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing space to the printk which is emitted when a proprietary
module is loaded.

Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>

---
 kernel/module.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index 67009bd..73a1f52 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1343,7 +1343,7 @@ static void set_license(struct module *m
 	if (!license_is_gpl_compatible(license)) {
 		if (!(tainted & TAINT_PROPRIETARY_MODULE))
 			printk(KERN_WARNING "%s: module license '%s' taints"
-				"kernel.\n", mod->name, license);
+				" kernel.\n", mod->name, license);
 		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
 	}
 }


Luca
-- 
La somma dell'intelligenza sulla terra e` una costante.
La popolazione e` in aumento.

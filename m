Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263041AbVHEPDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbVHEPDL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVHEOxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:53:53 -0400
Received: from fep17.inet.fi ([194.251.242.242]:23022 "EHLO fep17.inet.fi")
	by vger.kernel.org with ESMTP id S262619AbVHEOu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:50:59 -0400
Subject: [PATCH 2/8] PPC64: convert kcalloc to kzalloc
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ikr7iw.uglatv.4r37ksk0wcjz57bhrrhj6ed0q.beaver@cs.helsinki.fi>
In-Reply-To: <ikr7ik.g8r0if.7zlmvh7aipic7kgaf0b9j68ie.beaver@cs.helsinki.fi>
Date: Fri, 5 Aug 2005 17:50:57 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts kcalloc(1, ...) calls to use the new kzalloc() function.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 pSeries_reconfig.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: 2.6/arch/ppc64/kernel/pSeries_reconfig.c
===================================================================
--- 2.6.orig/arch/ppc64/kernel/pSeries_reconfig.c
+++ 2.6/arch/ppc64/kernel/pSeries_reconfig.c
@@ -111,7 +111,7 @@ static int pSeries_reconfig_add_node(con
 	struct device_node *np;
 	int err = -ENOMEM;
 
-	np = kcalloc(1, sizeof(*np), GFP_KERNEL);
+	np = kzalloc(sizeof(*np), GFP_KERNEL);
 	if (!np)
 		goto out_err;
 

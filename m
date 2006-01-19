Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161328AbWASTGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161328AbWASTGP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161327AbWASTGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:06:15 -0500
Received: from ns1.coraid.com ([65.14.39.133]:13992 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1161324AbWASTGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:06:14 -0500
Message-ID: <7ce8c2ff3f32c0c3c3f321eee27958f3@coraid.com>
Date: Thu, 19 Jan 2006 13:46:20 -0500
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.15-git9] aoe [3/8]: increase allowed outstanding packets
From: "Ed L. Cashin" <ecashin@coraid.com>
References: <E1EzelK-0006sT-00@kokone>
Gcc: nnfolder:Mail/sent-200601
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Increase the number of AoE packets per device that can be outstanding
at one time, increasing performance.

diff -upr 2.6.15-git9-orig/drivers/block/aoe/aoecmd.c 2.6.15-git9-aoe/drivers/block/aoe/aoecmd.c
--- 2.6.15-git9-orig/drivers/block/aoe/aoecmd.c	2006-01-19 13:31:22.000000000 -0500
+++ 2.6.15-git9-aoe/drivers/block/aoe/aoecmd.c	2006-01-19 13:31:22.000000000 -0500
@@ -647,7 +647,7 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 	ulong flags, sysminor, aoemajor;
 	u16 bufcnt;
 	struct sk_buff *sl;
-	enum { MAXFRAMES = 8 };
+	enum { MAXFRAMES = 16 };
 
 	h = (struct aoe_hdr *) skb->mac.raw;
 	ch = (struct aoe_cfghdr *) (h+1);


-- 
  "Ed L. Cashin" <ecashin@coraid.com>

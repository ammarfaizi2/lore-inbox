Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWACV3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWACV3i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWACV3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:29:36 -0500
Received: from ns1.coraid.com ([65.14.39.133]:58825 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1751485AbWACV3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:29:33 -0500
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.15-rc7] aoe [3/7]: increase allowed outstanding packets
From: "Ed L. Cashin" <ecashin@coraid.com>
References: <87hd8l2fb4.fsf@coraid.com>
Date: Tue, 03 Jan 2006 16:07:55 -0500
Message-ID: <87aced10lw.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Increase the number of AoE packets per device that can be outstanding
at one time, increasing performance.

Index: 2.6.15-rc7-aoe/drivers/block/aoe/aoecmd.c
===================================================================
--- 2.6.15-rc7-aoe.orig/drivers/block/aoe/aoecmd.c	2006-01-02 13:35:13.000000000 -0500
+++ 2.6.15-rc7-aoe/drivers/block/aoe/aoecmd.c	2006-01-02 13:35:14.000000000 -0500
@@ -655,7 +655,7 @@
 	ulong flags, sysminor, aoemajor;
 	u16 bufcnt;
 	struct sk_buff *sl;
-	enum { MAXFRAMES = 8 };
+	enum { MAXFRAMES = 16 };
 
 	h = (struct aoe_hdr *) skb->mac.raw;
 	ch = (struct aoe_cfghdr *) (h+1);


-- 
  Ed L. Cashin <ecashin@coraid.com>


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272689AbTHKOGg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272610AbTHKNmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:42:50 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:36491 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272609AbTHKNk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:40:58 -0400
To: torvalds@transmeta.com
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FusionMPT 64bit fixup
Message-Id: <E19mCuP-0003dm-00@tetrachloride>
Date: Mon, 11 Aug 2003 14:40:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/message/fusion/mptbase.c linux-2.5/drivers/message/fusion/mptbase.c
--- bk-linus/drivers/message/fusion/mptbase.c	2003-06-15 12:24:58.000000000 +0100
+++ linux-2.5/drivers/message/fusion/mptbase.c	2003-07-16 19:24:47.000000000 +0100
@@ -1279,7 +1279,7 @@ mpt_adapter_install(struct pci_dev *pdev
 	u32		 psize;
 	int		 ii;
 	int		 r = -ENODEV;
-	u64		 mask = 0xffffffffffffffff;
+	u64		 mask = 0xffffffffffffffffULL;
 
 	if (pci_enable_device(pdev))
 		return r;

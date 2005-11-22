Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbVKVCVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbVKVCVs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 21:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbVKVCVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 21:21:48 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:17092 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S964867AbVKVCVr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 21:21:47 -0500
Date: Tue, 22 Nov 2005 03:21:42 +0100 (MET)
From: Richard Knutsson <ricknu-0@student.ltu.se>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Richard Knutsson <ricknu-0@student.ltu.se>
Message-Id: <20051122022652.6806.10075.sendpatchset@thinktank.campus.ltu.se>
Subject: [PATCH -mm2] net: Fix compiler-error on atyfb_base.c when !CONFIG_PCI
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Fix compiler-error on atyfb_base.c when CONFIG_PCI not set.

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

 atyfb_base.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -Narup a/drivers/net/dgrs.c b/drivers/net/dgrs.c
--- a/drivers/video/aty/atyfb_base.c	2005-11-22 01:41:54.000000000 +0100
+++ b/drivers/video/aty/atyfb_base.c	2005-11-22 01:42:15.000000000 +0100
@@ -3606,7 +3606,8 @@ static struct pci_driver atyfb_driver = 
 	.resume		= atyfb_pci_resume,
 #endif /* CONFIG_PM */
 };
-
+#else
+static struct pci_driver atyfb_driver = {};
 #endif /* CONFIG_PCI */
 
 #ifndef MODULE

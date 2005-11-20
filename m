Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbVKTBjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVKTBjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 20:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVKTBjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 20:39:08 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:20898 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751127AbVKTBjH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 20:39:07 -0500
Date: Sun, 20 Nov 2005 02:39:00 +0100 (MET)
From: Richard Knutsson <ricknu-0@student.ltu.se>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Richard Knutsson <ricknu-0@student.ltu.se>
Message-Id: <20051120014408.20407.66374.sendpatchset@thinktank.campus.ltu.se>
Subject: [PATCH -mm2] net: Fix compiler-error on dgrs.c when !CONFIG_PCI
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Fix compiler-error on dgrs.c when CONFIG_PCI not set.

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

 dgrs.c |    2 ++
 1 files changed, 2 insertions(+)

diff -Narup a/drivers/net/dgrs.c b/drivers/net/dgrs.c
--- a/drivers/net/dgrs.c	2005-11-19 20:17:51.000000000 +0100
+++ b/drivers/net/dgrs.c	2005-11-19 20:29:52.000000000 +0100
@@ -1458,6 +1458,8 @@ static struct pci_driver dgrs_pci_driver
 	.probe = dgrs_pci_probe,
 	.remove = __devexit_p(dgrs_pci_remove),
 };
+#else
+static struct pci_driver dgrs_pci_driver = {};
 #endif
 
 

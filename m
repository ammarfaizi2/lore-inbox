Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbVK2X7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbVK2X7Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 18:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbVK2X7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 18:59:16 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:27331 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751408AbVK2X7Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 18:59:16 -0500
Date: Wed, 30 Nov 2005 00:59:14 +0100 (MET)
From: Richard Knutsson <ricknu-0@student.ltu.se>
To: linux-kernel@vger.kernel.org
Cc: Richard Knutsson <ricknu-0@student.ltu.se>
Message-Id: <20051130000425.1009.94647.sendpatchset@thinktank.campus.ltu.se>
Subject: [PATCH 1/6] arch: Replace pci_module_init() with pci_register_driver()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Replace obsolete pci_module_init() with pci_register_driver().

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

 i386/kernel/scx200.c         |    2 +-
 mips/vr41xx/common/vrc4173.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -Narup a/arch/i386/kernel/scx200.c b/arch/i386/kernel/scx200.c
--- a/arch/i386/kernel/scx200.c	2005-11-29 11:08:42.000000000 +0100
+++ b/arch/i386/kernel/scx200.c	2005-11-29 16:29:34.000000000 +0100
@@ -143,7 +143,7 @@ static int __init scx200_init(void)
 {
 	printk(KERN_INFO NAME ": NatSemi SCx200 Driver\n");
 
-	return pci_module_init(&scx200_pci_driver);
+	return pci_register_driver(&scx200_pci_driver);
 }
 
 static void __exit scx200_cleanup(void)
diff -Narup a/arch/mips/vr41xx/common/vrc4173.c b/arch/mips/vr41xx/common/vrc4173.c
--- a/arch/mips/vr41xx/common/vrc4173.c	2005-11-29 11:08:45.000000000 +0100
+++ b/arch/mips/vr41xx/common/vrc4173.c	2005-11-29 16:30:33.000000000 +0100
@@ -561,7 +561,7 @@ static int __devinit vrc4173_init(void)
 {
 	int err;
 
-	err = pci_module_init(&vrc4173_driver);
+	err = pci_register_driver(&vrc4173_driver);
 	if (err < 0)
 		return err;
 

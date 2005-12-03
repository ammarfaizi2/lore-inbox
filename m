Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbVLCP7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVLCP7s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 10:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVLCP5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 10:57:19 -0500
Received: from covilha.procergs.com.br ([200.198.128.244]:45005 "EHLO
	covilha.procergs.com.br") by vger.kernel.org with ESMTP
	id S1751281AbVLCP5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 10:57:17 -0500
Cc: Otavio Salvador <otavio@debian.org>
Subject: [PATCH 6/11] i386: replace all uses of pci_module_init with pci_register_driver
In-Reply-To: <11336254304109-git-send-email-otavio@debian.org>
X-Mailer: git-send-email
Date: Sat, 3 Dec 2005 13:57:10 -0200
Message-Id: <11336254304060-git-send-email-otavio@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Otavio Salvador <otavio@debian.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Otavio Salvador <otavio@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replace all calls to pci_module_init, that's deprecated and
will be removed in future, with pci_register_driver that should be
the used function now.

Signed-off-by: Otavio Salvador <otavio@debian.org>


---

 arch/i386/kernel/scx200.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 43d6f837c1b309ac228b08c4aa5cc6373646c699
d17794f0f6eca4998e47b9488964bb197e7d693f
diff --git a/arch/i386/kernel/scx200.c b/arch/i386/kernel/scx200.c
index 9c968ae..321f5fd 100644
--- a/arch/i386/kernel/scx200.c
+++ b/arch/i386/kernel/scx200.c
@@ -143,7 +143,7 @@ static int __init scx200_init(void)
 {
 	printk(KERN_INFO NAME ": NatSemi SCx200 Driver\n");
 
-	return pci_module_init(&scx200_pci_driver);
+	return pci_register_driver(&scx200_pci_driver);
 }
 
 static void __exit scx200_cleanup(void)
---
0.99.9k



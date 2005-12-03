Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbVLCP5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVLCP5R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 10:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVLCP5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 10:57:17 -0500
Received: from aveiro.procergs.com.br ([200.198.128.42]:54198 "EHLO
	aveiro.procergs.com.br") by vger.kernel.org with ESMTP
	id S1751286AbVLCP5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 10:57:17 -0500
Cc: Otavio Salvador <otavio@debian.org>
Subject: [PATCH 7/11] MIPS: replace all uses of pci_module_init with pci_register_driver
In-Reply-To: <11336254304060-git-send-email-otavio@debian.org>
X-Mailer: git-send-email
Date: Sat, 3 Dec 2005 13:57:10 -0200
Message-Id: <11336254303385-git-send-email-otavio@debian.org>
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

 arch/mips/vr41xx/common/vrc4173.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 0fa7b47cda82385f3b16c170a076809721fb7d39
a67da4b655b9699534d07b10cffca43d1e3dd83a
diff --git a/arch/mips/vr41xx/common/vrc4173.c b/arch/mips/vr41xx/common/vrc4173.c
index 462a9af..cc52e75 100644
--- a/arch/mips/vr41xx/common/vrc4173.c
+++ b/arch/mips/vr41xx/common/vrc4173.c
@@ -561,7 +561,7 @@ static int __devinit vrc4173_init(void)
 {
 	int err;
 
-	err = pci_module_init(&vrc4173_driver);
+	err = pci_register_driver(&vrc4173_driver);
 	if (err < 0)
 		return err;
 
---
0.99.9k



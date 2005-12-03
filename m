Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbVLCP5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbVLCP5S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 10:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932065AbVLCP5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 10:57:18 -0500
Received: from covilha.procergs.com.br ([200.198.128.244]:42957 "EHLO
	covilha.procergs.com.br") by vger.kernel.org with ESMTP
	id S1751279AbVLCP5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 10:57:17 -0500
Cc: Otavio Salvador <otavio@debian.org>
Subject: [PATCH 4/11] VIDEO: replace all uses of pci_module_init with pci_register_driver
In-Reply-To: <11336254301768-git-send-email-otavio@debian.org>
X-Mailer: git-send-email
Date: Sat, 3 Dec 2005 13:57:10 -0200
Message-Id: <11336254302124-git-send-email-otavio@debian.org>
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

 drivers/video/cyblafb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 7d96fbf2c9eb2d18e807891c7023feccd36ae096
4ea77b4a082ec82dbf3b34b6334888cbac61bbe3
diff --git a/drivers/video/cyblafb.c b/drivers/video/cyblafb.c
index 03fbe83..b2d7476 100644
--- a/drivers/video/cyblafb.c
+++ b/drivers/video/cyblafb.c
@@ -1440,7 +1440,7 @@ static int __devinit cyblafb_init(void)
 		}
 #endif
 	output("CyblaFB version %s initializing\n",VERSION);
-	return pci_module_init(&cyblafb_pci_driver);
+	return pci_register_driver(&cyblafb_pci_driver);
 }
 
 static void __exit cyblafb_exit(void)
---
0.99.9k



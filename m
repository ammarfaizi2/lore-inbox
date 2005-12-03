Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbVLCP5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbVLCP5n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 10:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVLCP5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 10:57:24 -0500
Received: from aveiro.procergs.com.br ([200.198.128.42]:57526 "EHLO
	aveiro.procergs.com.br") by vger.kernel.org with ESMTP
	id S1751296AbVLCP5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 10:57:17 -0500
Cc: Otavio Salvador <otavio@debian.org>
Subject: [PATCH 11/11] PCMCIA: replace all uses of pci_module_init with pci_register_driver
In-Reply-To: <11336254303400-git-send-email-otavio@debian.org>
X-Mailer: git-send-email
Date: Sat, 3 Dec 2005 13:57:10 -0200
Message-Id: <11336254301273-git-send-email-otavio@debian.org>
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

 drivers/pcmcia/vrc4173_cardu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 7afc415186e22eea7e883c3885c692b91fda89e8
e52dc116e670cedc89ad7f4f6b5b9948022f272d
diff --git a/drivers/pcmcia/vrc4173_cardu.c b/drivers/pcmcia/vrc4173_cardu.c
index db91259..a64c4d5 100644
--- a/drivers/pcmcia/vrc4173_cardu.c
+++ b/drivers/pcmcia/vrc4173_cardu.c
@@ -604,7 +604,7 @@ static int __devinit vrc4173_cardu_init(
 {
 	vrc4173_cardu_slots = 0;
 
-	return pci_module_init(&vrc4173_cardu_driver);
+	return pci_register_driver(&vrc4173_cardu_driver);
 }
 
 static void __devexit vrc4173_cardu_exit(void)
---
0.99.9k



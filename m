Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVLCP6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVLCP6y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 10:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVLCP5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 10:57:21 -0500
Received: from aveiro.procergs.com.br ([200.198.128.42]:48054 "EHLO
	aveiro.procergs.com.br") by vger.kernel.org with ESMTP
	id S1751288AbVLCP5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 10:57:17 -0500
Cc: Otavio Salvador <otavio@debian.org>
Subject: [PATCH 3/11] SERIAL: replace all uses of pci_module_init with pci_register_driver
In-Reply-To: <11336254302568-git-send-email-otavio@debian.org>
X-Mailer: git-send-email
Date: Sat, 3 Dec 2005 13:57:10 -0200
Message-Id: <11336254301768-git-send-email-otavio@debian.org>
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

 drivers/serial/serial_txx9.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: a666494f7286f5723e4196c76bb77f532c2f7871
82c55929cb91abb75b3b47a46bcba6ef212702fd
diff --git a/drivers/serial/serial_txx9.c b/drivers/serial/serial_txx9.c
index f10c86d..995d9dd 100644
--- a/drivers/serial/serial_txx9.c
+++ b/drivers/serial/serial_txx9.c
@@ -1195,7 +1195,7 @@ static int __init serial_txx9_init(void)
 		serial_txx9_register_ports(&serial_txx9_reg);
 
 #ifdef ENABLE_SERIAL_TXX9_PCI
-		ret = pci_module_init(&serial_txx9_pci_driver);
+		ret = pci_register_driver(&serial_txx9_pci_driver);
 #endif
 	}
 	return ret;
---
0.99.9k



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVLCP7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVLCP7s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 10:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVLCP5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 10:57:20 -0500
Received: from aveiro.procergs.com.br ([200.198.128.42]:56246 "EHLO
	aveiro.procergs.com.br") by vger.kernel.org with ESMTP
	id S1751292AbVLCP5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 10:57:17 -0500
Cc: Otavio Salvador <otavio@debian.org>
Subject: [PATCH 10/11] PARPORT: replace all uses of pci_module_init with pci_register_driver
In-Reply-To: <11336254301170-git-send-email-otavio@debian.org>
X-Mailer: git-send-email
Date: Sat, 3 Dec 2005 13:57:10 -0200
Message-Id: <11336254303400-git-send-email-otavio@debian.org>
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

 drivers/parport/parport_serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 70d62cdda70b6e84fe0b2f8135423cc8fb3c3514
20666144f6463e5c0671ba3df6541b504dcb7e23
diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index d3dad0a..76dd077 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -464,7 +464,7 @@ static struct pci_driver parport_serial_
 
 static int __init parport_serial_init (void)
 {
-	return pci_module_init (&parport_serial_pci_driver);
+	return pci_register_driver (&parport_serial_pci_driver);
 }
 
 static void __exit parport_serial_exit (void)
---
0.99.9k



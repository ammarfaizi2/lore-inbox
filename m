Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263110AbVCDWRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263110AbVCDWRU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 17:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbVCDWOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:14:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:44449 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263135AbVCDUyT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:19 -0500
Cc: c.lucas@ifrance.com
Subject: [PATCH] drivers/w1/*: convert to pci_register_driver
In-Reply-To: <1109968783581@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:39:43 -0800
Message-Id: <11099687831319@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2086, 2005/03/02 16:59:57-08:00, c.lucas@ifrance.com

[PATCH] drivers/w1/*: convert to pci_register_driver

convert from pci_module_init to pci_register_driver
(from:http://kerneljanitors.org/TODO).

Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/w1/matrox_w1.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/w1/matrox_w1.c b/drivers/w1/matrox_w1.c
--- a/drivers/w1/matrox_w1.c	2005-03-04 12:37:44 -08:00
+++ b/drivers/w1/matrox_w1.c	2005-03-04 12:37:44 -08:00
@@ -235,7 +235,7 @@
 
 static int __init matrox_w1_init(void)
 {
-	return pci_module_init(&matrox_w1_pci_driver);
+	return pci_register_driver(&matrox_w1_pci_driver);
 }
 
 static void __exit matrox_w1_fini(void)


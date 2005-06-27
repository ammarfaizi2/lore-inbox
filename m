Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVF0MTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVF0MTt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 08:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVF0MRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 08:17:36 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:63460 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261996AbVF0MP6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:15:58 -0400
Message-Id: <20050627121412.747562000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:16 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christophe Lucas <c.lucas@ifrance.com>,
       Domen Puncer <domen@coderock.org>
Content-Disposition: inline; filename=dvb-saa7146-kj-pci_register_driver.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 16/51] saa7146: kj pci_module_init cleanup
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Lucas <c.lucas@ifrance.com>

http://kerneljanitors.org/TODO
- convert from pci_module_init to pci_register_driver

Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/common/saa7146_core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-git8/drivers/media/common/saa7146_core.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/common/saa7146_core.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/common/saa7146_core.c	2005-06-27 13:24:05.000000000 +0200
@@ -512,7 +512,7 @@ int saa7146_register_extension(struct sa
 	ext->driver.remove = saa7146_remove_one;
 
 	printk("saa7146: register extension '%s'.\n",ext->name);
-	return pci_module_init(&ext->driver);
+	return pci_register_driver(&ext->driver);
 }
 
 int saa7146_unregister_extension(struct saa7146_extension* ext)

--


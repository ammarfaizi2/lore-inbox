Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280736AbRKJWed>; Sat, 10 Nov 2001 17:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280742AbRKJWeX>; Sat, 10 Nov 2001 17:34:23 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:52956 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S280736AbRKJWeP>;
	Sat, 10 Nov 2001 17:34:15 -0500
Date: Sat, 10 Nov 2001 23:34:11 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] 2.4.15-pre2 - unresolved symbol for drivers/net/tokenring/lanstreamer.o
Message-ID: <20011110233411.A28543@se1.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depmod: *** Unresolved symbols in
/lib/modules/2.4.15-pre2/kernel/drivers/net/tokenring/lanstreamer.o
depmod:         pci_get_drv_data

--- linux-2.4.15-pre2.orig/drivers/net/tokenring/lanstreamer.c	Sat Nov 10 18:33:44 2001
+++ linux-2.4.15-pre2/drivers/net/tokenring/lanstreamer.c	Sat Nov 10 23:26:01 2001
@@ -329,7 +329,7 @@ err_out:
 }
 
 static void __devexit streamer_remove_one(struct pci_dev *pdev) {
-  struct net_device *dev=pci_get_drv_data(pdev);
+  struct net_device *dev=pci_get_drvdata(pdev);
   struct streamer_private *streamer_priv;
 
 #if STREAMER_DEBUG

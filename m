Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbVBECxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbVBECxh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 21:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264109AbVBECxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 21:53:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9988 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S265305AbVBEClf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 21:41:35 -0500
Date: Sat, 5 Feb 2005 03:41:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Victor Krapivin <vik@belcaf.minsk.by>
Cc: vojtech@suse.cz, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] input/gameport/cs461x.c: make 2 functions static
Message-ID: <20050205024132.GI19408@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc3-mm1-full/drivers/input/gameport/cs461x.c.old	2005-02-05 03:23:44.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/input/gameport/cs461x.c	2005-02-05 03:24:21.000000000 +0100
@@ -318,12 +318,12 @@
         .remove =       __devexit_p(cs461x_pci_remove),
 };
 
-int __init cs461x_init(void)
+static int __init cs461x_init(void)
 {
         return pci_module_init(&cs461x_pci_driver);
 }
 
-void __exit cs461x_exit(void)
+static void __exit cs461x_exit(void)
 {
         pci_unregister_driver(&cs461x_pci_driver);
 }


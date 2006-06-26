Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWFZVxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWFZVxc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 17:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWFZVxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 17:53:32 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29710 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751164AbWFZVxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 17:53:32 -0400
Date: Mon, 26 Jun 2006 23:53:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: laredo@gnu.org
Cc: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/video/stradis.c: make 2 functions static
Message-ID: <20060626215330.GH23314@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/video/stradis.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17-mm2-full/drivers/media/video/stradis.c.old	2006-06-26 23:14:05.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/media/video/stradis.c	2006-06-26 23:14:35.000000000 +0200
@@ -2190,7 +2190,7 @@
 	.remove = __devexit_p(stradis_remove)
 };
 
-int __init stradis_init(void)
+static int __init stradis_init(void)
 {
 	int retval;
 
@@ -2203,7 +2203,7 @@
 	return retval;
 }
 
-void __exit stradis_exit(void)
+static void __exit stradis_exit(void)
 {
 	pci_unregister_driver(&stradis_driver);
 	printk(KERN_INFO "stradis: module cleanup complete\n");


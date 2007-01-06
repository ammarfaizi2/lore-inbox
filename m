Return-Path: <linux-kernel-owner+w=401wt.eu-S932191AbXAFUsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbXAFUsu (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 15:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbXAFUsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 15:48:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4208 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932188AbXAFUst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 15:48:49 -0500
Date: Sat, 6 Jan 2007 21:48:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: adaplas@pol.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove bogus con_is_present() prototypes
Message-ID: <20070106204852.GY20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although gcc seems to accept "extern" prototypes after it has seen the
"static inline" function, that's not really correct.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/video/aty/atyfb_base.c |    2 --
 drivers/video/igafb.c          |    1 -
 2 files changed, 3 deletions(-)

--- linux-2.6.20-rc3-mm1/drivers/video/igafb.c.old	2007-01-06 19:45:32.000000000 +0100
+++ linux-2.6.20-rc3-mm1/drivers/video/igafb.c	2007-01-06 19:53:06.000000000 +0100
@@ -370,7 +370,6 @@
 
 int __init igafb_init(void)
 {
-        extern int con_is_present(void);
         struct fb_info *info;
         struct pci_dev *pdev;
         struct iga_par *par;
--- linux-2.6.20-rc3-mm1/drivers/video/aty/atyfb_base.c.old	2007-01-06 20:14:25.000000000 +0100
+++ linux-2.6.20-rc3-mm1/drivers/video/aty/atyfb_base.c	2007-01-06 20:14:32.000000000 +0100
@@ -2957,8 +2957,6 @@
 static int __devinit atyfb_setup_sparc(struct pci_dev *pdev,
 			struct fb_info *info, unsigned long addr)
 {
-	extern int con_is_present(void);
-
 	struct atyfb_par *par = info->par;
 	struct pcidev_cookie *pcp;
 	char prop[128];


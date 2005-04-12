Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbVDLTL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbVDLTL3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVDLTJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:09:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:47561 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262211AbVDLKcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:36 -0400
Message-Id: <200504121032.j3CAWLlI005569@shell0.pdx.osdl.net>
Subject: [patch 108/198] fix u32 vs. pm_message_t in pcmcia
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pavel@ucw.cz, pavel@suse.cz
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Pavel Machek <pavel@ucw.cz>

This fixes u32 vs. pm_message_t in pcmcia.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/pcmcia/au1000_generic.c |    2 +-
 25-akpm/drivers/pcmcia/hd64465_ss.c     |    2 +-
 25-akpm/drivers/pcmcia/m32r_cfc.c       |    2 +-
 25-akpm/drivers/pcmcia/m32r_pcc.c       |    2 +-
 25-akpm/drivers/pcmcia/pxa2xx_base.c    |    2 +-
 25-akpm/drivers/pcmcia/sa1100_generic.c |    2 +-
 25-akpm/drivers/pcmcia/sa1111_generic.c |    2 +-
 25-akpm/drivers/pcmcia/vrc4171_card.c   |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff -puN drivers/pcmcia/au1000_generic.c~fix-u32-vs-pm_message_t-in-pcmcia drivers/pcmcia/au1000_generic.c
--- 25/drivers/pcmcia/au1000_generic.c~fix-u32-vs-pm_message_t-in-pcmcia	2005-04-12 03:21:29.355674160 -0700
+++ 25-akpm/drivers/pcmcia/au1000_generic.c	2005-04-12 03:21:29.367672336 -0700
@@ -518,7 +518,7 @@ static int au1x00_drv_pcmcia_probe(struc
 }
 
 
-static int au1x00_drv_pcmcia_suspend(struct device *dev, u32 state, u32 level)
+static int au1x00_drv_pcmcia_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
diff -puN drivers/pcmcia/hd64465_ss.c~fix-u32-vs-pm_message_t-in-pcmcia drivers/pcmcia/hd64465_ss.c
--- 25/drivers/pcmcia/hd64465_ss.c~fix-u32-vs-pm_message_t-in-pcmcia	2005-04-12 03:21:29.356674008 -0700
+++ 25-akpm/drivers/pcmcia/hd64465_ss.c	2005-04-12 03:21:29.368672184 -0700
@@ -845,7 +845,7 @@ static void hs_exit_socket(hs_socket_t *
 	local_irq_restore(flags);
 }
 
-static int hd64465_suspend(struct device *dev, u32 state, u32 level)
+static int hd64465_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
diff -puN drivers/pcmcia/m32r_cfc.c~fix-u32-vs-pm_message_t-in-pcmcia drivers/pcmcia/m32r_cfc.c
--- 25/drivers/pcmcia/m32r_cfc.c~fix-u32-vs-pm_message_t-in-pcmcia	2005-04-12 03:21:29.358673704 -0700
+++ 25-akpm/drivers/pcmcia/m32r_cfc.c	2005-04-12 03:21:29.369672032 -0700
@@ -743,7 +743,7 @@ static struct pccard_operations pcc_oper
 
 /*====================================================================*/
 
-static int m32r_pcc_suspend(struct device *dev, u32 state, u32 level)
+static int m32r_pcc_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
diff -puN drivers/pcmcia/m32r_pcc.c~fix-u32-vs-pm_message_t-in-pcmcia drivers/pcmcia/m32r_pcc.c
--- 25/drivers/pcmcia/m32r_pcc.c~fix-u32-vs-pm_message_t-in-pcmcia	2005-04-12 03:21:29.359673552 -0700
+++ 25-akpm/drivers/pcmcia/m32r_pcc.c	2005-04-12 03:21:29.370671880 -0700
@@ -696,7 +696,7 @@ static struct pccard_operations pcc_oper
 
 /*====================================================================*/
 
-static int m32r_pcc_suspend(struct device *dev, u32 state, u32 level)
+static int m32r_pcc_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
diff -puN drivers/pcmcia/pxa2xx_base.c~fix-u32-vs-pm_message_t-in-pcmcia drivers/pcmcia/pxa2xx_base.c
--- 25/drivers/pcmcia/pxa2xx_base.c~fix-u32-vs-pm_message_t-in-pcmcia	2005-04-12 03:21:29.360673400 -0700
+++ 25-akpm/drivers/pcmcia/pxa2xx_base.c	2005-04-12 03:21:29.370671880 -0700
@@ -205,7 +205,7 @@ int pxa2xx_drv_pcmcia_probe(struct devic
 }
 EXPORT_SYMBOL(pxa2xx_drv_pcmcia_probe);
 
-static int pxa2xx_drv_pcmcia_suspend(struct device *dev, u32 state, u32 level)
+static int pxa2xx_drv_pcmcia_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
diff -puN drivers/pcmcia/sa1100_generic.c~fix-u32-vs-pm_message_t-in-pcmcia drivers/pcmcia/sa1100_generic.c
--- 25/drivers/pcmcia/sa1100_generic.c~fix-u32-vs-pm_message_t-in-pcmcia	2005-04-12 03:21:29.362673096 -0700
+++ 25-akpm/drivers/pcmcia/sa1100_generic.c	2005-04-12 03:21:29.370671880 -0700
@@ -75,7 +75,7 @@ static int sa11x0_drv_pcmcia_probe(struc
 	return ret;
 }
 
-static int sa11x0_drv_pcmcia_suspend(struct device *dev, u32 state, u32 level)
+static int sa11x0_drv_pcmcia_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
diff -puN drivers/pcmcia/sa1111_generic.c~fix-u32-vs-pm_message_t-in-pcmcia drivers/pcmcia/sa1111_generic.c
--- 25/drivers/pcmcia/sa1111_generic.c~fix-u32-vs-pm_message_t-in-pcmcia	2005-04-12 03:21:29.363672944 -0700
+++ 25-akpm/drivers/pcmcia/sa1111_generic.c	2005-04-12 03:21:29.371671728 -0700
@@ -158,7 +158,7 @@ static int __devexit pcmcia_remove(struc
 	return 0;
 }
 
-static int pcmcia_suspend(struct sa1111_dev *dev, u32 state)
+static int pcmcia_suspend(struct sa1111_dev *dev, pm_message_t state)
 {
 	return pcmcia_socket_dev_suspend(&dev->dev, state);
 }
diff -puN drivers/pcmcia/vrc4171_card.c~fix-u32-vs-pm_message_t-in-pcmcia drivers/pcmcia/vrc4171_card.c
--- 25/drivers/pcmcia/vrc4171_card.c~fix-u32-vs-pm_message_t-in-pcmcia	2005-04-12 03:21:29.364672792 -0700
+++ 25-akpm/drivers/pcmcia/vrc4171_card.c	2005-04-12 03:21:29.372671576 -0700
@@ -774,7 +774,7 @@ static int __devinit vrc4171_card_setup(
 
 __setup("vrc4171_card=", vrc4171_card_setup);
 
-static int vrc4171_card_suspend(struct device *dev, u32 state, u32 level)
+static int vrc4171_card_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int retval = 0;
 
_

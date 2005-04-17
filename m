Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVDQUKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVDQUKl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 16:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVDQUJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 16:09:20 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10771 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261464AbVDQUGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 16:06:46 -0400
Date: Sun, 17 Apr 2005 22:06:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/istallion.c: remove an unneeded variable
Message-ID: <20050417200643.GJ3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an unneeded global variable.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/istallion.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/char/istallion.c.old	2005-04-17 18:05:53.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/istallion.c	2005-04-17 18:07:32.000000000 +0200
@@ -407,7 +407,6 @@
 };
 
 static int	stli_eisamempsize = sizeof(stli_eisamemprobeaddrs) / sizeof(unsigned long);
-int		stli_eisaprobe = STLI_EISAPROBE;
 
 /*
  *	Define the Stallion PCI vendor and device IDs.
@@ -4685,7 +4684,7 @@
 #ifdef MODULE
 	stli_argbrds();
 #endif
-	if (stli_eisaprobe)
+	if (STLI_EISAPROBE)
 		stli_findeisabrds();
 #ifdef CONFIG_PCI
 	stli_findpcibrds();


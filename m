Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbTHYSGZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 14:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTHYSGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 14:06:24 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:37896 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S261723AbTHYSGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 14:06:19 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: linux-kernel@vger.kernel.org, riley@williams.name, kraxel@bytesex.org,
       Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] Eliminate compile warnings in atyfb_base.c
Date: Mon, 25 Aug 2003 21:06:14 +0300
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200308252106.14798.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Warnings were:
  CC      drivers/video/aty/atyfb_base.o
drivers/video/aty/atyfb_base.c:393: warning: `ram_dram' defined but not used
drivers/video/aty/atyfb_base.c:404: warning: `ram_resv' defined but not used
--
vda

--- linux-2.6.0-test4/drivers/video/aty/atyfb_base.c.orig	Sat Aug 23 02:57:56 2003
+++ linux-2.6.0-test4/drivers/video/aty/atyfb_base.c	Mon Aug 25 21:00:36 2003
@@ -390,7 +390,10 @@
 #endif				/* CONFIG_FB_ATY_CT */
 };

+#if defined(CONFIG_FB_ATY_GX) || defined(CONFIG_FB_ATY_CT)
 static char ram_dram[] __initdata = "DRAM";
+static char ram_resv[] __initdata = "RESV";
+#endif
 #ifdef CONFIG_FB_ATY_GX
 static char ram_vram[] __initdata = "VRAM";
 #endif /* CONFIG_FB_ATY_GX */
@@ -401,7 +404,6 @@
 static char ram_wram[] __initdata = "WRAM";
 static char ram_off[] __initdata = "OFF";
 #endif /* CONFIG_FB_ATY_CT */
-static char ram_resv[] __initdata = "RESV";

 static u32 pseudo_palette[17];
 


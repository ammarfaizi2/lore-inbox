Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbVGVVpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVGVVpO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 17:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVGVVnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 17:43:06 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39434 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262198AbVGVVm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 17:42:28 -0400
Date: Fri, 22 Jul 2005 23:42:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/ne.c: fix warning with -Wundef
Message-ID: <20050722214223.GW3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warning with -Wundef:

<--  snip  -->

...
  CC      drivers/net/ne.o
drivers/net/ne.c:134:7: warning: "CONFIG_PLAT_OAKS32R" is not defined
...

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm1-full/drivers/net/ne.c.old	2005-07-22 18:24:32.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/drivers/net/ne.c	2005-07-22 18:24:50.000000000 +0200
@@ -131,7 +131,7 @@
 
 #ifdef CONFIG_PLAT_MAPPI
 #  define DCR_VAL 0x4b
-#elif CONFIG_PLAT_OAKS32R
+#elif defined(CONFIG_PLAT_OAKS32R)
 #  define DCR_VAL 0x48
 #else
 #  define DCR_VAL 0x49


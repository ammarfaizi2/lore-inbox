Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263080AbSITRJn>; Fri, 20 Sep 2002 13:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263084AbSITRJn>; Fri, 20 Sep 2002 13:09:43 -0400
Received: from smtp01.web.de ([194.45.170.210]:51473 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S263080AbSITRJm> convert rfc822-to-8bit;
	Fri, 20 Sep 2002 13:09:42 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?Ren=E9=20Scharfe?= <l.s.r@web.de>
To: Jean Tourrilhes <jt@hpl.hp.com>
Subject: [PATCH] 2.5.37 wavelan_cs compile error, warning fix
Date: Fri, 20 Sep 2002 19:14:43 +0200
User-Agent: KMail/1.4.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209201914.43965.l.s.r@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch fixes a compile error and a warning about an unused
function in wavelan_cs.c. Compiles, untested.

René


--- linux-2.5.37/drivers/net/wireless/wavelan_cs.c	Fri Sep 20 18:22:38 2002
+++ linux/drivers/net/wireless/wavelan_cs.c	Fri Sep 20 19:00:11 2002
@@ -56,6 +56,7 @@
  *
  */
 
+#include <linux/types.h>
 #include <linux/ethtool.h>
 #include <asm/uaccess.h>
 #include "wavelan_cs.p.h"		/* Private header */
@@ -1860,6 +1861,7 @@
 }
 #endif	/* HISTOGRAM */
 
+#if WIRELESS_EXT <= 12
 static int netdev_ethtool_ioctl(struct net_device *dev, void *useraddr)
 {
 	u32 ethcmd;
@@ -1880,6 +1882,7 @@
 
 	return -EOPNOTSUPP;
 }
+#endif
 
 /*------------------------------------------------------------------*/
 /*


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263689AbTCUS3O>; Fri, 21 Mar 2003 13:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263663AbTCUS22>; Fri, 21 Mar 2003 13:28:28 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:53635
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263713AbTCUSYq>; Fri, 21 Mar 2003 13:24:46 -0500
Date: Fri, 21 Mar 2003 19:40:00 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211940.h2LJe0ix025875@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: use EI_SHIFT for CBUS 8390
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/net/8390.h linux-2.5.65-ac2/drivers/net/8390.h
--- linux-2.5.65/drivers/net/8390.h	2003-02-10 18:38:46.000000000 +0000
+++ linux-2.5.65-ac2/drivers/net/8390.h	2003-03-20 18:31:13.000000000 +0000
@@ -123,7 +123,8 @@
 #define inb_p(port)   in_8(port)
 #define outb_p(val,port)  out_8(port,val)
 
-#elif defined(CONFIG_ARM_ETHERH) || defined(CONFIG_ARM_ETHERH_MODULE)
+#elif defined(CONFIG_ARM_ETHERH) || defined(CONFIG_ARM_ETHERH_MODULE) || \
+      defined(CONFIG_NET_CBUS)
 #define EI_SHIFT(x)	(ei_local->reg_offset[x])
 #else
 #define EI_SHIFT(x)	(x)

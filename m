Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132758AbQLHVXD>; Fri, 8 Dec 2000 16:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132831AbQLHVWx>; Fri, 8 Dec 2000 16:22:53 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:56429
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S132758AbQLHVWl>; Fri, 8 Dec 2000 16:22:41 -0500
Date: Fri, 8 Dec 2000 21:52:08 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: jschlst@turbolinux.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove warning from drivers/net/tokenring/smctr.c
Message-ID: <20001208215208.J599@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch makes a 'defined but not used' warning go away when compiling
drivers/net/tokenring/smctr.c without module support (kernel 240t12p3).
(It should apply cleanly.)

--- linux-240-t12-pre3-clean/drivers/net/tokenring/smctr.c	Sat Nov  4 23:27:09 2000
+++ linux/drivers/net/tokenring/smctr.c	Wed Nov 29 19:29:11 2000
@@ -21,9 +21,10 @@
  */
 
 static const char *version = "smctr.c: v1.1 1/1/00 by jschlst@turbolinux.com\n";
-static const char *cardname = "smctr";
 
 #ifdef MODULE
+static const char *cardname = "smctr";
+
 #include <linux/module.h>
 #include <linux/version.h>
 #endif

-- 
        Rasmus(rasmus@jaquet.dk)

China is a big country, inhabited by many Chinese.
-Former French President Charles de Gaulle
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

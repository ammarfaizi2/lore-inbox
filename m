Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292762AbSCINbn>; Sat, 9 Mar 2002 08:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292761AbSCINbe>; Sat, 9 Mar 2002 08:31:34 -0500
Received: from 1Cust74.tnt6.lax7.da.uu.net ([67.193.244.74]:26606 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S292751AbSCINbS>; Sat, 9 Mar 2002 08:31:18 -0500
Subject: [PATCH] 2.2.21-pre[34] pl2303.c non-modular compile fix
To: linux-kernel@vger.kernel.org
Date: Sat, 9 Mar 2002 05:19:10 -0800 (PST)
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020309131910.50C6D8959A@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The pl2303 driver won't compile for me in Linux 2.2.21-pre3 or -pre4 if
modules are disabled. This might not be the right fix, but it allows the
driver to compile and work for me.

-Barry K. Nathan <barryn@pobox.com>

diff -ruN linux-2.2.21-pre3/drivers/usb/serial/pl2303.c linux-2.2.21-pre3-bknA-1/drivers/usb/serial/pl2303.c
--- linux-2.2.21-pre3/drivers/usb/serial/pl2303.c	Sun Mar  3 23:20:11 2002
+++ linux-2.2.21-pre3-bknA-1/drivers/usb/serial/pl2303.c	Sat Mar  9 04:45:08 2002
@@ -818,7 +818,9 @@
 module_exit(pl2303_exit);
 
 MODULE_DESCRIPTION(DRIVER_DESC);
+#ifdef CONFIG_MODULES
 MODULE_LICENSE("GPL");
+#endif
 
 MODULE_PARM(debug, "i");
 MODULE_PARM_DESC(debug, "Debug enabled or not");

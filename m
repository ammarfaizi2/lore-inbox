Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317446AbSFME1n>; Thu, 13 Jun 2002 00:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317448AbSFME1m>; Thu, 13 Jun 2002 00:27:42 -0400
Received: from newman.msbb.uc.edu ([129.137.2.198]:13843 "EHLO smtp.uc.edu")
	by vger.kernel.org with ESMTP id <S317446AbSFME1m>;
	Thu, 13 Jun 2002 00:27:42 -0400
From: kuebelr@email.uc.edu
Date: Thu, 13 Jun 2002 00:27:36 -0400
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [TRIVIAL] 3c509.c - 2/2
Message-Id: <20020613042736.GB12340@cartman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes sure the 3c509 module license is always GPL.  Currently
the MODULE_LICENSE() marco is only used when CONFIG_ISAPNP or
CONFIG_ISAPNP_MODULE is defined.  I have moved MODULE_LICENSE() to the
#ifdef MODULE section at the bottom of 3c509.c.

Same is true for the MODULE_DEVICE_TABLE() macro.

Patch is agains 2.4.19-pre10.

Rob.

--- linux-clean/drivers/net/3c509.c     Fri Jun  7 23:41:59 2002
+++ linux-dirty/drivers/net/3c509.c     Thu Jun 13 00:18:18 2002
@@ -229,10 +229,6 @@
        { }     /* terminate list */
 };
 
-MODULE_DEVICE_TABLE(isapnp, el3_isapnp_adapters);
-MODULE_LICENSE("GPL");
-
-
 static u16 el3_isapnp_phys_addr[8][3];
 #endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 static int nopnp;
@@ -1265,6 +1261,8 @@
 MODULE_PARM_DESC(nopnp, "disable ISA PnP support (0-1)");
 #endif /* CONFIG_ISAPNP */
 MODULE_DESCRIPTION("3Com Etherlink III (3c509, 3c509B) ISA/PnP ethernet driver");
+MODULE_DEVICE_TABLE(isapnp, el3_isapnp_adapters);
+MODULE_LICENSE("GPL");
 
 int
 init_module(void)

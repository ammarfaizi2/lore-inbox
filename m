Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316666AbSFUPRG>; Fri, 21 Jun 2002 11:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316664AbSFUPRF>; Fri, 21 Jun 2002 11:17:05 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:28677 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S316662AbSFUPRE>; Fri, 21 Jun 2002 11:17:04 -0400
Date: Sat, 22 Jun 2002 01:16:55 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 3c509 compile fix for 2.5.24
Message-ID: <Mutt.LNX.4.44.0206220112180.6457-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a patch which allows the 3c509.c driver to compile for 
non-isapnp configurations (a trivial bug was seemingly introduced in 
http://marc.theaimsgroup.com/?l=linux-kernel&m=102394259120718&w=2)

Please apply.

- James
-- 
James Morris
<jmorris@intercode.com.au>

diff -urN -X dontdiff linux-2.5.24.orig/drivers/net/3c509.c linux-2.5.24.w1/drivers/net/3c509.c
--- linux-2.5.24.orig/drivers/net/3c509.c	Fri Jun 21 13:12:48 2002
+++ linux-2.5.24.w1/drivers/net/3c509.c	Sat Jun 22 00:59:59 2002
@@ -1259,9 +1259,9 @@
 #ifdef __ISAPNP__
 MODULE_PARM(nopnp, "i");
 MODULE_PARM_DESC(nopnp, "disable ISA PnP support (0-1)");
+MODULE_DEVICE_TABLE(isapnp, el3_isapnp_adapters);
 #endif	/* __ISAPNP__ */
 MODULE_DESCRIPTION("3Com Etherlink III (3c509, 3c509B) ISA/PnP ethernet driver");
-MODULE_DEVICE_TABLE(isapnp, el3_isapnp_adapters);
 MODULE_LICENSE("GPL");
 
 int


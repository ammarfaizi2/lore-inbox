Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266271AbSKOMy5>; Fri, 15 Nov 2002 07:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266274AbSKOMy5>; Fri, 15 Nov 2002 07:54:57 -0500
Received: from precia.cinet.co.jp ([210.166.75.133]:54658 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S266271AbSKOMyz>; Fri, 15 Nov 2002 07:54:55 -0500
Message-ID: <3DD4F02D.C08D8EB8@cinet.co.jp>
Date: Fri, 15 Nov 2002 22:01:33 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.47-ac4-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: PC-9800 patch for 2.5.47-ac4: not merged yet (12/15) PNP
References: <3DD4E2D5.AEF13F1@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------6A18C06D8C148D364912FDDF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6A18C06D8C148D364912FDDF
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

This is for legacy bus PNP support.

diffstat:
 drivers/pnp/isapnp/core.c |    5 +++++
 1 files changed, 5 insertions(+)

-- 
Osamu Tomita
tomita@cinet.co.jp
--------------6A18C06D8C148D364912FDDF
Content-Type: text/plain; charset=iso-2022-jp;
 name="pnp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnp.patch"

diff -urN linux/drivers/pnp/isapnp/core.c linux98/drivers/pnp/isapnp/core.c
--- linux/drivers/pnp/isapnp/core.c	Tue Nov  5 07:30:31 2002
+++ linux98/drivers/pnp/isapnp/core.c	Sun Nov 10 23:25:36 2002
@@ -76,8 +76,13 @@
 MODULE_PARM_DESC(isapnp_verbose, "ISA Plug & Play verbose mode");
 MODULE_LICENSE("GPL");
 
+#ifndef CONFIG_PC9800
 #define _PIDXR		0x279
 #define _PNPWRP		0xa79
+#else
+#define _PIDXR		0x259
+#define _PNPWRP		0xa59
+#endif
 
 /* short tags */
 #define _STAG_PNPVERNO		0x01

--------------6A18C06D8C148D364912FDDF--


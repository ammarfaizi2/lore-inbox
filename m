Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266489AbSLOM7j>; Sun, 15 Dec 2002 07:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266520AbSLOM7j>; Sun, 15 Dec 2002 07:59:39 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:48193 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S266489AbSLOM7g>; Sun, 15 Dec 2002 07:59:36 -0500
Message-ID: <3DFC7DF5.1756033E@cinet.co.jp>
Date: Sun, 15 Dec 2002 22:04:53 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.50-ac1-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 addtional for 2.5.50-ac1 (18/21)
References: <3DFC50E9.656B96D0@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------D383B5F82DD65A5A17EAD077"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D383B5F82DD65A5A17EAD077
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

NEC PC-9800 subarchitecture support patch for 2.5.50-ac1 (18/21)
This is support for C-Bus (legacy bus like ISA) PNP.

 drivers/pnp/isapnp/core.c |    5 +++++
 1 files changed, 5 insertions(+)

Regards,
Osamu Tomita
--------------D383B5F82DD65A5A17EAD077
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

--------------D383B5F82DD65A5A17EAD077--


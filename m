Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266009AbSKFSoW>; Wed, 6 Nov 2002 13:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266013AbSKFSoW>; Wed, 6 Nov 2002 13:44:22 -0500
Received: from precia.cinet.co.jp ([210.166.75.133]:49024 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S266009AbSKFSoU>; Wed, 6 Nov 2002 13:44:20 -0500
Message-ID: <3DC9648E.1189747B@cinet.co.jp>
Date: Thu, 07 Nov 2002 03:50:54 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.45-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCHSET 14/17] support PC-9800 against 2.5.45-ac1 (PNP)
References: <3DC94C7B.79DE5EBC@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------A26A470BF6E2C633CECD4631"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A26A470BF6E2C633CECD4631
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

This patch adds legacy bus PNP support for PC-9800.

diffstat:
 drivers/pnp/isapnp/core.c |    5 +++++
 1 files changed, 5 insertions(+)

-- 
Osamu Tomita
--------------A26A470BF6E2C633CECD4631
Content-Type: text/plain; charset=iso-2022-jp;
 name="pnp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnp.patch"

diff -urN linux/drivers/pnp/isapnp/core.c linux98/drivers/pnp/isapnp/core.c
--- linux/drivers/pnp/isapnp/core.c	Sat Oct 19 13:01:56 2002
+++ linux98/drivers/pnp/isapnp/core.c	Sat Oct 19 15:37:24 2002
@@ -75,8 +75,13 @@
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

--------------A26A470BF6E2C633CECD4631--


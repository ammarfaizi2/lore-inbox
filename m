Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbSKBSK1>; Sat, 2 Nov 2002 13:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbSKBSK0>; Sat, 2 Nov 2002 13:10:26 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:64595 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261370AbSKBSKU>; Sat, 2 Nov 2002 13:10:20 -0500
Date: Sun, 3 Nov 2002 03:16:32 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [RFC][Patchset 15/20] Support for PC-9800 (PNP)
Message-ID: <20021103031632.E1536@precia.cinet.co.jp>
References: <20021103023345.A1536@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: =?iso-8859-1?Q?=3C20021103023345=2EA1536?=
	=?iso-8859-1?B?QHByZWNpYS5jaW5ldC5jby5qcD47IGZyb20gdG9taXRhQGNpbmV0LmNv?=
	=?iso-8859-1?B?LmpwIG9uIMb8LCAxMbfu?= 03, 2002 at 02:33:45 +0900
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a part 15/20 of patchset for add support NEC PC-9800 architecture,
against 2.5.45.

Summary:
  legacy bus pnp module
   - IO port address change.

diffstat:
  drivers/pnp/isapnp/core.c |    5 +++++
  1 files changed, 5 insertions(+)

patch:
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

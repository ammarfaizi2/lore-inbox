Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267399AbTASGws>; Sun, 19 Jan 2003 01:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267506AbTASGva>; Sun, 19 Jan 2003 01:51:30 -0500
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:64386 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267399AbTASGsV>; Sun, 19 Jan 2003 01:48:21 -0500
Date: Sun, 19 Jan 2003 15:57:14 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 sub-arch (24/29) PNP
Message-ID: <20030119065714.GW2965@yuzuki.cinet.co.jp>
References: <20030119051043.GA2662@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030119051043.GA2662@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.59 (24/29).

Legacy bus PNP support.

diff -Nru linux/drivers/pnp/isapnp/core.c linux98/drivers/pnp/isapnp/core.c
--- linux/drivers/pnp/isapnp/core.c	2003-01-02 12:22:18.000000000 +0900
+++ linux98/drivers/pnp/isapnp/core.c	2003-01-04 16:40:40.000000000 +0900
@@ -72,8 +72,13 @@
 MODULE_PARM_DESC(isapnp_verbose, "ISA Plug & Play verbose mode");
 MODULE_LICENSE("GPL");
 
+#ifndef CONFIG_X86_PC9800
 #define _PIDXR		0x279
 #define _PNPWRP		0xa79
+#else
+#define _PIDXR		0x259
+#define _PNPWRP		0xa59
+#endif
 
 /* short tags */
 #define _STAG_PNPVERNO		0x01

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261407AbSJ1RkC>; Mon, 28 Oct 2002 12:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261406AbSJ1Rig>; Mon, 28 Oct 2002 12:38:36 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:63759 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261407AbSJ1RXw>; Mon, 28 Oct 2002 12:23:52 -0500
Date: Tue, 29 Oct 2002 02:30:14 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCHSET 15/23] add support for PC-9800 architecture (PNP)
Message-ID: <20021029023014.A2307@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a part 15/23 of patchset for add support NEC PC-9800 architecture,
against 2.5.44.

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

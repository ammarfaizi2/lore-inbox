Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265264AbSJRQ4A>; Fri, 18 Oct 2002 12:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbSJRQxy>; Fri, 18 Oct 2002 12:53:54 -0400
Received: from gateway.cinet.co.jp ([210.166.75.129]:40977 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S265264AbSJRQvj>; Fri, 18 Oct 2002 12:51:39 -0400
Date: Sat, 19 Oct 2002 01:56:43 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCHSET 17/25] add support for PC-9800 architecture (PNP)
Message-ID: <20021019015643.A1612@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 17/26 of patchset for add support NEC PC-9800 architecture,
against 2.5.43.

Summary:
 legacy bus pnp module
  - IO port address change.

diffstat:
 drivers/pnp/isapnp.c |    5 +++++
 1 files changed, 5 insertions(+)

patch:
diff -urN linux/drivers/pnp/isapnp.c linux98/drivers/pnp/isapnp.c
--- linux/drivers/pnp/isapnp.c	Sat Oct 12 13:22:09 2002
+++ linux98/drivers/pnp/isapnp.c	Sat Oct 12 14:18:53 2002
@@ -93,8 +93,13 @@
 MODULE_PARM_DESC(isapnp_reserve_mem, "ISA Plug & Play - reserve memory region(s) - address,size");
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

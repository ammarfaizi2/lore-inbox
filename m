Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbVIESgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVIESgW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 14:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVIESdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 14:33:09 -0400
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:57699 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932391AbVIESc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 14:32:56 -0400
Message-Id: <20050905183247.209085000@kohtala.home.org>
References: <20050905183109.284672000@kohtala.home.org>
Date: Mon, 05 Sep 2005 21:31:16 +0300
From: marko.kohtala@gmail.com
To: akpm@osdl.org
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [patch 07/10] parport: ieee1284 fixes and cleanups
Content-Disposition: inline; filename=parport-fix-parport-driver-to-compile-with-debugging-defined.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing "struct" keyword preventing compilation with DEBUG_PARPORT
defined. Also add some "const".

Signed-off-by: Marko Kohtala <marko.kohtala@gmail.com>

---

 include/linux/parport_pc.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-dvb/include/linux/parport_pc.h
===================================================================
--- linux-dvb.orig/include/linux/parport_pc.h	2005-06-24 15:42:28.000000000 +0300
+++ linux-dvb/include/linux/parport_pc.h	2005-06-24 15:42:52.000000000 +0300
@@ -85,8 +85,8 @@ extern __inline__ void dump_parport_stat
 	unsigned char ecr = inb (ECONTROL (p));
 	unsigned char dcr = inb (CONTROL (p));
 	unsigned char dsr = inb (STATUS (p));
-	static char *ecr_modes[] = {"SPP", "PS2", "PPFIFO", "ECP", "xXx", "yYy", "TST", "CFG"};
-	const struct parport_pc_private *priv = (parport_pc_private *)p->physport->private_data;
+	static const char *const ecr_modes[] = {"SPP", "PS2", "PPFIFO", "ECP", "xXx", "yYy", "TST", "CFG"};
+	const struct parport_pc_private *priv = (struct parport_pc_private *)p->physport->private_data;
 	int i;
 
 	printk (KERN_DEBUG "*** parport state (%s): ecr=[%s", str, ecr_modes[(ecr & 0xe0) >> 5]);

--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbTEZRUE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbTEZRT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:19:27 -0400
Received: from mcmmta1.mediacapital.pt ([193.126.240.146]:13443 "EHLO
	mcmmta1.mediacapital.pt") by vger.kernel.org with ESMTP
	id S261873AbTEZRPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:15:01 -0400
Date: Mon, 26 May 2003 18:29:07 +0100
From: "Paulo Andre'" <fscked@iol.pt>
Subject: [RFC] [PATCH] Add 'make' with no target as preferred build command
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <20030526182907.108fd71e.fscked@iol.pt>
MIME-version: 1.0
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: multipart/mixed; boundary="Boundary_(ID_bk5/cM/lKBkHQiiSBLe+PA)"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_bk5/cM/lKBkHQiiSBLe+PA)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT

Hello,

It seems for 2.5/2.6 'make' is the preferred command for building the
kernel tree (also stated in davej's 2.6 "what to expect" document). That
scenario however isn't even presented when the user finishes the kernel
configuration. This is a simple patch to scripts/kconfig/mconf.c which
tackles that, perhaps not in the best fashion but certainly in the
simplest.

Applies on top of bk-curr. Please consider.


		Paulo Andre'



--Boundary_(ID_bk5/cM/lKBkHQiiSBLe+PA)
Content-type: text/plain; name=patch-scripts_kconfig_mconf.c.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=patch-scripts_kconfig_mconf.c.diff

--- linux-2.5-vanilla/scripts/kconfig/mconf.c	2003-03-24 22:00:10.000000000 +0000
+++ linux-2.5/scripts/kconfig/mconf.c	2003-05-26 12:49:13.000000000 +0100
@@ -781,7 +781,7 @@
 		printf("\n\n"
 			"*** End of Linux kernel configuration.\n"
 			"*** Check the top-level Makefile for additional configuration.\n"
-			"*** Next, you may run 'make bzImage', 'make bzdisk', or 'make install'.\n\n");
+			"*** Next, you may run 'make', 'make bzImage', 'make bzdisk', or 'make install'.\n\n");
 	} else
 		printf("\n\nYour kernel configuration changes were NOT saved.\n\n");
 


--Boundary_(ID_bk5/cM/lKBkHQiiSBLe+PA)--

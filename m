Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVAJFrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVAJFrF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVAJFqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:46:36 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:35332
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262114AbVAJFO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:59 -0500
Message-Id: <200501100736.j0A7aHPW005870@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, cw@foof.org
Subject: [PATCH 28/28] UML - Fix a compile warning
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:36:17 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An eliminated warning from Chris Wright.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/kernel/skas/process.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/skas/process.c	2005-01-09 21:52:21.000000000 -0500
+++ 2.6.10/arch/um/kernel/skas/process.c	2005-01-09 21:57:49.000000000 -0500
@@ -92,6 +92,7 @@
 }
 
 /* Each element set once, and only accessed by a single processor anyway */
+#undef NR_CPUS
 #define NR_CPUS 1
 int userspace_pid[NR_CPUS];
 


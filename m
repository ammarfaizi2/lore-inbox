Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262881AbUKYAfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbUKYAfS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 19:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbUKXXZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:25:20 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:26116
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262947AbUKXXUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:20:38 -0500
Message-Id: <200411242306.iAON6dbn005408@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Milton Miller <miltonm@bga.com>
Subject: [PATCH] UML - Remove a quilt-induced duplicity
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 24 Nov 2004 18:06:39 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This piece appears to have gone in twice.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

===== arch/um/kernel/tt/trap_user.c 1.5 vs edited =====
Index: 2.6.9/arch/um/kernel/tt/trap_user.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/trap_user.c	2004-11-18 12:24:41.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/trap_user.c	2004-11-18 12:25:32.000000000 -0500
@@ -30,13 +30,6 @@
 	if(sig == SIGSEGV)
 		change_sig(SIGSEGV, 1);
 
-	/* This is done because to allow SIGSEGV to be delivered inside a SEGV
-	 * handler.  This can happen in copy_user, and if SEGV is disabled,
-	 * the process will die.
-	 */
-	if(sig == SIGSEGV)
-		change_sig(SIGSEGV, 1);
-
 	r = &TASK_REGS(get_current())->tt;
 	save_regs = *r;
 	is_user = user_context(SC_SP(sc));


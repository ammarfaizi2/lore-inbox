Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWAEWLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWAEWLj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWAEWLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:11:39 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:24233 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932253AbWAEWLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:11:38 -0500
Message-Id: <200601052303.k05N3aB6010886@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 5/4] UML - whitespace cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 05 Jan 2006 18:03:36 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes some mangled whitespace added by the earlier trap_user.c patch.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/os-Linux/skas/trap.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/skas/trap.c	2006-01-05 16:20:31.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/skas/trap.c	2006-01-05 17:07:57.000000000 -0500
@@ -34,11 +34,11 @@ void sig_handler_common_skas(int sig, vo
 	r = &TASK_REGS(get_current())->skas;
 	save_user = r->is_user;
 	r->is_user = 0;
-        if ( sig == SIGFPE || sig == SIGSEGV ||
-             sig == SIGBUS || sig == SIGILL ||
-             sig == SIGTRAP ) {
-                GET_FAULTINFO_FROM_SC(r->faultinfo, sc);
-        }
+	if ( sig == SIGFPE || sig == SIGSEGV ||
+	     sig == SIGBUS || sig == SIGILL ||
+	     sig == SIGTRAP ) {
+		GET_FAULTINFO_FROM_SC(r->faultinfo, sc);
+	}
 
 	change_sig(SIGUSR1, 1);
 
@@ -60,8 +60,8 @@ extern int ptrace_faultinfo;
 void user_signal(int sig, union uml_pt_regs *regs, int pid)
 {
 	void (*handler)(int, union uml_pt_regs *);
-        int segv = ((sig == SIGFPE) || (sig == SIGSEGV) || (sig == SIGBUS) ||
-                    (sig == SIGILL) || (sig == SIGTRAP));
+	int segv = ((sig == SIGFPE) || (sig == SIGSEGV) || (sig == SIGBUS) ||
+		    (sig == SIGILL) || (sig == SIGTRAP));
 
 	if (segv)
 		get_skas_faultinfo(pid, &regs->skas.faultinfo);


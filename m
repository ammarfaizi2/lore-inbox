Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVERE2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVERE2Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 00:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVERE2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 00:28:14 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:24845 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262078AbVEREZn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 00:25:43 -0400
Message-Id: <200505180420.j4I4KTsf017332@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Oleg Drokin <green@linuxhacker.ru>
Subject: [PATCH 6/9] UML - Export clear_user_*
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 May 2005 00:20:29 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Oleg Drokin:
This patch is needed to support kernel modules that want to use clear_user() 
(that is exported symbol on all other architectures).

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/kernel/ksyms.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/ksyms.c	2005-05-02 19:42:47.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/ksyms.c	2005-05-06 21:47:49.000000000 -0400
@@ -57,6 +57,7 @@
 EXPORT_SYMBOL(strncpy_from_user_skas);
 EXPORT_SYMBOL(copy_to_user_skas);
 EXPORT_SYMBOL(copy_from_user_skas);
+EXPORT_SYMBOL(clear_user_skas);
 #endif
 EXPORT_SYMBOL(uml_strdup);
 
Index: linux-2.6.12-rc/arch/um/kernel/tt/ksyms.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/tt/ksyms.c	2005-03-02 02:38:26.000000000 -0500
+++ linux-2.6.12-rc/arch/um/kernel/tt/ksyms.c	2005-05-06 21:47:49.000000000 -0400
@@ -12,6 +12,7 @@
 EXPORT_SYMBOL(__do_strncpy_from_user);
 EXPORT_SYMBOL(__do_strnlen_user); 
 EXPORT_SYMBOL(__do_clear_user);
+EXPORT_SYMBOL(clear_user_tt);
 
 EXPORT_SYMBOL(tracing_pid);
 EXPORT_SYMBOL(honeypot);


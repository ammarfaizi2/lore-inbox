Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWGGAg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWGGAg2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWGGAeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:34:20 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:54467 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751119AbWGGAdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:33:53 -0400
Message-Id: <200607070033.k670XaZ1008672@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 3/19] UML - Remove some useless exports
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jul 2006 20:33:36 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted by Al Viro - eliminate a couple useless exports.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/kernel/ksyms.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/ksyms.c	2006-06-06 12:12:44.000000000 -0400
+++ linux-2.6.16/arch/um/kernel/ksyms.c	2006-06-14 13:12:01.000000000 -0400
@@ -88,12 +88,6 @@ EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(do_gettimeofday);
 EXPORT_SYMBOL(do_settimeofday);
 
-/* This is here because UML expands lseek to sys_lseek, not to a system
- * call instruction.
- */
-EXPORT_SYMBOL(sys_lseek);
-EXPORT_SYMBOL(sys_wait4);
-
 #ifdef CONFIG_SMP
 
 /* required for SMP */


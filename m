Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWIZRzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWIZRzA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWIZRyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:54:41 -0400
Received: from [198.99.130.12] ([198.99.130.12]:6051 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932218AbWIZRyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:54:36 -0400
Message-Id: <200609261753.k8QHrJWN005535@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] UML - add an export
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Sep 2006 13:53:19 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some modules need strnlen_user_skas.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/kernel/ksyms.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/ksyms.c	2006-09-22 09:51:13.000000000 -0400
+++ linux-2.6.18-mm/arch/um/kernel/ksyms.c	2006-09-22 10:12:03.000000000 -0400
@@ -46,6 +46,7 @@ EXPORT_SYMBOL(copy_to_user_tt);
 #endif
 
 #ifdef CONFIG_MODE_SKAS
+EXPORT_SYMBOL(strnlen_user_skas);
 EXPORT_SYMBOL(strncpy_from_user_skas);
 EXPORT_SYMBOL(copy_to_user_skas);
 EXPORT_SYMBOL(copy_from_user_skas);


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWEARjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWEARjM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWEARjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:39:12 -0400
Received: from [198.99.130.12] ([198.99.130.12]:64391 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932172AbWEARjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:39:10 -0400
Message-Id: <200605011639.k41GdkGV004644@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH] UML - uml-makefile-nicer uses SYMLINK incorrectly
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 May 2006 12:39:46 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade's uml-makefile-nicer makes a V=0 build say SYMLINK where what's
happening is really a LINK.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/Makefile
===================================================================
--- linux-2.6.16.orig/arch/um/Makefile	2006-05-01 13:23:13.000000000 -0400
+++ linux-2.6.16/arch/um/Makefile	2006-05-01 13:28:47.000000000 -0400
@@ -96,7 +96,7 @@ PHONY += linux
 all: linux
 
 linux: vmlinux
-	@echo '  SYMLINK $@'
+	@echo '  LINK $@'
 	$(Q)ln -f $< $@
 
 define archhelp


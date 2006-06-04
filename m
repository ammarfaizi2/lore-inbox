Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWFDCQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWFDCQf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 22:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWFDCQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 22:16:15 -0400
Received: from [198.99.130.12] ([198.99.130.12]:39853 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751414AbWFDCQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 22:16:10 -0400
Message-Id: <200606040216.k542GFkU004837@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/6] UML - Fix a typo in do_uml_initcalls
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Jun 2006 22:16:15 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We had a spurious semicolon somehow.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17-mm/arch/um/os-Linux/main.c
===================================================================
--- linux-2.6.17-mm.orig/arch/um/os-Linux/main.c	2006-05-01 14:37:32.000000000 -0400
+++ linux-2.6.17-mm/arch/um/os-Linux/main.c	2006-05-07 11:01:01.000000000 -0400
@@ -59,7 +59,7 @@ static __init void do_uml_initcalls(void
 	initcall_t *call;
 
 	call = &__uml_initcall_start;
-	while (call < &__uml_initcall_end){;
+	while (call < &__uml_initcall_end){
 		(*call)();
 		call++;
 	}


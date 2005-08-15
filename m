Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbVHOXh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbVHOXh0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 19:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbVHOXh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 19:37:26 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:26632 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S965032AbVHOXhZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 19:37:25 -0400
Message-Id: <200508152325.j7FNP4JX009004@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 2/4] UML - 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 15 Aug 2005 19:25:04 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Al Viro:

Fix a macro typo which could break if the macro is passed arguments with
side-effects.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-rc6/arch/um/include/sysdep-x86_64/ptrace.h
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/include/sysdep-x86_64/ptrace.h	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/include/sysdep-x86_64/ptrace.h	2005-08-15 13:32:57.000000000 -0400
@@ -227,7 +227,7 @@
                         panic("Bad register in UPT_SET : %d\n", reg);  \
 			break; \
                 } \
-                val; \
+                __upt_val; \
         })
 
 #define UPT_SET_SYSCALL_RETURN(r, res) \


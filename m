Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWADVBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWADVBv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWADVAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:00:00 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:52638 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751292AbWADU7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:59:55 -0500
Message-Id: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/9] UML - Better diagnostics for broken configs
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Jan 2006 16:51:59 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Produce a compile-time error if both MODE_SKAS and MODE_TT are disabled.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/include/choose-mode.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/choose-mode.h	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.15/arch/um/include/choose-mode.h	2005-11-17 10:43:47.000000000 -0500
@@ -23,6 +23,9 @@ static inline void *__choose_mode(void *
 
 #elif defined(UML_CONFIG_MODE_TT)
 #define CHOOSE_MODE(tt, skas) (tt)
+
+#else
+#error CONFIG_MODE_SKAS and CONFIG_MODE_TT are both disabled
 #endif
 
 #define CHOOSE_MODE_PROC(tt, skas, args...) \


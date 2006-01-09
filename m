Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWAIDS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWAIDS4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 22:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWAIDS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 22:18:56 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:42693 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751029AbWAIDSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 22:18:55 -0500
Message-Id: <200601090410.k094Auss001185@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/6] UML - Update Kconfig help
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 08 Jan 2006 23:10:56 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The MODE_TT help was a little outdated.  This updates it in light of the
existence of skas0 mode.
It's also turned off by default since it is mostly obsoleted by skas0 mode.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/Kconfig
===================================================================
--- linux-2.6.15-mm.orig/arch/um/Kconfig	2006-01-06 21:05:23.000000000 -0500
+++ linux-2.6.15-mm/arch/um/Kconfig	2006-01-06 23:34:46.000000000 -0500
@@ -35,12 +35,12 @@ menu "UML-specific options"
 
 config MODE_TT
 	bool "Tracing thread support"
-	default y
+	default n
 	help
 	This option controls whether tracing thread support is compiled
-	into UML.  Normally, this should be set to Y.  If you intend to
-	use only skas mode (and the host has the skas patch applied to it),
-	then it is OK to say N here.
+	into UML.  This option is largely obsolete, given that skas0 provides
+	skas security and performance without needing to patch the host.
+	It is safe to say 'N' here.
 
 config STATIC_LINK
 	bool "Force a static link"


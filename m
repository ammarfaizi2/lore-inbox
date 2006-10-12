Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWJLSKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWJLSKH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWJLSKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:10:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:31928 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751121AbWJLSKF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:10:05 -0400
Date: Thu, 12 Oct 2006 19:10:04 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: [PATCH] uml shouldn't do HEADERS_CHECK
Message-ID: <20061012181004.GJ29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The lack of asm-um/Kbuild is deliberate.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5628303..c9ac416 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -373,6 +373,7 @@ config FORCED_INLINING
 
 config HEADERS_CHECK
 	bool "Run 'make headers_check' when building vmlinux"
+	depends on !UML
 	help
 	  This option will extract the user-visible kernel headers whenever
 	  building the kernel, and will run basic sanity checks on them to

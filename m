Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWGKMnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWGKMnj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 08:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWGKMnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 08:43:39 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:45768 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751249AbWGKMnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 08:43:39 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 1/7] AVR32: CONFIG_DEBUG_BUGVERBOSE and CONFIG_FRAME_POINTER
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 11 Jul 2006 14:43:16 +0200
Message-Id: <11526218022840-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11526218021728-git-send-email-hskinnemoen@atmel.com>
References: <11526218021728-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add AVR32 to the list of architectures these two config options
depend on.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>

---
 lib/Kconfig.debug |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e5889b1..0eba43c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -275,7 +275,7 @@ config DEBUG_HIGHMEM
 config DEBUG_BUGVERBOSE
 	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EMBEDDED
 	depends on BUG
-	depends on ARM || ARM26 || M32R || M68K || SPARC32 || SPARC64 || X86_32 || FRV
+	depends on ARM || ARM26 || AVR32 || M32R || M68K || SPARC32 || SPARC64 || X86_32 || FRV
 	default !EMBEDDED
 	help
 	  Say Y here to make BUG() panics output the file name and line number
@@ -313,7 +313,7 @@ config DEBUG_VM
 
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
-	depends on DEBUG_KERNEL && (X86 || CRIS || M68K || M68KNOMMU || FRV || UML || S390)
+	depends on DEBUG_KERNEL && (X86 || CRIS || M68K || M68KNOMMU || FRV || UML || S390 || AVR32)
 	default y if DEBUG_INFO && UML
 	help
 	  If you say Y here the resulting kernel image will be slightly larger
-- 
1.4.0


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbTH2Rm5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTH2Rm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:42:56 -0400
Received: from zero.aec.at ([193.170.194.10]:36364 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261832AbTH2Rmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:42:50 -0400
Date: Fri, 29 Aug 2003 19:42:36 +0200
From: Andi Kleen <ak@muc.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove SSE2 bugs.h check
Message-ID: <20030829174236.GA11273@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Remove some dead code.

CONFIG_SSE2 hasn't been defined for some time, because everything
SSE related is handled at runtime based on cpuid.

-Andi

diff -u linux-2.6.0test4-work/include/asm-i386/bugs.h-o linux-2.6.0test4-work/include/asm-i386/bugs.h
--- linux-2.6.0test4-work/include/asm-i386/bugs.h-o	2003-05-27 03:00:24.000000000 +0200
+++ linux-2.6.0test4-work/include/asm-i386/bugs.h	2003-08-29 19:39:15.000000000 +0200
@@ -193,11 +193,6 @@
 	    && (boot_cpu_data.x86_mask < 6 || boot_cpu_data.x86_mask == 11))
 		panic("Kernel compiled for PMMX+, assumes a local APIC without the read-before-write bug!");
 #endif
-
-#ifdef CONFIG_X86_SSE2
-	if (!cpu_has_sse2)
-		panic("Kernel compiled for SSE2, CPU doesn't have it.");
-#endif
 }
 
 extern void alternative_instructions(void);



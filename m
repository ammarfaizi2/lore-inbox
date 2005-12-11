Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVLKOSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVLKOSF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 09:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbVLKOSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 09:18:05 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:64428 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750709AbVLKOSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 09:18:04 -0500
Date: Sun, 11 Dec 2005 15:17:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>
Subject: [patch -mm] DEBUG_SLAB depends on SLAB
Message-ID: <20051211141716.GA8500@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.6 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

another SLOB related patch: make DEBUG_SLAB depend on SLAB.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -100,7 +100,7 @@ config SCHEDSTATS
 
 config DEBUG_SLAB
 	bool "Debug memory allocations"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && SLAB
 	help
 	  Say Y here to have the kernel do limited verification on memory
 	  allocation as well as poisoning memory on free to catch use of freed

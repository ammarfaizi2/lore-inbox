Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266357AbUIAMuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266357AbUIAMuG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 08:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUIAMuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 08:50:06 -0400
Received: from ozlabs.org ([203.10.76.45]:4327 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266357AbUIAMtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 08:49:55 -0400
Date: Wed, 1 Sep 2004 22:48:10 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [ppc64] Enable DEBUG_SPINLOCK_SLEEP
Message-ID: <20040901124810.GP26072@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

DEBUG_SPINLOCK_SLEEP is useful on ppc64, so allow it to be selected.

Anton

Signed-off-by: Anton Blanchard <anton@samba.org>

===== lib/Kconfig.debug 1.1 vs edited =====
--- 1.1/lib/Kconfig.debug	Mon Aug 16 05:45:42 2004
+++ edited/lib/Kconfig.debug	Wed Aug 25 14:05:26 2004
@@ -47,7 +47,7 @@
 
 config DEBUG_SPINLOCK_SLEEP
 	bool "Sleep-inside-spinlock checking"
-	depends on DEBUG_KERNEL && (X86 || IA64 || MIPS || PPC32 || ARCH_S390 || SPARC32 || SPARC64)
+	depends on DEBUG_KERNEL && (X86 || IA64 || MIPS || PPC32 || PPC64 || ARCH_S390 || SPARC32 || SPARC64)
 	help
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.

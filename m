Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161152AbVKDP7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161152AbVKDP7k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161153AbVKDP7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:59:40 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21005 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161152AbVKDP7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:59:39 -0500
Date: Fri, 4 Nov 2005 16:59:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/kernel/ldt.c should #include <asm/mmu_context.h>
Message-ID: <20051104155937.GB5368@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the header files containing the prototypes of 
it's global functions


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 3 Oct 2005

--- linux-2.6.14-rc2-mm2-full/arch/i386/kernel/ldt.c.old	2005-10-02 02:07:44.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/arch/i386/kernel/ldt.c	2005-10-02 02:10:57.000000000 +0200
@@ -18,6 +18,7 @@
 #include <asm/system.h>
 #include <asm/ldt.h>
 #include <asm/desc.h>
+#include <asm/mmu_context.h>
 
 #ifdef CONFIG_SMP /* avoids "defined but not used" warnig */
 static void flush_ldt(void *null)

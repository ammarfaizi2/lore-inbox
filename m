Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWCaO4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWCaO4u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 09:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWCaO4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 09:56:50 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27403 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751377AbWCaO4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 09:56:50 -0500
Date: Fri, 31 Mar 2006 16:56:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: [-mm patch] arch/i386/kernel/apic.c: make modern_apic() static
Message-ID: <20060331145648.GG3893@stusta.de>
References: <20060328003508.2b79c050.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328003508.2b79c050.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a nnedlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/kernel/apic.c |    2 +-
 include/asm-i386/apic.h |    2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

--- linux-2.6.16-mm2-full/include/asm-i386/apic.h.old	2006-03-31 15:32:14.000000000 +0200
+++ linux-2.6.16-mm2-full/include/asm-i386/apic.h	2006-03-31 15:32:22.000000000 +0200
@@ -139,8 +139,6 @@
 
 extern int timer_over_8254;
 
-extern int modern_apic(void);
-
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
 
--- linux-2.6.16-mm2-full/arch/i386/kernel/apic.c.old	2006-03-31 15:32:30.000000000 +0200
+++ linux-2.6.16-mm2-full/arch/i386/kernel/apic.c	2006-03-31 15:32:36.000000000 +0200
@@ -62,7 +62,7 @@
 
 static void apic_pm_activate(void);
 
-int modern_apic(void)
+static int modern_apic(void)
 {
 	unsigned int lvr, version;
 	/* AMD systems use old APIC versions, so check the CPU */


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751711AbWF3Ldt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbWF3Ldt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 07:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWF3Ldq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 07:33:46 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18184 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751673AbWF3LdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 07:33:18 -0400
Date: Fri, 30 Jun 2006 13:33:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] EXPORT_UNUSED_SYMBOL{,GPL} {,un}register_die_notifier
Message-ID: <20060630113317.GV19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch marks {,un}register_die_notifier as 
EXPORT_UNUSED_SYMBOL{,GPL}.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/kernel/traps.c    |    4 ++--
 arch/ia64/kernel/traps.c    |    4 ++--
 arch/powerpc/kernel/traps.c |    4 ++--
 arch/sparc64/kernel/traps.c |    4 ++--
 arch/x86_64/kernel/traps.c  |    4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

--- linux-2.6.17-mm4-full/arch/i386/kernel/traps.c.old	2006-06-30 04:06:31.000000000 +0200
+++ linux-2.6.17-mm4-full/arch/i386/kernel/traps.c	2006-06-30 04:07:26.000000000 +0200
@@ -101,13 +101,13 @@
 	vmalloc_sync_all();
 	return atomic_notifier_chain_register(&i386die_chain, nb);
 }
-EXPORT_SYMBOL(register_die_notifier);
+EXPORT_UNUSED_SYMBOL(register_die_notifier);  /*  June 2006  */
 
 int unregister_die_notifier(struct notifier_block *nb)
 {
 	return atomic_notifier_chain_unregister(&i386die_chain, nb);
 }
-EXPORT_SYMBOL(unregister_die_notifier);
+EXPORT_UNUSED_SYMBOL(unregister_die_notifier);  /*  June 2006  */
 
 static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
 {
--- linux-2.6.17-mm4-full/arch/ia64/kernel/traps.c.old	2006-06-30 04:07:35.000000000 +0200
+++ linux-2.6.17-mm4-full/arch/ia64/kernel/traps.c	2006-06-30 04:09:20.000000000 +0200
@@ -37,14 +37,14 @@
 {
 	return atomic_notifier_chain_register(&ia64die_chain, nb);
 }
-EXPORT_SYMBOL_GPL(register_die_notifier);
+EXPORT_UNUSED_SYMBOL_GPL(register_die_notifier);  /*  June 2006  */
 
 int
 unregister_die_notifier(struct notifier_block *nb)
 {
 	return atomic_notifier_chain_unregister(&ia64die_chain, nb);
 }
-EXPORT_SYMBOL_GPL(unregister_die_notifier);
+EXPORT_UNUSED_SYMBOL_GPL(unregister_die_notifier);  /*  June 2006  */
 
 void __init
 trap_init (void)
--- linux-2.6.17-mm4-full/arch/powerpc/kernel/traps.c.old	2006-06-30 04:09:35.000000000 +0200
+++ linux-2.6.17-mm4-full/arch/powerpc/kernel/traps.c	2006-06-30 04:11:35.000000000 +0200
@@ -85,13 +85,13 @@
 {
 	return atomic_notifier_chain_register(&powerpc_die_chain, nb);
 }
-EXPORT_SYMBOL(register_die_notifier);
+EXPORT_UNUSED_SYMBOL(register_die_notifier);  /*  June 2006  */
 
 int unregister_die_notifier(struct notifier_block *nb)
 {
 	return atomic_notifier_chain_unregister(&powerpc_die_chain, nb);
 }
-EXPORT_SYMBOL(unregister_die_notifier);
+EXPORT_UNUSED_SYMBOL(unregister_die_notifier);  /*  June 2006  */
 
 /*
  * Trap & Exception support
--- linux-2.6.17-mm4-full/arch/sparc64/kernel/traps.c.old	2006-06-30 04:11:46.000000000 +0200
+++ linux-2.6.17-mm4-full/arch/sparc64/kernel/traps.c	2006-06-30 04:12:11.000000000 +0200
@@ -50,13 +50,13 @@
 {
 	return atomic_notifier_chain_register(&sparc64die_chain, nb);
 }
-EXPORT_SYMBOL(register_die_notifier);
+EXPORT_UNUSED_SYMBOL(register_die_notifier);  /*  June 2006  */
 
 int unregister_die_notifier(struct notifier_block *nb)
 {
 	return atomic_notifier_chain_unregister(&sparc64die_chain, nb);
 }
-EXPORT_SYMBOL(unregister_die_notifier);
+EXPORT_UNUSED_SYMBOL(unregister_die_notifier);  /*  June 2006  */
 
 /* When an irrecoverable trap occurs at tl > 0, the trap entry
  * code logs the trap state registers at every level in the trap
--- linux-2.6.17-mm4-full/arch/x86_64/kernel/traps.c.old	2006-06-30 04:12:18.000000000 +0200
+++ linux-2.6.17-mm4-full/arch/x86_64/kernel/traps.c	2006-06-30 04:12:48.000000000 +0200
@@ -77,13 +77,13 @@
 	vmalloc_sync_all();
 	return atomic_notifier_chain_register(&die_chain, nb);
 }
-EXPORT_SYMBOL(register_die_notifier);
+EXPORT_UNUSED_SYMBOL(register_die_notifier);  /*  June 2006  */
 
 int unregister_die_notifier(struct notifier_block *nb)
 {
 	return atomic_notifier_chain_unregister(&die_chain, nb);
 }
-EXPORT_SYMBOL(unregister_die_notifier);
+EXPORT_UNUSED_SYMBOL(unregister_die_notifier);  /*  June 2006  */
 
 static inline void conditional_sti(struct pt_regs *regs)
 {


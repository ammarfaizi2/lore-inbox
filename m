Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWFWPkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWFWPkz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWFWPkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:40:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25178 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751244AbWFWPky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:40:54 -0400
Date: Fri, 23 Jun 2006 11:40:53 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix silly ARM non-EABI build error
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Cc: Uwe Zeisberger <Uwe_Zeisberger@digi.com>,
       Russell King <rmk@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0606231136001.28771@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My bad.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index e9fe780..f094277 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -687,7 +687,7 @@ #else
 				 * syscall solves that issue and works for
 				 * all those cases.
 				 */
-				swival = swival - __NR_SYSCAll_BASE + __NR_OABI_SYSCALL_BASE;
+				swival = swival - __NR_SYSCALL_BASE + __NR_OABI_SYSCALL_BASE;
 
 				put_user(regs->ARM_pc, &usp[0]);
 				/* swi __NR_restart_syscall */

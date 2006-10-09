Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWJIDuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWJIDuG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 23:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbWJIDuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 23:50:05 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:44175 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751646AbWJIDuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 23:50:04 -0400
Message-Id: <200610090243.k992hEOi010287@laptop13.inf.utfsm.cl>
To: linux-kernel@vger.kernel.org
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: [PATCH] Fix call to profile_tick() for non-SMP SPARC64
X-Mailer: git-send-email 1.4.2.3.g7a0cf
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Date: Sun, 08 Oct 2006 22:43:14 -0400
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sun, 08 Oct 2006 23:50:03 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Horst von Brand <vonbrand@pincoya.inf.utfsm.cl>
---
 arch/sparc64/kernel/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index 00f6fc4..36c74cf 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -460,7 +460,7 @@ irqreturn_t timer_interrupt(int irq, voi
 
 	do {
 #ifndef CONFIG_SMP
-		profile_tick(CPU_PROFILING, regs);
+		profile_tick(CPU_PROFILING);
 		update_process_times(user_mode(regs));
 #endif
 		do_timer(1);
-- 
1.4.2.3.g7a0cf

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVDLTjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVDLTjG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVDLTgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:36:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:1993 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262185AbVDLKcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:05 -0400
Message-Id: <200504121031.j3CAVwge005463@shell0.pdx.osdl.net>
Subject: [patch 084/198] x86_64: Remove unused macro in preempt support
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

Remove unused macro in preempt support

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/entry.S |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)

diff -puN arch/x86_64/kernel/entry.S~x86_64-remove-unused-macro-in-preempt-support arch/x86_64/kernel/entry.S
--- 25/arch/x86_64/kernel/entry.S~x86_64-remove-unused-macro-in-preempt-support	2005-04-12 03:21:23.267599688 -0700
+++ 25-akpm/arch/x86_64/kernel/entry.S	2005-04-12 03:21:23.270599232 -0700
@@ -44,10 +44,7 @@
 
 	.code64
 
-#ifdef CONFIG_PREEMPT
-#define preempt_stop cli
-#else
-#define preempt_stop
+#ifndef CONFIG_PREEMPT
 #define retint_kernel retint_restore_args
 #endif	
 	
_

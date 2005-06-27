Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVF0SCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVF0SCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 14:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVF0SCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 14:02:38 -0400
Received: from fmr19.intel.com ([134.134.136.18]:32230 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261408AbVF0SCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 14:02:36 -0400
Date: Mon, 27 Jun 2005 11:02:03 -0700
Message-Id: <200506271802.j5RI23OP010589@linux.jf.intel.com>
From: Rusty Lynch <rusty.lynch@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       linux-kernel@vger.kernel.org
Subject: [patch] ia64 kprobes build fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes an ia64 build failure when kprobes is enabled
as a result of the single-step out of line patch that expects each architecture
do define MAX_INSN_SIZE.

Signed-off-by: Rusty Lynch <rusty.lynch@intel.com>

 include/asm-ia64/kprobes.h |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.12-mm2/include/asm-ia64/kprobes.h
===================================================================
--- linux-2.6.12-mm2.orig/include/asm-ia64/kprobes.h
+++ linux-2.6.12-mm2/include/asm-ia64/kprobes.h
@@ -28,6 +28,7 @@
 #include <linux/ptrace.h>
 #include <asm/break.h>
 
+#define MAX_INSN_SIZE   16
 #define BREAK_INST	(long)(__IA64_BREAK_KPROBE << 6)
 
 typedef union cmp_inst {

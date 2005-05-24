Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVEXBMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVEXBMJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 21:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVEXBIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 21:08:09 -0400
Received: from fmr19.intel.com ([134.134.136.18]:23769 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261303AbVEXBEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 21:04:23 -0400
Date: Mon, 23 May 2005 18:04:13 -0700
Message-Id: <200505240104.j4O14Deh016713@linux.jf.intel.com>
From: Rusty Lynch <rusty.lynch@intel.com>
To: akpm@osdl.org
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Rusty Lynch <rusty.lynch@intel.com>
Subject: [patch 1/1] Add missing jprobe macro for ia64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following minimal patch adds a missing macro that is expected
from each architecture supporting Jprobes, but was left out of
this mornings ia64 support patches.  This patch applies to all the 
previous kprobes patches that have already made it into your next 
mm series.

    --rusty

signed-off-by: Rusty Lynch <Rusty.lynch@intel.com>

 include/asm-ia64/kprobes.h |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-2.6.12-rc4/include/asm-ia64/kprobes.h
===================================================================
--- linux-2.6.12-rc4.orig/include/asm-ia64/kprobes.h
+++ linux-2.6.12-rc4/include/asm-ia64/kprobes.h
@@ -53,6 +53,8 @@ typedef struct _bundle {
 #define LONG_BRANCH_OPCODE		(0xC)
 #define LONG_CALL_OPCODE		(0xD)
 
+#define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
+
 typedef struct kprobe_opcode {
 	bundle_t bundle;
 } kprobe_opcode_t;

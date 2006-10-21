Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993153AbWJUQzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993153AbWJUQzq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993141AbWJUQva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:51:30 -0400
Received: from mx1.suse.de ([195.135.220.2]:41116 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S2993137AbWJUQv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:51:26 -0400
From: Andi Kleen <ak@suse.de>
References: <20061021 651.356252000@suse.de>
In-Reply-To: <20061021 651.356252000@suse.de>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Jan Beulich <jbeulich@novell.com>, Ingo Molnar <mingo@elte.hu>,
       patches@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [5/19] i386: fix .cfi_signal_frame copy-n-paste error
Message-Id: <20061021165124.E6E0F13CB4@wotan.suse.de>
Date: Sat, 21 Oct 2006 18:51:24 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andrew Morton <akpm@osdl.org>

This was copied, pasted but not edited.

Cc: Andi Kleen <ak@muc.de>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Andi Kleen <ak@suse.de>

---

 arch/i386/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux/arch/i386/Makefile
===================================================================
--- linux.orig/arch/i386/Makefile
+++ linux/arch/i386/Makefile
@@ -51,8 +51,8 @@ cflags-y += $(call as-instr,.cfi_startpr
 AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
 
 # is .cfi_signal_frame supported too?
-cflags-y += $(call as-instr,.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
-AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
+cflags-y += $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1,)
+AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1,)
 
 CFLAGS += $(cflags-y)
 

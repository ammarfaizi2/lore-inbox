Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWHJUII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWHJUII (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbWHJUES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:04:18 -0400
Received: from ns1.suse.de ([195.135.220.2]:60560 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932636AbWHJTgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:43 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [85/145] x86_64: Fix gdt table size in trampoline.S
Message-Id: <20060810193642.3724C13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:42 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: "Eric W. Biederman" <ebiederm@xmission.com>

Allows easier extension of the GDT by using the proper C symbol
for the size in the descriptor.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/trampoline.S |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux/arch/x86_64/kernel/trampoline.S
===================================================================
--- linux.orig/arch/x86_64/kernel/trampoline.S
+++ linux/arch/x86_64/kernel/trampoline.S
@@ -64,7 +64,7 @@ idt_48:
 	.word	0, 0			# idt base = 0L
 
 gdt_48:
-	.short	__KERNEL32_CS + 7	# gdt limit
+	.short	GDT_ENTRIES*8 - 1	# gdt limit
 	.long	cpu_gdt_table-__START_KERNEL_map
 
 .globl trampoline_end

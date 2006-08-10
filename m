Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWHJTvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWHJTvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWHJTvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:51:54 -0400
Received: from mx1.suse.de ([195.135.220.2]:26257 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932663AbWHJThV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:21 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [121/145] x86_64: Make boot_param_data pure BSS
Message-Id: <20060810193720.5F08A13B8E@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:20 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Since it's all zero.

Actually I think gcc 4+ will do that automatically, but earlier compilers won't
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/setup64.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux/arch/x86_64/kernel/setup64.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup64.c
+++ linux/arch/x86_64/kernel/setup64.c
@@ -24,7 +24,7 @@
 #include <asm/proto.h>
 #include <asm/sections.h>
 
-char x86_boot_params[BOOT_PARAM_SIZE] __initdata = {0,};
+char x86_boot_params[BOOT_PARAM_SIZE] __initdata;
 
 cpumask_t cpu_initialized __cpuinitdata = CPU_MASK_NONE;
 

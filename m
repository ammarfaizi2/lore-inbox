Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932668AbWHJUBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668AbWHJUBt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWHJT7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:59:35 -0400
Received: from mx1.suse.de ([195.135.220.2]:3729 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932649AbWHJTgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:53 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [95/145] x86_64: Move e820 map into e820.c
Message-Id: <20060810193652.C8E7313C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:52 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Minor cleanup. Keep setup.c free from unrelated clutter.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/e820.c  |    2 ++
 arch/x86_64/kernel/setup.c |    1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: linux/arch/x86_64/kernel/e820.c
===================================================================
--- linux.orig/arch/x86_64/kernel/e820.c
+++ linux/arch/x86_64/kernel/e820.c
@@ -24,6 +24,8 @@
 #include <asm/bootsetup.h>
 #include <asm/sections.h>
 
+struct e820map e820 __initdata;
+
 /* 
  * PFN of last memory page.
  */
Index: linux/arch/x86_64/kernel/setup.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup.c
+++ linux/arch/x86_64/kernel/setup.c
@@ -97,7 +97,6 @@ struct sys_desc_table_struct {
 
 struct edid_info edid_info;
 EXPORT_SYMBOL_GPL(edid_info);
-struct e820map e820;
 
 extern int root_mountflags;
 

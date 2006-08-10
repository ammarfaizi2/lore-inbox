Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932694AbWHJTld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbWHJTld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbWHJTiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:38:12 -0400
Received: from ns2.suse.de ([195.135.220.15]:27116 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932694AbWHJThp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:45 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [139/145] x86_64: mark init_amd() as __cpuinit
Message-Id: <20060810193739.82CC713C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:39 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Magnus Damm <magnus@valinux.co.jp>

The init_amd() function is only called from identify_cpu() which is already
marked as __cpuinit. So let's mark it as __cpuinit.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
Signed-off-by: Andi Kleen <ak@suse.de>

---

 arch/x86_64/kernel/setup.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux/arch/x86_64/kernel/setup.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup.c
+++ linux/arch/x86_64/kernel/setup.c
@@ -674,7 +674,7 @@ static void __init amd_detect_cmp(struct
 #endif
 }
 
-static void __init init_amd(struct cpuinfo_x86 *c)
+static void __cpuinit init_amd(struct cpuinfo_x86 *c)
 {
 	unsigned level;
 

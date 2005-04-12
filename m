Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262500AbVDMDLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbVDMDLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVDLTdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:33:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:7881 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262188AbVDLKcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:13 -0400
Message-Id: <200504121032.j3CAW17m005475@shell0.pdx.osdl.net>
Subject: [patch 087/198] x86_64: Don't assume future AMD CPUs have K8 compatible performance counters
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

The NMI watchdog code did this incorrectly

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/nmi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/x86_64/kernel/nmi.c~x86_64-dont-assume-future-amd-cpus-have-k8-compatible arch/x86_64/kernel/nmi.c
--- 25/arch/x86_64/kernel/nmi.c~x86_64-dont-assume-future-amd-cpus-have-k8-compatible	2005-04-12 03:21:23.910501952 -0700
+++ 25-akpm/arch/x86_64/kernel/nmi.c	2005-04-12 03:21:23.913501496 -0700
@@ -336,7 +336,7 @@ void setup_apic_nmi_watchdog(void)
 {
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
-		if (boot_cpu_data.x86 < 6)
+		if (boot_cpu_data.x86 != 15)
 			return;
 		if (strstr(boot_cpu_data.x86_model_id, "Screwdriver"))
 			return;
_

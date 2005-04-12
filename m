Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVDLTZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVDLTZU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVDLTYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:24:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:18889 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262197AbVDLKcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:20 -0400
Message-Id: <200504121032.j3CAWDD5005537@shell0.pdx.osdl.net>
Subject: [patch 100/198] x86_64: Add acpi_skip_timer_override option
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

Add acpi_skip_timer_override option.  It was missing previously.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/setup.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN arch/x86_64/kernel/setup.c~x86_64-add-acpi_skip_timer_override-option arch/x86_64/kernel/setup.c
--- 25/arch/x86_64/kernel/setup.c~x86_64-add-acpi_skip_timer_override-option	2005-04-12 03:21:26.946040480 -0700
+++ 25-akpm/arch/x86_64/kernel/setup.c	2005-04-12 03:21:26.950039872 -0700
@@ -327,6 +327,10 @@ static __init void parse_cmdline_early (
 		else if (!memcmp(from, "acpi=strict", 11)) {
 			acpi_strict = 1;
 		}
+#ifdef CONFIG_X86_IO_APIC
+		else if (!memcmp(from, "acpi_skip_timer_override", 24))
+			acpi_skip_timer_override = 1;
+#endif
 #endif
 
 		if (!memcmp(from, "nolapic", 7) ||
_

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWHJUYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWHJUYZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWHJUOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:14:38 -0400
Received: from cantor2.suse.de ([195.135.220.15]:44523 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932612AbWHJTgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:19 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [62/145] x86_64: Remove useless wrapper in mpparse.c code
Message-Id: <20060810193617.BF92613B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:17 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

It used to contain support code for NUMAQ, but that is long gone already
on 64bit.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/mpparse.c |   11 +----------
 1 files changed, 1 insertion(+), 10 deletions(-)

Index: linux/arch/x86_64/kernel/mpparse.c
===================================================================
--- linux.orig/arch/x86_64/kernel/mpparse.c
+++ linux/arch/x86_64/kernel/mpparse.c
@@ -579,7 +579,7 @@ static int __init smp_scan_config (unsig
 	return 0;
 }
 
-void __init find_intel_smp (void)
+void __init find_smp_config(void)
 {
 	unsigned int address;
 
@@ -617,15 +617,6 @@ void __init find_intel_smp (void)
 	 printk(KERN_INFO "No mptable found.\n");
 }
 
-/*
- * - Intel MP Configuration Table
- */
-void __init find_smp_config (void)
-{
-	find_intel_smp();
-}
-
-
 /* --------------------------------------------------------------------------
                             ACPI-based MP Configuration
    -------------------------------------------------------------------------- */

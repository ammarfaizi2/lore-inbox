Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbVBXXoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbVBXXoC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 18:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbVBXXmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 18:42:53 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57865 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262572AbVBXXhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:37:40 -0500
Date: Fri, 25 Feb 2005 00:37:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport mmu_cr4_features
Message-ID: <20050224233739.GQ8651@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't found any possible modular usage of mmu_cr4_features in the 
kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 20 Jan 2005

 arch/i386/kernel/setup.c   |    1 -
 arch/x86_64/kernel/setup.c |    1 -
 2 files changed, 2 deletions(-)

--- linux-2.6.11-rc1-mm2-full/arch/i386/kernel/setup.c.old	2005-01-20 18:26:25.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/i386/kernel/setup.c	2005-01-20 18:26:32.000000000 +0100
@@ -77,7 +77,6 @@
 struct cpuinfo_x86 boot_cpu_data = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
 
 unsigned long mmu_cr4_features;
-EXPORT_SYMBOL_GPL(mmu_cr4_features);
 
 #ifdef	CONFIG_ACPI_INTERPRETER
 	int acpi_disabled = 0;
--- linux-2.6.11-rc1-mm2-full/arch/x86_64/kernel/setup.c.old	2005-01-20 18:26:39.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/x86_64/kernel/setup.c	2005-01-20 18:26:43.000000000 +0100
@@ -67,7 +67,6 @@
 struct cpuinfo_x86 boot_cpu_data;
 
 unsigned long mmu_cr4_features;
-EXPORT_SYMBOL_GPL(mmu_cr4_features);
 
 int acpi_disabled;
 EXPORT_SYMBOL(acpi_disabled);


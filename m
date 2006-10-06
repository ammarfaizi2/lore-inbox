Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWJFJfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWJFJfg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 05:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWJFJfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 05:35:36 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:32767 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1751375AbWJFJfe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 05:35:34 -0400
Date: Fri, 6 Oct 2006 02:35:25 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@hpl.hp.com>
Subject: [PATCH] i386 rename X86_FEATURE_DTES to X86_FEATURE_DS
Message-ID: <20061006093525.GA9063@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a patch (used by perfmon2) that renames X86_FEATURE_DTES
to X86_FEATURE_DS to match Intel's documentation for the Debug Store
save area on i386. The patch also adds cpu_has_ds.

changelog:
        - rename X86_FEATURE_DTES to X86_FEATURE_DS to match documentation
        - adds cpu_has_ds to test for X86_FEATURE_DS

signed-off-by: stephane eranian <eranian@hpl.hp.com>


diff --git a/include/asm-i386/cpufeature.h b/include/asm-i386/cpufeature.h
index d314ebb..69ce350 100644
--- a/include/asm-i386/cpufeature.h
+++ b/include/asm-i386/cpufeature.h
@@ -31,7 +31,7 @@ #define X86_FEATURE_PAT		(0*32+16) /* Pa
 #define X86_FEATURE_PSE36	(0*32+17) /* 36-bit PSEs */
 #define X86_FEATURE_PN		(0*32+18) /* Processor serial number */
 #define X86_FEATURE_CLFLSH	(0*32+19) /* Supports the CLFLUSH instruction */
-#define X86_FEATURE_DTES	(0*32+21) /* Debug Trace Store */
+#define X86_FEATURE_DS		(0*32+21) /* Debug Store */
 #define X86_FEATURE_ACPI	(0*32+22) /* ACPI via MSR */
 #define X86_FEATURE_MMX		(0*32+23) /* Multimedia Extensions */
 #define X86_FEATURE_FXSR	(0*32+24) /* FXSAVE and FXRSTOR instructions (fast save and restore */
@@ -134,6 +134,7 @@ #define cpu_has_phe		boot_cpu_has(X86_FE
 #define cpu_has_phe_enabled	boot_cpu_has(X86_FEATURE_PHE_EN)
 #define cpu_has_pmm		boot_cpu_has(X86_FEATURE_PMM)
 #define cpu_has_pmm_enabled	boot_cpu_has(X86_FEATURE_PMM_EN)
+#define cpu_has_ds		boot_cpu_has(X86_FEATURE_DS)
 
 #endif /* __ASM_I386_CPUFEATURE_H */
 

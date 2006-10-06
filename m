Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWJFI7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWJFI7u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 04:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWJFI7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 04:59:49 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:57542 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1751371AbWJFI7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 04:59:49 -0400
Date: Fri, 6 Oct 2006 01:59:36 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, Stephane Eranian <eranian@hpl.hp.com>
Subject: [PATCH] x86_64 rename X86_FEATURE_DTES to X86_FEATURE_DS
Message-ID: <20061006085936.GC8793@frankl.hpl.hp.com>
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

Hello,

Here is a patch (used by perfmon2) that renamed X86_FEATURE_DTES
to X86_FEATURE_DS to match Intel's documentation for the Debug Store
save area. The patch also adds cpu_has_ds.

changelog:
	- rename X86_FEATURE_DTES to X86_FEATURE_DS to match documentation
	- adds cpu_has_ds to test for X86_FEATURE_DS

signed-off-by: stephane eranian <eranian@hpl.hp.com>

diff --git a/include/asm-x86_64/cpufeature.h b/include/asm-x86_64/cpufeature.h
index ee792fa..65eb39e 100644
--- a/include/asm-x86_64/cpufeature.h
+++ b/include/asm-x86_64/cpufeature.h
@@ -29,7 +29,7 @@ #define X86_FEATURE_PAT		(0*32+16) /* Pa
 #define X86_FEATURE_PSE36	(0*32+17) /* 36-bit PSEs */
 #define X86_FEATURE_PN		(0*32+18) /* Processor serial number */
 #define X86_FEATURE_CLFLSH	(0*32+19) /* Supports the CLFLUSH instruction */
-#define X86_FEATURE_DTES	(0*32+21) /* Debug Trace Store */
+#define X86_FEATURE_DS		(0*32+21) /* Debug Store */
 #define X86_FEATURE_ACPI	(0*32+22) /* ACPI via MSR */
 #define X86_FEATURE_MMX		(0*32+23) /* Multimedia Extensions */
 #define X86_FEATURE_FXSR	(0*32+24) /* FXSAVE and FXRSTOR instructions (fast save and restore */
@@ -112,5 +112,6 @@ #define cpu_has_k6_mtrr        0
 #define cpu_has_cyrix_arr      0
 #define cpu_has_centaur_mcr    0
 #define cpu_has_clflush	       boot_cpu_has(X86_FEATURE_CLFLSH)
+#define cpu_has_ds 	       boot_cpu_has(X86_FEATURE_DS)
 
 #endif /* __ASM_X8664_CPUFEATURE_H */

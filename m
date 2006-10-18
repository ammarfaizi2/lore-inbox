Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWJRUve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWJRUve (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWJRUve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:51:34 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:53467 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1751496AbWJRUvd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:51:33 -0400
Date: Wed, 18 Oct 2006 13:51:20 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Stephane Eranian <eranian@hpl.hp.com>
Subject: Re: [PATCH] i386 add Intel Core related PMU MSRs
Message-ID: <20061018205120.GB20590@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20061018092723.GB19522@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018092723.GB19522@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Oct 18, 2006 at 02:27:23AM -0700, Stephane Eranian wrote:
> 
> The following patch adds to the i386 tree a bunch of MSRs related to performance
> monitoring for the processors based on Intel Core microarchitecture. It also adds
> some architectural MSRs for PEBS. A similar patch was posted for x86-64.
> 
> changelog:
>         - add Intel Precise-Event Based sampling (PEBS) related MSR
>         - add Intel Data Save (DS) Area related MSR
>         - add Intel Core microarchitecure performance counter MSRs
>
I realized there was a typo for one of the MSR (MSR_CORE_PERF_FIXED_CTR_CTRL).
Here is a resubmit of the same patch. The x86-64 also has the typo. Sorry about that.

changelog:
        - add Intel Precise-Event Based sampling (PEBS) related MSR
        - add Intel Data Save (DS) Area related MSR
        - add Intel Core microarchitecure performance counter MSRs

signed-off-by: stephane eranian <eranian@hpl.hp.com>


diff --git a/include/asm-i386/msr.h b/include/asm-i386/msr.h
index 62b76cd..1820d9d 100644
--- a/include/asm-i386/msr.h
+++ b/include/asm-i386/msr.h
@@ -141,6 +141,10 @@ #define MSR_IA32_MC0_STATUS		0x401
 #define MSR_IA32_MC0_ADDR		0x402
 #define MSR_IA32_MC0_MISC		0x403
 
+#define MSR_IA32_PEBS_ENABLE		0x3f1
+#define MSR_IA32_DS_AREA		0x600
+#define MSR_IA32_PERF_CAPABILITIES	0x345
+
 /* Pentium IV performance counter MSRs */
 #define MSR_P4_BPU_PERFCTR0 		0x300
 #define MSR_P4_BPU_PERFCTR1 		0x301
@@ -284,4 +288,13 @@ #define MSR_TMTA_LONGRUN_FLAGS		0x808680
 #define MSR_TMTA_LRTI_READOUT		0x80868018
 #define MSR_TMTA_LRTI_VOLT_MHZ		0x8086801a
 
+/* Intel Core-based CPU performance counters */
+#define MSR_CORE_PERF_FIXED_CTR0	0x309
+#define MSR_CORE_PERF_FIXED_CTR1	0x30a
+#define MSR_CORE_PERF_FIXED_CTR2	0x30b
+#define MSR_CORE_PERF_FIXED_CTR_CTRL	0x38d
+#define MSR_CORE_PERF_GLOBAL_STATUS	0x38e
+#define MSR_CORE_PERF_GLOBAL_CTRL	0x38f
+#define MSR_CORE_PERF_GLOBAL_OVF_CTRL	0x390
+
 #endif /* __ASM_MSR_H */

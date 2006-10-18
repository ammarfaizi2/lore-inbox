Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWJRJ0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWJRJ0J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 05:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWJRJ0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 05:26:09 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:37619 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1750967AbWJRJ0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 05:26:08 -0400
Date: Wed, 18 Oct 2006 02:25:36 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Stephane Eranian <eranian@hpl.hp.com>
Subject: [PATCH] x86-64 add Intel Core related PMU MSRs
Message-ID: <20061018092536.GA19522@frankl.hpl.hp.com>
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

The following patch adds to the x86-64 tree a bunch of MSRs related to performance
monitoring for the processors based on Intel Core microarchitecture. It also adds
some architectural MSRs for PEBS. A similar patch for i386 will follow.

changelog:
	- add Intel Precise-Event Based sampling (PEBS) related MSR
	- add Intel Data Save (DS) Area related MSR
	- add Intel Core microarchitecure performance counter MSRs

signed-off-by: stephane eranian <eranian@hpl.hp.com>

diff --git a/include/asm-x86_64/msr.h b/include/asm-x86_64/msr.h
index 37e1941..7bfa386 100644
--- a/include/asm-x86_64/msr.h
+++ b/include/asm-x86_64/msr.h
@@ -210,6 +210,10 @@ #define MSR_IA32_LASTBRANCHTOIP        0
 #define MSR_IA32_LASTINTFROMIP     0x1dd
 #define MSR_IA32_LASTINTTOIP       0x1de
 
+#define MSR_IA32_PEBS_ENABLE		0x3f1
+#define MSR_IA32_DS_AREA		0x600
+#define MSR_IA32_PERF_CAPABILITIES	0x345
+
 #define MSR_MTRRfix64K_00000	0x250
 #define MSR_MTRRfix16K_80000	0x258
 #define MSR_MTRRfix16K_A0000	0x259
@@ -407,4 +411,13 @@ #define MSR_P4_TC_ESCR1 		0x3c5
 #define MSR_P4_U2L_ESCR0 		0x3b0
 #define MSR_P4_U2L_ESCR1 		0x3b1
 
+/* Intel Core-based CPU performance counters */
+#define MSR_CORE_PERF_FIXED_CTR0	0x309
+#define MSR_CORE_PERF_FIXED_CTR1	0x30a
+#define MSR_CORE_PERF_FIXED_CTR2	0x30b
+#define MSR_CORE_PERF_FIXED_CTR_CTRL	0x30d
+#define MSR_CORE_PERF_GLOBAL_STATUS	0x38e
+#define MSR_CORE_PERF_GLOBAL_CTRL	0x38f
+#define MSR_CORE_PERF_GLOBAL_OVF_CTRL	0x390
+
 #endif

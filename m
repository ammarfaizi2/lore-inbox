Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316490AbSE3IjS>; Thu, 30 May 2002 04:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSE3IjS>; Thu, 30 May 2002 04:39:18 -0400
Received: from www.cdhutmusic.com ([196.28.7.66]:55718 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316490AbSE3IjR>; Thu, 30 May 2002 04:39:17 -0400
Date: Thu, 30 May 2002 10:12:01 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        CPU Freq ML <cpufreq@www.linux.org.uk>
Subject: [PATCH] Update 2.4 msr.h
Message-ID: <Pine.LNX.4.44.0205301005220.17117-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch just updates current 2.4 msr.h with what is currently in 2.5-dj 
(pending 2.5 merge). This is also required for easier merging of cpufreq

Cheers,
	Zwane

Diffed 2.4.19-pre8-ac5 against 2.5.18-dj1

--- linux-2.4-ac/include/asm-i386/msr.h	Thu May 30 09:57:00 2002
+++ linux-2.5-dj/include/asm-i386/msr.h	Thu May 30 09:50:18 2002
@@ -48,12 +48,36 @@
 #define MSR_IA32_UCODE_WRITE		0x79
 #define MSR_IA32_UCODE_REV		0x8b
 
+#define MSR_P6_PERFCTR0		0xc1
+#define MSR_P6_PERFCTR1		0xc2
+
 #define MSR_IA32_BBL_CR_CTL		0x119
 
 #define MSR_IA32_MCG_CAP		0x179
 #define MSR_IA32_MCG_STATUS		0x17a
 #define MSR_IA32_MCG_CTL		0x17b
 
+/* P4/Xeon+ specific */
+#define MSR_IA32_MCG_EAX		0x180
+#define MSR_IA32_MCG_EBX		0x181
+#define MSR_IA32_MCG_ECX		0x182
+#define MSR_IA32_MCG_EDX		0x183
+#define MSR_IA32_MCG_ESI		0x184
+#define MSR_IA32_MCG_EDI		0x185
+#define MSR_IA32_MCG_EBP		0x186
+#define MSR_IA32_MCG_ESP		0x187
+#define MSR_IA32_MCG_EFLAGS		0x188
+#define MSR_IA32_MCG_EIP		0x189
+#define MSR_IA32_MCG_RESERVED		0x18A
+
+#define MSR_P6_EVNTSEL0			0x186
+#define MSR_P6_EVNTSEL1			0x187
+
+#define MSR_IA32_THERM_CONTROL		0x19a
+#define MSR_IA32_THERM_INTERRUPT	0x19b
+#define MSR_IA32_THERM_STATUS		0x19c
+#define MSR_IA32_MISC_ENABLE		0x1a0
+
 #define MSR_IA32_DEBUGCTLMSR		0x1d9
 #define MSR_IA32_LASTBRANCHFROMIP	0x1db
 #define MSR_IA32_LASTBRANCHTOIP		0x1dc
@@ -64,11 +88,6 @@
 #define MSR_IA32_MC0_STATUS		0x401
 #define MSR_IA32_MC0_ADDR		0x402
 #define MSR_IA32_MC0_MISC		0x403
-
-#define MSR_P6_PERFCTR0			0xc1
-#define MSR_P6_PERFCTR1			0xc2
-#define MSR_P6_EVNTSEL0			0x186
-#define MSR_P6_EVNTSEL1			0x187
 
 /* AMD Defined MSRs */
 #define MSR_K6_EFER			0xC0000080

-- 
http://function.linuxpower.ca
		




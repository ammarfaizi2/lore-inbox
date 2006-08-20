Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWHTVzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWHTVzw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 17:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWHTVzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 17:55:52 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:29183 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1751434AbWHTVzv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 17:55:51 -0400
Date: Sun, 20 Aug 2006 14:45:53 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@hpl.hp.com>
Subject: [PATCH] i386 add missing PMU MSR definitions
Message-ID: <20060820214553.GC27542@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Here is a patch to add a couple of missing MSR definitions related
to Performance monitoring (on P4/Xeon). A separate patch is to follow
for the X86-64 equivalent.

Changelog:
	- add MSR definitions for IA32_PEBS_ENABLE and PEBS_MATRIX_VERT

signed-off-by: stephane eranian <eranian@hpl.hp.com>

-- 
-Stephane

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="msr-i386.diff"

--- linux-2.6.17.8.orig/include/asm-i386/msr.h	2006-08-06 21:18:54.000000000 -0700
+++ linux-2.6.17.8/include/asm-i386/msr.h	2006-08-20 14:38:35.000000000 -0700
@@ -225,6 +225,9 @@ static inline void wrmsrl (unsigned long
 #define MSR_P4_U2L_ESCR0 		0x3b0
 #define MSR_P4_U2L_ESCR1 		0x3b1
 
+#define MSR_IA32_PEBS_ENABLE		0x3f1
+#define MSR_PEBS_MATRIX_VERT		0x3f2
+
 /* AMD Defined MSRs */
 #define MSR_K6_EFER			0xC0000080
 #define MSR_K6_STAR			0xC0000081

--/9DWx/yDrRhgMJTb--

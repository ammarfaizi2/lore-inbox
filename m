Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWCCLHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWCCLHX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 06:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWCCLHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 06:07:23 -0500
Received: from mx1.sonologic.nl ([82.94.245.21]:48849 "EHLO mx1.sonologic.nl")
	by vger.kernel.org with ESMTP id S1751284AbWCCLHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 06:07:22 -0500
Message-ID: <44082320.3030804@metro.cx>
Date: Fri, 03 Mar 2006 12:06:08 +0100
From: Koen Martens <linuxarm@metro.cx>
Organization: Sonologic
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk, ben@simtec.co.uk,
       linux-kernel@vger.kernel.org
Subject: [patch 10/14] s3c2412/s3c2413 support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Helo-Milter-Authen: gmc@sonologic.nl, linuxarm@metro.cx, mx1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added TICNT0/TICNT1 for s3c2412.

Signed-off-by: Koen Martens <gmc@sonologic.nl>


--- linux-2.6.15.4/include/asm-arm/arch-s3c2410/regs-rtc.h    2006-02-10 
08:22:48.000000000 +0100
+++ golinux/include/asm-arm/arch-s3c2410/regs-rtc.h    2006-03-03 
11:18:40.000000000 +0100
@@ -13,6 +13,7 @@
  *    19-06-2003     BJD     Created file
  *    12-03-2004     BJD     Updated include protection
  *    15-01-2005     LCVR    Changed S3C2410_VA to S3C24XX_VA (s3c2400 
support)
+ *    17-02-2006     KM      Added S3C2412 / S3C2413 registers
 */
 
 #ifndef __ASM_ARCH_REGS_RTC_H
@@ -62,5 +63,18 @@
 #define S3C2410_RTCMON          S3C2410_RTCREG(0x84)
 #define S3C2410_RTCYEAR          S3C2410_RTCREG(0x88)
 
+#ifdef CONFIG_CPU_S3C2412
+
+#define S3C2412_RTCCON_TICSEL (1<<4)
+
+#define S3C2412_TICNT0        S3C2410_RTCREG(0x44)
+#define S3C2412_TICNT0_ENABLE (1<<7)
+
+#define S3C2412_TICNT1        S3C2410_RTCREG(0x4C)
+#define S3C2412_TICNT1_ENABLE (1<<7)
+
+#define S3C2412_RTCALM_XTBSEL (1<<7)
+
+#endif /* CONFIG_CPU_S3C2412 */
 
 #endif /* __ASM_ARCH_REGS_RTC_H */

-- 
K.F.J. Martens, Sonologic, http://www.sonologic.nl/
Networking, hosting, embedded systems, unix, artificial intelligence.
Public PGP key: http://www.metro.cx/pubkey-gmc.asc
Wondering about the funny attachment your mail program
can't read? Visit http://www.openpgp.org/


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWCCLGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWCCLGA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 06:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWCCLGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 06:06:00 -0500
Received: from mx1.sonologic.nl ([82.94.245.21]:17091 "EHLO mx1.sonologic.nl")
	by vger.kernel.org with ESMTP id S1751363AbWCCLF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 06:05:59 -0500
Message-ID: <44082301.10208@metro.cx>
Date: Fri, 03 Mar 2006 12:05:37 +0100
From: Koen Martens <linuxarm@metro.cx>
Organization: Sonologic
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk, ben@simtec.co.uk,
       linux-kernel@vger.kernel.org
Subject: [patch 9/14] s3c2412/s3c2413 support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Helo-Milter-Authen: gmc@sonologic.nl, linuxarm@metro.cx, mx1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added s3c2412 register addresses for registers that
moved relative to s3c2410.

Signed-off-by: Koen Martens <gmc@sonologic.nl>


--- linux-2.6.15.4/include/asm-arm/arch-s3c2410/regs-irq.h    2006-02-10 
08:22:48.000000000 +0100
+++ golinux/include/asm-arm/arch-s3c2410/regs-irq.h    2006-02-28 
13:13:11.000000000 +0100
@@ -13,6 +13,7 @@
  *    19-06-2003     BJD     Created file
  *    12-03-2004     BJD     Updated include protection
  *    10-03-2005     LCVR    Changed S3C2410_VA to S3C24XX_VA
+ *    17-02-2006     KM      Added S3C2412/S3C2413 defines
  */
 
 
@@ -41,4 +42,11 @@
 #define S3C2410_EINTMASK       S3C2410_EINTREG(0x0A4)
 #define S3C2410_EINTPEND       S3C2410_EINTREG(0X0A8)
 
+#ifdef CONFIG_CPU_S3C2412
+
+#define S3C2412_EINTMASK       S3C2410_EINTREG(0x0B4)
+#define S3C2412_EINTPEND       S3C2410_EINTREG(0X0B8)
+
+#endif /* CONFIG_CPU_S3C2412 */
+
 #endif /* ___ASM_ARCH_REGS_IRQ_H */

-- 
K.F.J. Martens, Sonologic, http://www.sonologic.nl/
Networking, hosting, embedded systems, unix, artificial intelligence.
Public PGP key: http://www.metro.cx/pubkey-gmc.asc
Wondering about the funny attachment your mail program
can't read? Visit http://www.openpgp.org/


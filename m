Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWCCLEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWCCLEl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 06:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWCCLEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 06:04:41 -0500
Received: from mx1.sonologic.nl ([82.94.245.21]:8421 "EHLO mx1.sonologic.nl")
	by vger.kernel.org with ESMTP id S1751339AbWCCLEk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 06:04:40 -0500
Message-ID: <440822AF.6080901@metro.cx>
Date: Fri, 03 Mar 2006 12:04:15 +0100
From: Koen Martens <linuxarm@metro.cx>
Organization: Sonologic
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk, ben@simtec.co.uk,
       linux-kernel@vger.kernel.org
Subject: [patch 7/14] s3c2412/s3c2413 support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Helo-Milter-Authen: gmc@sonologic.nl, linuxarm@metro.cx, mx1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added s3c2412 registers and bits.

Signed-off-by: Koen Martens <gmc@sonologic.nl>


--- linux-2.6.15.4/include/asm-arm/arch-s3c2410/regs-gpio.h    
2006-02-10 08:22:48.000000000 +0100
+++ golinux/include/asm-arm/arch-s3c2410/regs-gpio.h    2006-03-03 
11:10:08.000000000 +0100
@@ -22,6 +22,7 @@
  *    28-Mar-2005    LCVR    Fixed definition of GPB10
  *    26-Oct-2005    BJD     Added generic configuration types
  *    27-Nov-2005    LCVR    Added definitions to S3C2400 registers
+ *    27-Feb-2006    KM      Added definitions to S3C2412 registers
 */
 
 
@@ -1048,5 +1049,45 @@
 #define S3C2400_OPENCR_OPC_MOSIDIS  (0<<5)
 #define S3C2400_OPENCR_OPC_MOSIEN   (1<<5)
 
+/* register addresses that moved in s3c2412 relative to s3c2410 */
+/* and bits that were added/changed */
+
+#ifdef CONFIG_CPU_S3C2412
+
+#define S3C2410_GPBSLPCON  S3C2410_GPIOREG(0x1c)
+#define S3C2410_GPCSLPCON  S3C2410_GPIOREG(0x2c)
+#define S3C2410_GPDSLPCON  S3C2410_GPIOREG(0x3c)
+#define S3C2410_GPESLPCON  S3C2410_GPIOREG(0x4c)
+#define S3C2410_GPHSLPCON  S3C2410_GPIOREG(0x7c)
+#define S3C2412_MISCCR     S3C2410_GPIOREG(0x90)
+#define S3C2412_DCLKCON    S3C2410_GPIOREG(0x94)
+
+#define S3C2412_MISCCR_SPUCR_HEN    (0)
+#define S3C2412_MISCCR_SPUCR_HDIS   (1<<1)
+#define S3C2412_MISCCR_SPUCR_LEN    (0)
+#define S3C2412_MISCCR_SPUCR_LDIS   (1<<0)
+       
+#define S3C2412_MISCCR_SPUCR2_EN    (0<<2)
+#define S3C2412_MISCCR_SPUCR2_DIS   (1<<2)
+
+#define S3C2412_EXTINT0    S3C2410_GPIOREG(0x98)
+#define S3C2412_EXTINT1    S3C2410_GPIOREG(0x9C)
+#define S3C2412_EXTINT2    S3C2410_GPIOREG(0xA0)
+
+#define S3C2412_EINFLT0    S3C2410_GPIOREG(0xA4)
+#define S3C2412_EINFLT1    S3C2410_GPIOREG(0xA8)
+#define S3C2412_EINFLT2    S3C2410_GPIOREG(0xAc)
+#define S3C2412_EINFLT3    S3C2410_GPIOREG(0xB0)
+
+#define S3C2412_GSTATUS0   S3C2410_GPIOREG(0x0BC)
+#define S3C2412_GSTATUS1   S3C2410_GPIOREG(0x0C0)
+#define S3C2412_GSTATUS2   S3C2410_GPIOREG(0x0C4)
+#define S3C2412_GSTATUS3   S3C2410_GPIOREG(0x0C8)
+#define S3C2412_GSTATUS4   S3C2410_GPIOREG(0x0CC)
+#define S3C2412_GSTATUS5   S3C2410_GPIOREG(0x0D0)
+
+#endif    // CONFIG_CPU_S3C2412
+
+
 #endif    /* __ASM_ARCH_REGS_GPIO_H */
 

-- 
K.F.J. Martens, Sonologic, http://www.sonologic.nl/
Networking, hosting, embedded systems, unix, artificial intelligence.
Public PGP key: http://www.metro.cx/pubkey-gmc.asc
Wondering about the funny attachment your mail program
can't read? Visit http://www.openpgp.org/


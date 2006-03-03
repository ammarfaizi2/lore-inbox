Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWCCLD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWCCLD6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 06:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWCCLD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 06:03:58 -0500
Received: from mx1.sonologic.nl ([82.94.245.21]:39130 "EHLO mx1.sonologic.nl")
	by vger.kernel.org with ESMTP id S1751300AbWCCLD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 06:03:57 -0500
Message-ID: <44082280.7080807@metro.cx>
Date: Fri, 03 Mar 2006 12:03:28 +0100
From: Koen Martens <linuxarm@metro.cx>
Organization: Sonologic
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk, ben@simtec.co.uk,
       linux-kernel@vger.kernel.org
Subject: [patch 6/14] s3c2412/s3c2413 support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Helo-Milter-Authen: gmc@sonologic.nl, linuxarm@metro.cx, mx1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added s3c2412 sdc registers and bits.

Signed-off-by: Koen Martens <gmc@sonologic.nl>


--- linux-2.6.15.4/include/asm-arm/arch-s3c2410/regs-dsc.h    2006-02-10 
08:22:48.000000000 +0100
+++ golinux/include/asm-arm/arch-s3c2410/regs-dsc.h    2006-02-27 
16:34:02.000000000 +0100
@@ -12,6 +12,7 @@
  *  Changelog:
  *    11-Aug-2004     BJD     Created file
  *    25-Aug-2004     BJD     Added the _SELECT_* defs for using with 
functions
+ *    27-Feb-2006     KM      Added changes for S3C2412 / S3C2413
 */
 
 
@@ -179,5 +181,174 @@
 
 #endif /* CONFIG_CPU_S3C2440 */
 
+#ifdef CONFIG_CPU_S3C2412
+
+#define S3C2412_DSC0       S3C2410_GPIOREG(0xdc)
+#define S3C2412_DSC1       S3C2410_GPIOREG(0xe0)
+
+#define S3C2412_SELECT_DSC0 (0)
+#define S3C2412_SELECT_DSC1 (1<<31)
+
+#define S3C2412_DSC_GETSHIFT(x) ((x) & 31)
+
+#define S3C2412_DSC0_DISABLE    (1<<31)
+
+/* D0..D7 */
+#define S3C2412_DSC0_DATA0      (S3C2412_SELECT_DSC0 | 0)
+#define S3C2412_DSC0_DATA0_10mA (0<<0)
+#define S3C2412_DSC0_DATA0_6mA  (1<<0)
+#define S3C2412_DSC0_DATA0_8mA  (2<<0)
+#define S3C2412_DSC0_DATA0_4mA  (3<<0)
+#define S3C2412_DSC0_DATA0_MASK (3<<0)
+
+/* D8..D15 */
+#define S3C2412_DSC0_DATA1      (S3C2412_SELECT_DSC0 | 2)
+#define S3C2412_DSC0_DATA1_10mA (0<<2)
+#define S3C2412_DSC0_DATA1_6mA  (1<<2)
+#define S3C2412_DSC0_DATA1_8mA  (2<<2)
+#define S3C2412_DSC0_DATA1_4mA  (3<<2)
+#define S3C2412_DSC0_DATA1_MASK (3<<2)
+
+/* D16..D23 */
+#define S3C2412_DSC0_DATA2      (S3C2412_SELECT_DSC0 | 4)
+#define S3C2412_DSC0_DATA2_10mA (0<<4)
+#define S3C2412_DSC0_DATA2_6mA  (1<<4)
+#define S3C2412_DSC0_DATA2_8mA  (2<<4)
+#define S3C2412_DSC0_DATA2_4mA  (3<<4)
+#define S3C2412_DSC0_DATA2_MASK (3<<4)
+
+/* D24..D31 */
+#define S3C2412_DSC0_DATA3      (S3C2412_SELECT_DSC0 | 6)
+#define S3C2412_DSC0_DATA3_10mA (0<<6)
+#define S3C2412_DSC0_DATA3_6mA  (1<<6)
+#define S3C2412_DSC0_DATA3_8mA  (2<<6)
+#define S3C2412_DSC0_DATA3_4mA  (3<<6)
+#define S3C2412_DSC0_DATA3_MASK (3<<6)
+
+/* ADDRESS BUS */
+#define S3C2412_DSC0_ADDR      (S3C2412_SELECT_DSC0 | 8)
+#define S3C2412_DSC0_ADDR_10mA (0<<8)
+#define S3C2412_DSC0_ADDR_6mA  (1<<8)
+#define S3C2412_DSC0_ADDR_8mA  (2<<8)
+#define S3C2412_DSC0_ADDR_4mA  (3<<8)
+#define S3C2412_DSC0_ADDR_MASK (3<<8)
+
+/* nGCS0 */
+#define S3C2412_DSC0_CS0       (S3C2412_SELECT_DSC0 | 10)
+#define S3C2412_DSC0_CS0_10mA  (0<<10)
+#define S3C2412_DSC0_CS0_6mA   (1<<10)
+#define S3C2412_DSC0_CS0_8mA   (2<<10)
+#define S3C2412_DSC0_CS0_4mA   (3<<10)
+#define S3C2412_DSC0_CS0_MASK  (3<<10)
+
+/* nGCS1 */
+#define S3C2412_DSC0_CS1       (S3C2412_SELECT_DSC0 | 12)
+#define S3C2412_DSC0_CS1_10mA  (0<<12)
+#define S3C2412_DSC0_CS1_6mA   (1<<12)
+#define S3C2412_DSC0_CS1_8mA   (2<<12)
+#define S3C2412_DSC0_CS1_4mA   (3<<12)
+#define S3C2412_DSC0_CS1_MASK  (3<<12)
+
+/* nGCS2 */
+#define S3C2412_DSC0_CS2       (S3C2412_SELECT_DSC0 | 14)
+#define S3C2412_DSC0_CS2_10mA  (0<<14)
+#define S3C2412_DSC0_CS2_6mA   (1<<14)
+#define S3C2412_DSC0_CS2_8mA   (2<<14)
+#define S3C2412_DSC0_CS2_4mA   (3<<14)
+#define S3C2412_DSC0_CS2_MASK  (3<<14)
+
+/* nGCS3 */
+#define S3C2412_DSC0_CS3       (S3C2412_SELECT_DSC0 | 16)
+#define S3C2412_DSC0_CS3_10mA  (0<<16)
+#define S3C2412_DSC0_CS3_6mA   (1<<16)
+#define S3C2412_DSC0_CS3_8mA   (2<<16)
+#define S3C2412_DSC0_CS3_4mA   (3<<16)
+#define S3C2412_DSC0_CS3_MASK  (3<<16)
+
+/* nGCS4 */
+#define S3C2412_DSC0_CS4       (S3C2412_SELECT_DSC0 | 18)
+#define S3C2412_DSC0_CS4_10mA  (0<<18)
+#define S3C2412_DSC0_CS4_6mA   (1<<18)
+#define S3C2412_DSC0_CS4_8mA   (2<<18)
+#define S3C2412_DSC0_CS4_4mA   (3<<18)
+#define S3C2412_DSC0_CS4_MASK  (3<<18)
+
+/* nGCS5 */
+#define S3C2412_DSC0_CS5       (S3C2412_SELECT_DSC0 | 20)
+#define S3C2412_DSC0_CS5_10mA  (0<<20)
+#define S3C2412_DSC0_CS5_6mA   (1<<20)
+#define S3C2412_DSC0_CS5_8mA   (2<<20)
+#define S3C2412_DSC0_CS5_4mA   (3<<20)
+#define S3C2412_DSC0_CS5_MASK  (3<<20)
+
+/* nGCS6 */
+#define S3C2412_DSC0_CS6       (S3C2412_SELECT_DSC0 | 22)
+#define S3C2412_DSC0_CS6_10mA  (0<<22)
+#define S3C2412_DSC0_CS6_6mA   (1<<22)
+#define S3C2412_DSC0_CS6_8mA   (2<<22)
+#define S3C2412_DSC0_CS6_4mA   (3<<22)
+#define S3C2412_DSC0_CS6_MASK  (3<<22)
+
+/* nGCS7 */
+#define S3C2412_DSC0_CS7       (S3C2412_SELECT_DSC0 | 24)
+#define S3C2412_DSC0_CS7_10mA  (0<<24)
+#define S3C2412_DSC0_CS7_6mA   (1<<24)
+#define S3C2412_DSC0_CS7_8mA   (2<<24)
+#define S3C2412_DSC0_CS7_4mA   (3<<24)
+#define S3C2412_DSC0_CS7_MASK  (3<<24)
+
+
+
+/* SCLK */
+#define S3C2412_DSC0_SCK       (S3C2412_SELECT_DSC1 | 0)
+#define S3C2412_DSC0_SCK_10mA  (0<<0)
+#define S3C2412_DSC0_SCK_6mA   (1<<0)
+#define S3C2412_DSC0_SCK_8mA   (2<<0)
+#define S3C2412_DSC0_SCK_4mA   (3<<0)
+#define S3C2412_DSC0_SCK_MASK  (3<<0)
+
+/* SCKE */
+#define S3C2412_DSC0_SCKE      (S3C2412_SELECT_DSC1 | 6)
+#define S3C2412_DSC0_SCKE_10mA (0<<6)
+#define S3C2412_DSC0_SCKE_6mA  (1<<6)
+#define S3C2412_DSC0_SCKE_8mA  (2<<6)
+#define S3C2412_DSC0_SCKE_4mA  (3<<6)
+#define S3C2412_DSC0_SCKE_MASK (3<<6)
+
+/* SDR */
+#define S3C2412_DSC0_SDR       (S3C2412_SELECT_DSC1 | 8)
+#define S3C2412_DSC0_SDR_10mA  (0<<8)
+#define S3C2412_DSC0_SDR_6mA   (1<<8)
+#define S3C2412_DSC0_SDR_8mA   (2<<8)
+#define S3C2412_DSC0_SDR_4mA   (3<<8)
+#define S3C2412_DSC0_SDR_MASK  (3<<8)
+
+/* Nand Flash */
+#define S3C2412_DSC0_NFC       (S3C2412_SELECT_DSC1 | 10)
+#define S3C2412_DSC0_NFC_10mA  (0<<10)
+#define S3C2412_DSC0_NFC_6mA   (1<<10)
+#define S3C2412_DSC0_NFC_8mA   (2<<10)
+#define S3C2412_DSC0_NFC_4mA   (3<<10)
+#define S3C2412_DSC0_NFC_MASK  (3<<10)
+
+/* nBE */
+#define S3C2412_DSC0_BE        (S3C2412_SELECT_DSC1 | 12)
+#define S3C2412_DSC0_BE_10mA   (0<<12)
+#define S3C2412_DSC0_BE_6mA    (1<<12)
+#define S3C2412_DSC0_BE_8mA    (2<<12)
+#define S3C2412_DSC0_BE_4mA    (3<<12)
+#define S3C2412_DSC0_BE_MASK   (3<<12)
+
+/* nWE/nOE */
+#define S3C2412_DSC0_WOE       (S3C2412_SELECT_DSC1 | 14)
+#define S3C2412_DSC0_WOE_10mA  (0<<14)
+#define S3C2412_DSC0_WOE_6mA   (1<<14)
+#define S3C2412_DSC0_WOE_8mA   (2<<14)
+#define S3C2412_DSC0_WOE_4mA   (3<<14)
+#define S3C2412_DSC0_WOE_MASK  (3<<14)
+
+#endif /* CONFIG_CPU_S3C2412 */
+
+
 #endif    /* __ASM_ARCH_REGS_DSC_H */
 

-- 
K.F.J. Martens, Sonologic, http://www.sonologic.nl/
Networking, hosting, embedded systems, unix, artificial intelligence.
Public PGP key: http://www.metro.cx/pubkey-gmc.asc
Wondering about the funny attachment your mail program
can't read? Visit http://www.openpgp.org/


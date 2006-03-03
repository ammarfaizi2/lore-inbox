Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWCCK7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWCCK7q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 05:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWCCK7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 05:59:46 -0500
Received: from mx1.sonologic.nl ([82.94.245.21]:54485 "EHLO mx1.sonologic.nl")
	by vger.kernel.org with ESMTP id S1751236AbWCCK7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 05:59:45 -0500
Message-ID: <4408218E.2070605@metro.cx>
Date: Fri, 03 Mar 2006 11:59:26 +0100
From: Koen Martens <linuxarm@metro.cx>
Organization: Sonologic
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk, ben@simtec.co.uk,
       linux-kernel@vger.kernel.org
Subject: [patch 2/14] s3c2412/s3c2413 support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Helo-Milter-Authen: gmc@sonologic.nl, linuxarm@metro.cx, mx1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added function to modify MISCCR register on s3c2412 cpu.

Signed-off-by: Koen Martens <gmc@sonologic.nl>


--- linux-2.6.15.4/include/asm-arm/arch-s3c2410/hardware.h    2006-02-10 
08:22:48.000000000 +0100
+++ golinux/include/asm-arm/arch-s3c2410/hardware.h    2006-02-28 
12:51:47.000000000 +0100
@@ -86,18 +86,17 @@
 
 extern void s3c2410_gpio_pullup(unsigned int pin, unsigned int to);
 
 extern void s3c2410_gpio_setpin(unsigned int pin, unsigned int to);
 
 extern unsigned int s3c2410_gpio_getpin(unsigned int pin);
 
 extern unsigned int s3c2410_modify_misccr(unsigned int clr, unsigned 
int chg);
 
+#ifdef CONFIG_CPU_S3C2412
+extern unsigned int s3c2412_modify_misccr(unsigned int clr, unsigned 
int chg);
+#endif
 
 #endif /* __ASSEMBLY__ */
 

-- 
K.F.J. Martens, Sonologic, http://www.sonologic.nl/
Networking, hosting, embedded systems, unix, artificial intelligence.
Public PGP key: http://www.metro.cx/pubkey-gmc.asc
Wondering about the funny attachment your mail program
can't read? Visit http://www.openpgp.org/



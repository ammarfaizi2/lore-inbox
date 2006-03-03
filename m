Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWCCLKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWCCLKp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 06:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWCCLKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 06:10:44 -0500
Received: from mx1.sonologic.nl ([82.94.245.21]:40899 "EHLO mx1.sonologic.nl")
	by vger.kernel.org with ESMTP id S1751389AbWCCLKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 06:10:39 -0500
Message-ID: <44082389.60501@metro.cx>
Date: Fri, 03 Mar 2006 12:07:53 +0100
From: Koen Martens <linuxarm@metro.cx>
Organization: Sonologic
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk, ben@simtec.co.uk,
       linux-kernel@vger.kernel.org
Subject: [patch 13/14] s3c2412/s3c2413 support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Helo-Milter-Authen: gmc@sonologic.nl, linuxarm@metro.cx, mx1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Start of s3c2412 support.

Signed-off-by: Koen Martens <gmc@sonologic.nl>


--- linux-2.6.15.4/arch/arm/mach-s3c2410/s3c2412.h    1970-01-01 
01:00:00.000000000 +0100
+++ golinux/arch/arm/mach-s3c2410/s3c2412.h    2006-02-27 
17:02:10.000000000 +0100
@@ -0,0 +1,36 @@
+/* arch/arm/mach-s3c2410/s3c2440.h
+ *
+ * Copyright (c) 2004-2005 Simtec Electronics
+ *    Ben Dooks <ben@simtec.co.uk>
+ *
+ * Header file for s3c2412 cpu support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Modifications:
+ *    24-Aug-2004 BJD  Start of S3C2440 CPU support
+ *    04-Nov-2004 BJD  Added s3c2440_init_uarts()
+ *    04-Jan-2005 BJD  Moved uart init to cpu code
+ *    10-Jan-2005 BJD  Moved 2440 specific init here
+ *    14-Jan-2005 BJD  Split the clock initialisation code
+ *      27-Feb-2006 KM   Start of S3C2412 CPU support
+*/
+
+#ifdef CONFIG_CPU_S3C2412
+
+extern  int s3c2412_init(void);
+
+extern void s3c2412_map_io(struct map_desc *mach_desc, int size);
+
+extern void s3c2412_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+
+extern void s3c2412_init_clocks(int xtal);
+
+#else
+#define s3c2412_init_clocks NULL
+#define s3c2412_init_uarts NULL
+#define s3c2412_map_io NULL
+#define s3c2412_init NULL
+#endif

-- 
K.F.J. Martens, Sonologic, http://www.sonologic.nl/
Networking, hosting, embedded systems, unix, artificial intelligence.
Public PGP key: http://www.metro.cx/pubkey-gmc.asc
Wondering about the funny attachment your mail program
can't read? Visit http://www.openpgp.org/


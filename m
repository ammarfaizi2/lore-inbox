Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbTABNiu>; Thu, 2 Jan 2003 08:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbTABNit>; Thu, 2 Jan 2003 08:38:49 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:19985 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S261872AbTABNit>; Thu, 2 Jan 2003 08:38:49 -0500
Subject: [PATCH] [TRIVIAL] [AGPGART]:  early agp init fix
From: Antonino Daplas <adaplas@pol.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1041514432.1003.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Jan 2003 21:34:04 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



intel_agp_init() must not be declared static for explicit early
initialization to work (ie i810fb).

Tony

diff -Naur linux-2.5.54/drivers/char/agp/intel-agp.c linux/drivers/char/agp/intel-agp.c
--- linux-2.5.54/drivers/char/agp/intel-agp.c	2003-01-02 13:16:06.000000000 +0000
+++ linux/drivers/char/agp/intel-agp.c	2003-01-02 13:15:31.000000000 +0000
@@ -1467,7 +1467,7 @@
 	.probe		= agp_intel_probe,
 };
 
-static int __init agp_intel_init(void)
+int __init agp_intel_init(void)
 {
 	int ret_val;
 	static int agp_initialised=0;


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129036AbRBIAWY>; Thu, 8 Feb 2001 19:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129668AbRBIAWP>; Thu, 8 Feb 2001 19:22:15 -0500
Received: from Mail.ubishops.ca ([192.197.190.5]:65292 "EHLO Mail.ubishops.ca")
	by vger.kernel.org with ESMTP id <S129633AbRBIAV4>;
	Thu, 8 Feb 2001 19:21:56 -0500
Message-ID: <3A833817.E4455DC0@yahoo.co.uk>
Date: Thu, 08 Feb 2001 19:21:43 -0500
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] xirc2ps_cs.c  SET_MODULE_OWNER(dev)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I presume that this change needs to be made.
(All of the drivers/net/pcmcia/*.c need the change.)
 // Thomas

jdthood@thanatos:/usr/src/kernel-source-2.4.1-ac3/drivers/net/pcmcia# diff -Naur xirc2ps_cs.c_ORIG xirc2ps_cs.c
--- xirc2ps_cs.c_ORIG	Thu Feb  8 19:11:54 2001
+++ xirc2ps_cs.c	Thu Feb  8 19:12:01 2001
@@ -637,6 +637,7 @@
     link->irq.Instance = dev;
 
     /* Fill in card specific entries */
+    SET_MODULE_OWNER(dev);
     dev->hard_start_xmit = &do_start_xmit;
     dev->set_config = &do_config;
     dev->get_stats = &do_get_stats;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

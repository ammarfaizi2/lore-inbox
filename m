Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263115AbTIVLj2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 07:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263116AbTIVLj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 07:39:28 -0400
Received: from [203.145.184.221] ([203.145.184.221]:26122 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263115AbTIVLj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 07:39:27 -0400
From: Shine Mohamed <shinemohamed_j@naturesoft.net>
Organization: Naturesoft
To: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [TRIVIAL][PATCH] Removed deprecated functions/macros from lanai.c
Date: Mon, 22 Sep 2003 17:10:23 +0530
User-Agent: KMail/1.5
Cc: krishnakumar@naturesoft.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309221710.23656.shinemohamed_j@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch to remove deprecated inline function MOD_INC_USE_COUNT and 
MOD_INC_DEC_COUNT.

diff -urN linux-2.6.0-test5.orig/drivers/atm/lanai.c 
linux-2.6.0-test5/drivers/atm/lanai.c
--- linux-2.6.0-test5.orig/drivers/atm/lanai.c  2003-09-09 01:19:58.000000000 
+0530
+++ linux-2.6.0-test5/drivers/atm/lanai.c       2003-09-22 10:13:56.000000000 
+0530
@@ -2242,7 +2242,6 @@
                printk(KERN_ERR DEV_LABEL ": can't allocate interrupt\n");
                goto error_vcctable;
        }
-       MOD_INC_USE_COUNT;              /* At this point we can't fail */
        mb();                           /* Make sure that all that made it */
        intr_enable(lanai, INT_ALL & ~(INT_PING | INT_WAKE));
        /* 3.11: initialize loop mode (i.e. turn looping off) */
@@ -2312,7 +2311,6 @@
        service_buffer_deallocate(lanai);
        iounmap((void *) lanai->base);
        kfree(lanai);
-       MOD_DEC_USE_COUNT;
 }

 /* close a vcc */


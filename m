Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbUKQEl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbUKQEl6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 23:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbUKQEkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 23:40:52 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6412 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262213AbUKQEfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 23:35:37 -0500
Date: Wed, 17 Nov 2004 05:32:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: async@cyclades.com, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [2.6 patch] char/cyclades.c: remove unused code (fwd)
Message-ID: <20041117043238.GJ4943@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below (already ACK'ed by Marcelo Tosatti) still applies and 
compiles against 2.6.10-rc2-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sun, 31 Oct 2004 22:34:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: async@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] char/cyclades.c: remove unused code

The patch below removes unused code from drivers/char/cyclades.c


diffstat output:
 drivers/char/cyclades.c |   21 ---------------------
 1 files changed, 21 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/drivers/char/cyclades.c.old	2004-10-31 19:49:35.000000000 +0100
+++ linux-2.6.10-rc1-mm2-full/drivers/char/cyclades.c	2004-10-31 19:52:36.000000000 +0100
@@ -758,7 +758,6 @@
  * allocated when the first cy_open occurs.
  */
 static unsigned char *tmp_buf;
-DECLARE_MUTEX(tmp_buf_sem);
 
 /*
  * This is used to look up the divisor speeds and the timeouts
@@ -5538,24 +5537,4 @@
 module_init(cy_init);
 module_exit(cy_cleanup_module);
 
-#ifndef MODULE
-/* called by linux/init/main.c to parse command line options */
-void
-cy_setup(char *str, int *ints)
-{
-#ifdef CONFIG_ISA
-  int i, j;
-
-    for (i = 0 ; i < NR_ISA_ADDRS ; i++) {
-        if (cy_isa_addresses[i] == 0) break;
-    }
-    for (j = 1; j <= ints[0]; j++){
-        if ( i < NR_ISA_ADDRS ){
-            cy_isa_addresses[i++] = ints[j];
-        }
-    }
-#endif /* CONFIG_ISA */
-} /* cy_setup */
-#endif /* MODULE */
-
 MODULE_LICENSE("GPL");
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----


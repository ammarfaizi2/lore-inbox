Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbUJaVhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbUJaVhF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 16:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbUJaVhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 16:37:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63250 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261469AbUJaVfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 16:35:00 -0500
Date: Sun, 31 Oct 2004 22:34:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: async@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] char/cyclades.c: remove unused code
Message-ID: <20041031213428.GF2495@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

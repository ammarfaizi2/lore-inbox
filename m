Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267311AbTAKRhL>; Sat, 11 Jan 2003 12:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267312AbTAKRhL>; Sat, 11 Jan 2003 12:37:11 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42964 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267311AbTAKRhK>; Sat, 11 Jan 2003 12:37:10 -0500
Date: Sat, 11 Jan 2003 18:45:52 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: kai.germaschewski@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] remove kernel 2.0 code from drivers/isdn/divert/divert_init.c
Message-ID: <20030111174552.GR10486@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes #if'd kernel 2.0 code from 
drivers/isdn/divert/divert_init.c.

I've tested the compilation with 2.5.56.

cu
Adrian

--- linux-2.5.56/drivers/isdn/divert/divert_init.c.old	2003-01-11 18:42:43.000000000 +0100
+++ linux-2.5.56/drivers/isdn/divert/divert_init.c	2003-01-11 18:43:10.000000000 +0100
@@ -51,9 +51,6 @@
      printk(KERN_WARNING "dss1_divert: error %d registering module, not loaded\n",i);
      return(-EIO);
    } 
-#if (LINUX_VERSION_CODE < 0x020111)
-  register_symtab(0);
-#endif
   printk(KERN_INFO "dss1_divert module successfully installed\n");
   return(0);
 }

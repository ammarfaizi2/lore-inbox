Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316260AbSEZSfI>; Sun, 26 May 2002 14:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316257AbSEZSea>; Sun, 26 May 2002 14:34:30 -0400
Received: from [195.39.17.254] ([195.39.17.254]:63387 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316254AbSEZSdh>;
	Sun, 26 May 2002 14:33:37 -0400
Date: Sun, 26 May 2002 20:30:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: trivial: pcnet32 whitespace
Message-ID: <20020526183056.GA10669@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Kill extra whitespace, make gcc command look like it could work (used to be prehistoric).

--- clean/drivers/net/pcnet32.c	Thu Apr 18 22:45:38 2002
+++ linux-swsusp/drivers/net/pcnet32.c	Fri May  3 00:08:35 2002
@@ -453,8 +454,6 @@
     reset:	pcnet32_dwio_reset
 };
 
-
-
 /* only probes for non-PCI devices, the rest are handled by 
  * pci_register_driver via pcnet32_probe_pci */
 
@@ -583,12 +582,6 @@
 	 */
 	/* switch to home wiring mode */
 	media = a->read_bcr(ioaddr, 49);
-#if 0
-	if (pcnet32_debug > 2)
-	    printk(KERN_DEBUG PFX "media value %#x.\n",  media);
-	media &= ~3;
-	media |= 1;
-#endif
 	if (pcnet32_debug > 2)
 	    printk(KERN_DEBUG PFX "media reset to %#x.\n",  media);
 	a->write_bcr(ioaddr, 49, media);
@@ -1721,12 +1748,12 @@
     }
 }
 
 module_init(pcnet32_init_module);
 module_exit(pcnet32_cleanup_module);
 
 /*
  * Local variables:
- *  compile-command: "gcc -D__KERNEL__ -I/usr/src/linux/net/inet -Wall -Wstrict-prototypes -O6 -m486 -c pcnet32.c"
+ *  compile-command: "gcc -D__KERNEL__ -I/usr/src/linux/include/linux -Wall -Wstrict-prototypes -O2 -m486 -c pcnet32.c"
  *  c-indent-level: 4
  *  tab-width: 8
  * End:


-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa

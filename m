Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316756AbSFQFzb>; Mon, 17 Jun 2002 01:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSFQFza>; Mon, 17 Jun 2002 01:55:30 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:36861 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S316756AbSFQFz3>;
	Mon, 17 Jun 2002 01:55:29 -0400
Date: Mon, 17 Jun 2002 15:54:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: Trivial Kernel Patches <trivial@rustcorp.com.au>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.22 compile fixes
Message-Id: <20020617155451.1d2c4342.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I needed these to make 2.5.22 build for me.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.22-sfr.1/drivers/scsi/constants.c 2.5.22-sfr.2/drivers/scsi/constants.c
--- 2.5.22-sfr.1/drivers/scsi/constants.c	Mon Jun 17 14:09:53 2002
+++ 2.5.22-sfr.2/drivers/scsi/constants.c	Mon Jun 17 15:35:25 2002
@@ -993,10 +993,13 @@
 	}
     
 #if !(CONSTANTS & CONST_SENSE)
+	{
+		int i;
 	printk("Raw sense data:");
 	for (i = 0; i < s; ++i) 
 		printk("0x%02x ", sense_buffer[i]);
 	printk("\n");
+	}
 #endif
 }
 
diff -ruN 2.5.22-sfr.1/sound/pci/cs46xx/cs46xx.c 2.5.22-sfr.2/sound/pci/cs46xx/cs46xx.c
--- 2.5.22-sfr.1/sound/pci/cs46xx/cs46xx.c	Sun May 26 19:20:39 2002
+++ 2.5.22-sfr.2/sound/pci/cs46xx/cs46xx.c	Mon Jun 17 15:39:06 2002
@@ -28,6 +28,7 @@
 #include <sound/driver.h>
 #include <linux/pci.h>
 #include <linux/time.h>
+#include <linux/init.h>
 #include <sound/core.h>
 #include <sound/cs46xx.h>
 #define SNDRV_GET_ID

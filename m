Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263002AbTCSMUn>; Wed, 19 Mar 2003 07:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262997AbTCSMUk>; Wed, 19 Mar 2003 07:20:40 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:44424 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S263002AbTCSMSe>;
	Wed, 19 Mar 2003 07:18:34 -0500
Date: Wed, 19 Mar 2003 13:29:37 +0100 (MET)
Message-Id: <200303191229.h2JCTbY00985@vervain.sonytel.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Sun-3 NCR5380 SCSI printk tags
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun-3 NCR5380 SCSI: Re-add accidentally deleted KERN_DEBUG tags.

--- linux-2.5.x/drivers/scsi/sun3_NCR5380.c	Sat Oct 12 19:20:38 2002
+++ linux-m68k-2.5.x/drivers/scsi/sun3_NCR5380.c	Mon Oct  7 22:21:40 2002
@@ -613,11 +617,11 @@
 
     status = NCR5380_read(STATUS_REG);
     if (!(status & SR_REQ)) 
-	printk("scsi%d: REQ not asserted, phase unknown.\n", HOSTNO);
+	printk(KERN_DEBUG "scsi%d: REQ not asserted, phase unknown.\n", HOSTNO);
     else {
 	for (i = 0; (phases[i].value != PHASE_UNKNOWN) && 
 	    (phases[i].value != (status & PHASE_MASK)); ++i); 
-	printk("scsi%d: phase %s\n", HOSTNO, phases[i].name);
+	printk(KERN_DEBUG "scsi%d: phase %s\n", HOSTNO, phases[i].name);
     }
 }
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

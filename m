Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129682AbQKVNMm>; Wed, 22 Nov 2000 08:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131735AbQKVNMc>; Wed, 22 Nov 2000 08:12:32 -0500
Received: from mail.sonytel.be ([193.74.243.200]:28318 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S129682AbQKVNMU>;
	Wed, 22 Nov 2000 08:12:20 -0500
Date: Wed, 22 Nov 2000 13:41:59 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] exit_idescsi_module()
Message-ID: <Pine.GSO.4.10.10011221340270.18101-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


cleanup_module() was renamed to exit_idescsi_module() recently

--- linux-2.4.0-test11/drivers/scsi/ide-scsi.c	Mon Oct 30 23:44:29 2000
+++ linux-m68k-2.4.0-test11/drivers/scsi/ide-scsi.c	Wed Nov 22 09:15:52 2000
@@ -840,7 +840,7 @@
 		failed = 0;
 		while ((drive = ide_scan_devices (media[i], idescsi_driver.name, &idescsi_driver, failed)) != NULL)
 			if (idescsi_cleanup (drive)) {
-				printk ("%s: cleanup_module() called while still busy\n", drive->name);
+				printk ("%s: exit_idescsi_module() called while still busy\n", drive->name);
 				failed++;
 			}
 	}
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264738AbSJ3Qqg>; Wed, 30 Oct 2002 11:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbSJ3Qqg>; Wed, 30 Oct 2002 11:46:36 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:5629 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S264738AbSJ3Qqf>;
	Wed, 30 Oct 2002 11:46:35 -0500
Date: Wed, 30 Oct 2002 17:52:46 +0100 (MET)
Message-Id: <200210301652.g9UGqkA11693@vervain.sonytel.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] IDE: kill warning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IDE: kill warning

--- linux-2.5.x-bk-20021030/drivers/ide/ide-lib.c	Sat Sep 28 14:56:40 2002
+++ linux-m68k-2.5.x/drivers/ide/ide-lib.c	Thu Oct 10 21:42:30 2002
@@ -171,7 +171,7 @@
 		BUG();
 	return min(speed, speed_max[mode]);
 #else /* !CONFIG_BLK_DEV_IDEDMA */
-	return min(speed, XFER_PIO_4);
+	return min(speed, (u8)XFER_PIO_4);
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 }
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

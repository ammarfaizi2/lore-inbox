Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263794AbSKRRWg>; Mon, 18 Nov 2002 12:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbSKRRWg>; Mon, 18 Nov 2002 12:22:36 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:49793 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S263794AbSKRRWf>;
	Mon, 18 Nov 2002 12:22:35 -0500
Date: Mon, 18 Nov 2002 18:29:17 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Pavel Machek <pavel@suse.cz>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] swsusp duplicates
Message-ID: <Pine.GSO.4.21.0211181827190.11448-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some software suspend declarations from suspend.h are duplicated in reboot.h.
Especially the `extern void software_suspend(void)' conflicts with the static
dummy one when software suspend is disabled.

--- linux-2.5.48/include/linux/reboot.h	Sat May 25 14:28:53 2002
+++ linux-m68k-2.5.48/include/linux/reboot.h	Mon Nov 18 15:19:22 2002
@@ -48,13 +48,6 @@
 extern void machine_halt(void);
 extern void machine_power_off(void);
 
-/*
- * Architecture-independent suspend facility
- */
-
-extern void software_suspend(void);
-extern unsigned char software_suspend_enabled;
-
 #endif
 
 #endif /* _LINUX_REBOOT_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


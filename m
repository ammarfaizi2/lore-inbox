Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130007AbQKUNRh>; Tue, 21 Nov 2000 08:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130423AbQKUNR1>; Tue, 21 Nov 2000 08:17:27 -0500
Received: from mail.sonytel.be ([193.74.243.200]:50921 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S130007AbQKUNRQ>;
	Tue, 21 Nov 2000 08:17:16 -0500
Date: Tue, 21 Nov 2000 13:46:38 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] missing extern in vt_kern.h
Message-ID: <Pine.GSO.4.10.10011211345410.14139-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

include/linux/vt_kern.h lacks the keyword `extern' for a pointer declaration.

diff -urN linux-2.4.0-test11/include/linux/vt_kern.h geert-2.4.0-test11/include/linux/vt_kern.h
--- linux-2.4.0-test11/include/linux/vt_kern.h	Sun Nov 19 05:57:35 2000
+++ geert-2.4.0-test11/include/linux/vt_kern.h	Tue Nov 21 13:32:20 2000
@@ -30,7 +30,7 @@
 	wait_queue_head_t paste_wait;
 } *vt_cons[MAX_NR_CONSOLES];
 
-void (*kd_mksound)(unsigned int hz, unsigned int ticks);
+extern void (*kd_mksound)(unsigned int hz, unsigned int ticks);
 
 /* console.c */
 

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

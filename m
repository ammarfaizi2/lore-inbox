Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSIIL3G>; Mon, 9 Sep 2002 07:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSIIL3F>; Mon, 9 Sep 2002 07:29:05 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:15071 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S317101AbSIIL10>;
	Mon, 9 Sep 2002 07:27:26 -0400
Date: Mon, 9 Sep 2002 13:32:04 +0200 (MEST)
Message-Id: <200209091132.g89BW4R25876@vervain.sonytel.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] 16550 serial fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make rs_read_proc() static, since it's not used outside serial.c

--- linux-2.4.20-pre5/drivers/char/serial.c	Thu Aug 29 08:23:40 2002
+++ linux-m68k-2.4.20-pre5/drivers/char/serial.c	Tue Aug 13 09:16:43 2002
@@ -3326,8 +3326,8 @@
 	return ret;
 }
 
-int rs_read_proc(char *page, char **start, off_t off, int count,
-		 int *eof, void *data)
+static int rs_read_proc(char *page, char **start, off_t off, int count,
+			int *eof, void *data)
 {
 	int i, len = 0, l;
 	off_t	begin = 0;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316499AbSFUJOS>; Fri, 21 Jun 2002 05:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316500AbSFUJOR>; Fri, 21 Jun 2002 05:14:17 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:63184 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S316499AbSFUJOR>;
	Fri, 21 Jun 2002 05:14:17 -0400
Date: Fri, 21 Jun 2002 11:14:13 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] khttpd and make_times_h
Message-ID: <Pine.GSO.4.21.0206211048100.7190-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


khttpd doesn't build in 2.5.24 because the shell can't find make_times_h.

--- linux-2.5.24/net/khttpd/Makefile	Fri Jun 21 09:34:54 2002
+++ linux-m68k-2.5.24/net/khttpd/Makefile	Fri Jun 21 10:50:15 2002
@@ -19,4 +19,4 @@
 # Generated files
 
 $(obj)/times.h: $(obj)/make_times_h
-	$< >$@
+	$(obj)/make_times_h >$@


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


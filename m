Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130277AbRABK6q>; Tue, 2 Jan 2001 05:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130382AbRABK6g>; Tue, 2 Jan 2001 05:58:36 -0500
Received: from hood.tvd.be ([195.162.196.21]:28853 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S130277AbRABK6a>;
	Tue, 2 Jan 2001 05:58:30 -0500
Date: Tue, 2 Jan 2001 11:27:33 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        "H. Peter Anvin" <device@lanana.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Frame Buffer Device Development 
	<linux-fbdev@vuser.vu.union.edu>,
        A2232@gmx.net, Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] devices.txt bugs
Message-ID: <Pine.LNX.4.05.10101021122180.7140-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes two things:

  - Correct the minor numbers for the frame buffer devices.  We have room for
    32 frame buffers since about one year, with more room for future expansion
    to 256.  (promised to go in by HPA on Fri, 24 Mar 2000 01:47:05 -0800).

  - Fix a typo in the minors for the A2232 serial card

--- linux-2.4.0-current/Documentation/devices.txt.orig	Mon Jan  1 23:30:06 2001
+++ linux-2.4.0-current/Documentation/devices.txt	Tue Jan  2 11:16:42 2001
@@ -660,6 +660,12 @@
 
  29 char	Universal frame buffer
 		  0 = /dev/fb0		First frame buffer
+		  1 = /dev/fb1		Second frame buffer
+		    ...
+		 31 = /dev/fb31		32nd frame buffer
+
+		Backward compatibility aliases {2.6}
+
 		 32 = /dev/fb1		Second frame buffer
 		    ...
 		224 = /dev/fb7		Eighth frame buffer
@@ -2436,7 +2442,7 @@
 
 224 char	A2232 serial card
 		  0 = /dev/ttyY0		First A2232 port
-		  1 = /dev/cuy0			Second A2232 port
+		  1 = /dev/ttyY1		Second A2232 port
 		    ...
 
 225 char	A2232 serial card (alternate devices)

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

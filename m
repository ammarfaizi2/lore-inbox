Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130105AbRBJRe7>; Sat, 10 Feb 2001 12:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131607AbRBJRew>; Sat, 10 Feb 2001 12:34:52 -0500
Received: from pikachu.3ti.org ([212.204.216.221]:2564 "EHLO pikachu.3ti.org")
	by vger.kernel.org with ESMTP id <S130105AbRBJRee>;
	Sat, 10 Feb 2001 12:34:34 -0500
Date: Sat, 10 Feb 2001 18:34:29 +0100 (CET)
From: Dag Wieers <dag@mind.be>
X-X-Sender: <dag@pikachu.3ti.org>
To: <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Unresolved symbols for wavelan_cs in 2.4.1-ac9
Message-ID: <Pine.LNX.4.32.0102101819490.11777-100000@pikachu.3ti.org>
User-Agent: Mutt/1.2i
X-Mailer: Evolution 1.0 (Stable release)
Organization: Mind Linux Solutions in Leuven/Belgium - http://mind.be/
X-Extra: If you can read this and Linux is your thing. Work for us !
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I noticed a single unresolved symbol in wavelan_cs.o and I fixed it as
described below.

(For those in favor of .lost+found/, raise your hand ;))

--- drivers/net/pcmcia/wavelan_cs.c.orig        Sat Feb 10 18:19:13 2001
+++ drivers/net/pcmcia/wavelan_cs.c     Sat Feb 10 18:18:01 2001
@@ -4821,5 +4821,7 @@
 #endif
 }

+EXPORT_SYMBOL(__bad_udelay);
+
 module_init(init_wavelan_cs);
 module_exit(exit_wavelan_cs);

--  dag wieers, <dag@mind.be>, http://mind.be/  --
            Out of swap, out of luck.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

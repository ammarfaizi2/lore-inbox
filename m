Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132062AbQL1WMg>; Thu, 28 Dec 2000 17:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131955AbQL1WM0>; Thu, 28 Dec 2000 17:12:26 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:23546 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131950AbQL1WMJ>; Thu, 28 Dec 2000 17:12:09 -0500
Date: Thu, 28 Dec 2000 19:41:14 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] 8139too fix
Message-ID: <Pine.LNX.4.21.0012281939540.1403-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

with the fix below, newer versions of modutils won't
complain about the (missing) symbol debug...

Could you please apply this for the next pre-patch?

thanks,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/



--- ./drivers/net/8139too.c.wrong	Thu Dec 28 19:39:18 2000
+++ ./drivers/net/8139too.c	Thu Dec 28 19:39:26 2000
@@ -536,7 +536,6 @@
 MODULE_DESCRIPTION ("RealTek RTL-8139 Fast Ethernet driver");
 MODULE_PARM (multicast_filter_limit, "i");
 MODULE_PARM (max_interrupt_work, "i");
-MODULE_PARM (debug, "i");
 MODULE_PARM (media, "1-" __MODULE_STRING(8) "i");
 
 static int read_eeprom (void *ioaddr, int location, int addr_len);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273506AbRIUNDk>; Fri, 21 Sep 2001 09:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273507AbRIUNDa>; Fri, 21 Sep 2001 09:03:30 -0400
Received: from CPE-61-9-150-236.vic.bigpond.net.au ([61.9.150.236]:50675 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S273506AbRIUNDR>; Fri, 21 Sep 2001 09:03:17 -0400
Message-ID: <3BAB376C.18BD7664@eyal.emu.id.au>
Date: Fri, 21 Sep 2001 22:49:48 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch] Re: 2.4.10-pre13 still problems with tty_register_ldisc export
In-Reply-To: <20010921130945.2eed67d6.skraw@ithnet.com>
Content-Type: multipart/mixed;
 boundary="------------066B040B01B214DFC37B3501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------066B040B01B214DFC37B3501
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Stephan von Krawczynski wrote:
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.10-pre13/kernel/drivers/net/ppp_async.o
> depmod:         tty_register_ldisc
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.10-pre13/kernel/drivers/net/ppp_synctty.o
> depmod:         tty_register_ldisc

I think drivers/char/tty_io.c should export it.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
--------------066B040B01B214DFC37B3501
Content-Type: text/plain; charset=us-ascii;
 name="2.4.10-pre13.tty_io.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.10-pre13.tty_io.patch"

--- linux/drivers/char/tty_io.c.orig	Fri Sep 21 22:45:26 2001
+++ linux/drivers/char/tty_io.c	Fri Sep 21 22:45:30 2001
@@ -2057,6 +2057,7 @@
 
 EXPORT_SYMBOL(tty_register_devfs);
 EXPORT_SYMBOL(tty_unregister_devfs);
+EXPORT_SYMBOL(tty_register_ldisc);
 
 /*
  * Called by a tty driver to register itself.

--------------066B040B01B214DFC37B3501--


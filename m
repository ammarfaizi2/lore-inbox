Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266054AbTHBN2i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 09:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbTHBN2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 09:28:38 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:43393 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265922AbTHBN2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 09:28:33 -0400
Date: Sat, 2 Aug 2003 15:28:31 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-net@vger.kernel.org
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: net/ipv4/ipcomp.c in 2.6.0-test2
Message-ID: <Pine.GSO.4.21.0308021525420.543-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looks like CONFIG_INET_IPCOMP=y needs CONFIG_CRYPTO_HMAC=y

|   CC      net/ipv4/ipcomp.o
| In file included from net/ipv4/ipcomp.c:24:
| include/net/esp.h: In function `esp_hmac_digest':
| include/net/esp.h:48: warning: implicit declaration of function `crypto_hmac_init'
| include/net/esp.h:49: `crypto_hmac_update' undeclared (first use in this function)
| include/net/esp.h:49: (Each undeclared identifier is reported only once
| include/net/esp.h:49: for each function it appears in.)
| include/net/esp.h:50: warning: implicit declaration of function `crypto_hmac_final'
| make[2]: *** [net/ipv4/ipcomp.o] Error 1
| make[1]: *** [net/ipv4] Error 2
| make: *** [net] Error 2
| tux$ grep hmac .config
| # CONFIG_CRYPTO_HMAC is not set
| tux$ grep ipcomp .config
| CONFIG_INET_IPCOMP=y
| tux$ 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271125AbTHCLZV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 07:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271134AbTHCLZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 07:25:21 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:45033 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S270228AbTHCLZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 07:25:17 -0400
Date: Sun, 3 Aug 2003 13:17:03 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: linux-net@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: net/ipv4/ipcomp.c in 2.6.0-test2
In-Reply-To: <E19j8Ln-0002rE-00@gondolin.me.apana.org.au>
Message-ID: <Pine.GSO.4.21.0308031315370.799-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Aug 2003, Herbert Xu wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Looks like CONFIG_INET_IPCOMP=y needs CONFIG_CRYPTO_HMAC=y
> 
> Does it help if you remove the inclusion of net/esp.h from ipcomp.c?

Yes it does.

--- linux-2.6.0-test2/net/ipv4/ipcomp.c	Tue Jul 29 18:19:24 2003
+++ linux-m68k-2.6.0-test2/net/ipv4/ipcomp.c	Sun Aug  3 13:15:11 2003
@@ -21,7 +21,6 @@
 #include <net/ip.h>
 #include <net/xfrm.h>
 #include <net/icmp.h>
-#include <net/esp.h>
 #include <net/ipcomp.h>
 
 static int ipcomp_decompress(struct xfrm_state *x, struct sk_buff *skb)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268065AbUIUU6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268065AbUIUU6c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 16:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268070AbUIUU5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 16:57:54 -0400
Received: from witte.sonytel.be ([80.88.33.193]:58504 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S268059AbUIUUzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 16:55:49 -0400
Date: Tue, 21 Sep 2004 22:55:30 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Roland Dreier <roland@topspin.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [PATCH] ppc64: Fix __raw_* IO accessors
In-Reply-To: <Pine.LNX.4.58.0409211237510.25656@ppc970.osdl.org>
Message-ID: <Pine.GSO.4.61.0409212254540.26509@waterleaf.sonytel.be>
References: <1095758630.3332.133.camel@gaston> <1095761113.30931.13.camel@localhost.localdomain>
 <1095766919.3577.138.camel@gaston> <523c1bpghm.fsf@topspin.com>
 <Pine.LNX.4.58.0409211237510.25656@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2004, Linus Torvalds wrote:
> On Tue, 21 Sep 2004, Roland Dreier wrote:
> > Is it possible to use __raw_*() in portable code?  I have some places

> > instead of what I really mean, which is:
> > 
> > 	__raw_writel(cpu_to_be32(val), addr);
> 
> should work, and if you start using it, and the driver is relevant, I'm 
> sure other architectures will implement the __raw_ interfaces too. In the 
> meantime, please just make it conditional on the proper architectures.

Yep, as soon as we _need_ them, m68k will get them...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

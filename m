Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266412AbUFQIZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266412AbUFQIZr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 04:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266413AbUFQIZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 04:25:47 -0400
Received: from witte.sonytel.be ([80.88.33.193]:29352 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266412AbUFQIZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 04:25:45 -0400
Date: Thu, 17 Jun 2004 10:25:24 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: make checkstack on m68k
In-Reply-To: <20040616180402.GB15365@wohnheim.fh-wedel.de>
Message-ID: <Pine.GSO.4.58.0406171024271.21503@waterleaf.sonytel.be>
References: <Pine.GSO.4.58.0406161845490.1249@waterleaf.sonytel.be>
 <20040616180402.GB15365@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004, [iso-8859-1] Jörn Engel wrote:
> On Wed, 16 June 2004 18:51:03 +0200, Geert Uytterhoeven wrote:
> >   - Make sure `make checkstack' uses the script in the source tree directory
> >     (BTW, I saw a few more targets in my eye corner that may need this)
> >
> > --- linux-2.6.7/Makefile	2004-06-16 13:06:15.000000000 +0200
> > +++ linux-m68k-2.6.7/Makefile	2004-06-16 18:27:13.000000000 +0200
> > @@ -1070,7 +1070,7 @@ endif #ifeq ($(mixed-targets),1)
> >  .PHONY: checkstack
> >  checkstack:
> >  	$(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
> > -	$(PERL) scripts/checkstack.pl $(ARCH)
> > +	$(PERL) $(src)/scripts/checkstack.pl $(ARCH)
>
> Does this actually matter?  Didn't hurt me yet.

Do you ever use `make -C path_to_src_tree O=$(pwd) checkstack'?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

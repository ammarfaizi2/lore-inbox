Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVAQJAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVAQJAm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 04:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbVAQJAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 04:00:42 -0500
Received: from witte.sonytel.be ([80.88.33.193]:18656 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261433AbVAQJAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 04:00:36 -0500
Date: Mon, 17 Jan 2005 10:00:30 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Cross-compilation broken (was: Re: Linux 2.6.11-rc1)
In-Reply-To: <20050116160948.GA3090@mars.ravnborg.org>
Message-ID: <Pine.GSO.4.61.0501170959110.3947@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
 <Pine.GSO.4.61.0501161016240.25137@waterleaf.sonytel.be>
 <20050116160948.GA3090@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jan 2005, Sam Ravnborg wrote:
> On Sun, Jan 16, 2005 at 10:22:43AM +0100, Geert Uytterhoeven wrote:
> > Changing
> > 
> > | NOSTDINC_FLAGS := -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> > 
> > to
> > 
> > | NOSTDINC_FLAGS = -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> > 
> > fixed it. I guess it picked up the definition for $(CC) before it became
> > $(CROSS_COMPILE)gcc.
> 
> Main culprint here is m68k fiddelign with definition of CROSS_COMPILE in
> arch/m68k/Makefile.
> If I find no better fix I will take your version.

M68k isn't the only one. Other archs with builtin automatic support for
cross-compilation do it as well: mips, hppa, hppa64, h8300.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266572AbUJGJuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266572AbUJGJuv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 05:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269785AbUJGJri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 05:47:38 -0400
Received: from witte.sonytel.be ([80.88.33.193]:33959 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S269782AbUJGJq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 05:46:56 -0400
Date: Thu, 7 Oct 2004 11:46:31 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Thayne Harbaugh <tharbaugh@lnxi.com>,
       =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is
 availlable
In-Reply-To: <20041007100757.A10716@flint.arm.linux.org.uk>
Message-ID: <Pine.GSO.4.61.0410071145330.9319@waterleaf.sonytel.be>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041006173823.GA26740@kroah.com>
 <20041006180421.GD10153@wohnheim.fh-wedel.de> <20041006181958.GB27300@kroah.com>
 <20041006192335.GH10153@wohnheim.fh-wedel.de> <1097097771.3845.28.camel@tubarao>
 <Pine.GSO.4.61.0410071017020.9319@waterleaf.sonytel.be>
 <20041007100757.A10716@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, Russell King wrote:
> On Thu, Oct 07, 2004 at 10:18:51AM +0200, Geert Uytterhoeven wrote:
> > What about letting the kernel open the console without going through
> > /dev/console? Since the kernel knows /dev/console is the device with major 5
> > minor 1, why can't it just open (5, 1)? Then we don't need a /dev/console node,
> > and things will never break.
> 
> Famous last words.  What about the case where you don't have a console
> device registered (eg in the case of an embedded device) ?  Currently,
> opening /dev/console fails in that circumstance.

Why didn't you quote the next line I wrote?

| Same for /dev/null as a fallback.

which answers your question :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUC1VI0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 16:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbUC1VI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 16:08:26 -0500
Received: from witte.sonytel.be ([80.88.33.193]:29099 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262208AbUC1VIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 16:08:24 -0500
Date: Sun, 28 Mar 2004 23:08:13 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
cc: Andrew Morton <akpm@osdl.org>, dwmw2@infradead.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove <asm/setup.h> from cmdlinepart.c
In-Reply-To: <200403251046.45232.bjorn.helgaas@hp.com>
Message-ID: <Pine.GSO.4.58.0403282307230.364@waterleaf.sonytel.be>
References: <200403251046.45232.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2004, Bjorn Helgaas wrote:
> Remove include of <asm/setup.h> from cmdlinepart.c.  This
> is not be needed for i386 (it builds fine with this patch),
> and ia64 doesn't supply a setup.h.
>
> asm/setup.h contains a hodge-podge of stuff with no real
> consistency between architectures.  It appears to be
> included mainly by arch-specific drivers:
> 	acsi (Atari disks)
> 	amiflop (Amiga floppy)
> 	z2ram (ZorroII ram disk)
> 	amiserial (Amiga serial)
> 	...
> and under arch-specific #ifdefs:
> 	fbcon (under __mc68000__ or CONFIG_APUS)
> 	fonts (ditto)
> 	logo (CONFIG_M68K)
> 	...

Indeed, <asm/setup.h> was introduced in the m68k port.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263479AbTLOKLH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 05:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTLOKLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 05:11:07 -0500
Received: from witte.sonytel.be ([80.88.33.193]:60804 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263479AbTLOKLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 05:11:04 -0500
Date: Mon, 15 Dec 2003 11:10:53 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Hunold <hunold@convergence.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH][2.4] change two annoying messages from framebuffer
 drivers
In-Reply-To: <3FD9BB4B.6040900@convergence.de>
Message-ID: <Pine.GSO.4.58.0312151109460.16964@waterleaf.sonytel.be>
References: <3FD9BB4B.6040900@convergence.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Dec 2003, Michael Hunold wrote:
> Two framebuffer drivers (clgenfb.c and hgafb.c), however, use KERN_ERR
> to say that their particular card has *not* been found which is very
> annoying.
>
> Especially the clgenfb.c driver simply says on bootup:
>  >  Couldn't find PCI device
> which can really confuse newbie users.
>
> The appended patch replaces two KERN_ERR with KERN_INFO and additionally
> makes the clgen.c message more descriptive.
>
> Please apply, thanks!

Patch looks OK to me, except that I would print `clgenfb' instead of `clgen'.

> I'll create a separate patch 2.6 later, apparently clgenfb.c has gone there.

It was renamed to cirrusfb.c.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267806AbUIJTMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267806AbUIJTMk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 15:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267804AbUIJTMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 15:12:40 -0400
Received: from witte.sonytel.be ([80.88.33.193]:12504 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267806AbUIJTMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 15:12:22 -0400
Date: Fri, 10 Sep 2004 21:11:37 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: blaisorblade_spam@yahoo.it
cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       User-mode Linux Kernel Development 
	<user-mode-linux-devel@lists.sourceforge.net>
Subject: Re: [uml-devel] [patch 1/1] Refer to CONFIG_USERMODE, not to CONFIG_UM
In-Reply-To: <20040910170859.24ABDC74B@zion.localdomain>
Message-ID: <Pine.GSO.4.58.0409102109330.9294@waterleaf.sonytel.be>
References: <20040910170859.24ABDC74B@zion.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004 blaisorblade_spam@yahoo.it wrote:
> We should also figure out how to make the config process work better for UML.
> We would like to make UML able to "source drivers/Kconfig" and have the right
> drivers selectable (i.e. LVM, ramdisk, and so on) and the ones for actual
> hardware excluded. I've been reading such a request even from Jeff Dike at the
> last Kernel Summit, (in the lwn.net coverage) but without any followup.

Yes, I agree 100%!

Drivers for `modern' hardware (e.g. PCI, USB), shouldn't be a problem, since
they have good dependencies.

`legacy' hardware is more of a problem. Since the consensus was that CONFIG_ISA
is meant to indicate ISA slots, perhaps we need something like CONFIG_XBUS to
mark all these legacy drivers?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

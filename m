Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266630AbUG0V34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266630AbUG0V34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 17:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUG0V3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 17:29:55 -0400
Received: from witte.sonytel.be ([80.88.33.193]:13252 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266630AbUG0V3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 17:29:50 -0400
Date: Tue, 27 Jul 2004 23:29:43 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Kconfig.debug: combine Kconfig debug options
In-Reply-To: <20040727104737.0de2da5b.rddunlap@osdl.org>
Message-ID: <Pine.GSO.4.58.0407272328500.19529@waterleaf.sonytel.be>
References: <20040723231158.068d4685.rddunlap@osdl.org>
 <Pine.GSO.4.58.0407271451130.19529@waterleaf.sonytel.be>
 <20040727104737.0de2da5b.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004, Randy.Dunlap wrote:
> On Tue, 27 Jul 2004 14:55:39 +0200 (MEST) Geert Uytterhoeven wrote:
> | On Fri, 23 Jul 2004, Randy.Dunlap wrote:
> | > . localizes the following symbols in lib/Kconfig.debug:
> | >     DEBUG_KERNEL, MAGIC_SYSRQ, DEBUG_SLAB, DEBUG_SPINLOCK,
> | >     DEBUG_SPINLOCK_SLEEP, DEBUG_HIGHMEM, DEBUG_BUGVERBOSE,
> | >     DEBUG_INFO
> |
> | Which architecture does _not_ use DEBUG_KERNEL or DEBUG_SLAB? The list is quite
> | long... Aren't these generic?
>
> Looks like all of them use DEBUG_KERNEL.
>
> DEBUG_SLAB is not available in cris, h8300, m68knommu, sh, sh64,
> or v850 AFAICT.  Yes/no ?

Probably someone just forgot to add them. DEBUG_SLAB is used in
arch-independent code only. So I guess it doesn't harm to allow DEBUG_SLAB for
all archs.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265315AbUG0Mz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbUG0Mz6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 08:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265199AbUG0Mz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 08:55:58 -0400
Received: from witte.sonytel.be ([80.88.33.193]:9679 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265776AbUG0Mzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 08:55:51 -0400
Date: Tue, 27 Jul 2004 14:55:39 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] Kconfig.debug: combine Kconfig debug options
In-Reply-To: <20040723231158.068d4685.rddunlap@osdl.org>
Message-ID: <Pine.GSO.4.58.0407271451130.19529@waterleaf.sonytel.be>
References: <20040723231158.068d4685.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2004, Randy.Dunlap wrote:
> . localizes the following symbols in lib/Kconfig.debug:
>     DEBUG_KERNEL, MAGIC_SYSRQ, DEBUG_SLAB, DEBUG_SPINLOCK,
>     DEBUG_SPINLOCK_SLEEP, DEBUG_HIGHMEM, DEBUG_BUGVERBOSE,
>     DEBUG_INFO

Which architecture does _not_ use DEBUG_KERNEL or DEBUG_SLAB? The list is quite
long... Aren't these generic?

Perhaps DEBUG_SPINLOCK can depend on just SMP only? Or do people want to debug
spinlock code on machines that don't have SMP?

Perhaps DEBUG_HIGHMEM can depend on just HIGHMEM only?

(didn't check the whole list) Perhaps the first instance of DEBUG_INFO
can depend on !SUPERH64 && !USERMODE only?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

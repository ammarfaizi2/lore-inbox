Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbTJJLzx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 07:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbTJJLzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 07:55:53 -0400
Received: from [80.88.36.193] ([80.88.36.193]:56009 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261403AbTJJLzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 07:55:50 -0400
Date: Fri, 10 Oct 2003 13:55:32 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Arun Sharma <arun.sharma@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.0-test7 BLK_DEV_FD dependence on ISA breakage
In-Reply-To: <16261.49965.101563.951148@gargle.gargle.HOWL>
Message-ID: <Pine.GSO.4.21.0310101349110.8302-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Oct 2003, Mikael Pettersson wrote:
> Arun Sharma writes:
>  > Andrew Morton wrote:
>  > > Perhaps we should just back it out and watch more closely next time someone
>  > > tries to fix it?
>  > 
>  > I'm fine with backing out the Kconfig part of the patch. Perhaps this is one of those things where an explicit list of platforms which do support this feature is unavoidable ? 
> 
> The Kconfig patch also broke floppy on x86-64. Since no x86-64 board
> to date has any ISA _slots_, x86-64 doesn't even give you the option
> of enabling CONFIG_ISA...

I'm not happy with the `CONFIG_ISA means ISA slots' logic, neither. For e.g.
PC-style floppy, it means `we have a (possibly burried withing PCI) ISA-style
bus'.

Furthermore, on some m68k machines we do have an ISA-style bus, but without
ISA-style DMA. This causes more drivers to fail compilation, giving me
headaches when trying to compile an all-yes-config kernel for m68k. I guess
other architectures are faced with the same problems.

Well, I guess I have to try the new drivers/Kconfig first and elaborate with a
list of drivers that failed and why they failed...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


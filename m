Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTENH6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 03:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbTENH6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 03:58:14 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:28591 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261190AbTENH6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 03:58:11 -0400
Date: Wed, 14 May 2003 10:09:46 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@digeo.com>,
       Christoph Hellwig <hch@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 must-fix list, v2
In-Reply-To: <20030514004332.I15172@flint.arm.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0305141005420.13491-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Russell King wrote:
> - I think we need a generic RTC driver (which is backed by real RTCs).
>   Integrator-based stuff has a 32-bit 1Hz counter RTC with alarm, as
>   has the SA11xx, and probably PXA.  There's another implementation
>   for the RiscPC and ARM26 stuff.  I'd rather not see 4 implementations
>   of the RTC userspace API, but one common implementation so that stuff
>   gets done in a consistent way.
> 
>   We postponed this at the beginning of 2.4 until 2.5 happened.  We're
>   now at 2.5, and I'm about to add at least one more (the Integrator
>   implementation.)  This isn't sane imo.

What about adding the periodic counter and alarm support to
drivers/char/genrtc.c? Genrtc is used on m68k, PA-RISC, PPC, MIPS (private
tree), and even on ia32.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


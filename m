Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUDPJZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 05:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262863AbUDPJZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 05:25:59 -0400
Received: from witte.sonytel.be ([80.88.33.193]:26041 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262837AbUDPJZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 05:25:58 -0400
Date: Fri, 16 Apr 2004 11:05:50 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, rth@twiddle.net,
       spyro@f2s.com, Russell King <rmk@arm.linux.org.uk>, davidm@hpl.hp.com,
       paulus@au.ibm.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jes Sorensen <jes@trained-monkey.org>, ralf@gnu.org, matthew@wil.cx,
       "David S. Miller" <davem@redhat.com>, wesolows@foobazco.org,
       jdike@karaya.com, ak@suse.de, Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH] sort out CLOCK_TICK_RATE usage, 2nd try  [0/3]
In-Reply-To: <20040414141245.GC18329@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.GSO.4.58.0404161059190.20787@waterleaf.sonytel.be>
References: <20040412075519.A5198@Marvin.DL8BCU.ampr.org>
 <20040413215833.A7047@Marvin.DL8BCU.ampr.org>
 <20040414141245.GC18329@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004, Matthew Wilcox wrote:
> On Tue, Apr 13, 2004 at 09:58:33PM +0000, Thorsten Kranzkowski wrote:
> > Arch maintainers please have a look whether I got the constants right or
> > if your architecture has a PIC or speaker at all.
>
> parisc certainly doesn't.  i'd start by making this change for alpha,
> x86 and x86_64 and make the PC speaker depend on (ALPHA || X86 || X86_64)
> then other arches can take it from there if they want to supoprt the
> pc speaker.

M68k has m68kspkr, which beeps through the m68k beep abstraction.

The only reason there's a 1193182 in drivers/input/misc/m68kspkr.c is for
userspace compatibility with ia32. So please don't introduce
include/asm-m68k/8253pit.h and keep CLOCK_TICK_RATE for m68k like it is.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

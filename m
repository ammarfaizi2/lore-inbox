Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281323AbRLEF6n>; Wed, 5 Dec 2001 00:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281124AbRLEF6X>; Wed, 5 Dec 2001 00:58:23 -0500
Received: from donna.siteprotect.com ([64.41.120.44]:52745 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S280967AbRLEF6N>; Wed, 5 Dec 2001 00:58:13 -0500
Date: Wed, 5 Dec 2001 00:58:07 -0500 (EST)
From: John Clemens <john@deater.net>
X-X-Sender: <john@pianoman.cluster.toy>
To: Cory Bell <cory.bell@usa.net>
cc: <linux-kernel@vger.kernel.org>, <mj@ucw.cz>
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
In-Reply-To: <1007529416.2339.0.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0112050036440.25305-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4 Dec 2001, Cory Bell wrote:
> 11. Using the patch below (shamelessly stolen from John Clemens and
> modified slightly -
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0111.2/0005.html),

someone noticed! ;) Glad to see you also noticed my minor oversight in
using INTERRUPT_PIN instead of the correct INTERRUPT_LINE.  Glad someone
found the work useful... A few people have asked me separately for my
patch and are using it successfully on thier laptops with no failure
reports.

> What I'm wondering is - what's broken?
> Is it:
> 1) Bad BIOS? (changing the date is as configurable as it gets - and I
> have updated to the latest available version)

Most probably.. that in combination with number 3.. And, to top it all
off, ACPI is thrown in there too as a non-PCI device on IRQ9.  All in all,
quite a quirky laptop (for reference, I own an N5430, an earlier version
of your notebook).

> 2) Bad Linux interperetation of ALi IRQ router? (comments in
> linux/arch/i386/kernel/pci-irq.c seem to suggest it's possible)

Doubtful, as I have an Ali Aladdin7 board in my desktop (don't get much
more obscure than that one), and the Router works fine, as well as in a
Magik1 based motherboard I've used.

> Is there a "correct" way to fix this? Info follows. If anyone would like
> additional info (full dmesg output, etc) I'd be happy to email it
> seperately.

I've been wondering this one myself... one thing these laptops do
implement is a complete DMI table.. maybe we can do some sort of fixup
through there... does anyone know of any way to use the "DMI workarounds"
to effect PCI IRQ mapping -without- modifying the generic pci code?

And I like you patch, it's a slightly cleaner for of ugly than mine :).

john.c

-- 
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751818AbWJWIeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbWJWIeX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 04:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWJWIeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 04:34:23 -0400
Received: from witte.sonytel.be ([80.88.33.193]:15260 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751804AbWJWIeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 04:34:22 -0400
Date: Mon, 23 Oct 2006 10:34:16 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andi Kleen <ak@suse.de>
cc: Matthew Wilcox <matthew@wil.cx>, Randy Dunlap <rdunlap@xenotime.net>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
In-Reply-To: <200610230341.23978.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0610231029240.1272@pademelon.sonytel.be>
References: <20061018091944.GA5343@martell.zuzino.mipt.ru> <200610230331.16573.ak@suse.de>
 <20061023013604.GF25210@parisc-linux.org> <200610230341.23978.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2006, Andi Kleen wrote:
> > This needs annotations to fix, or a big bag of unreliable heuristics.
> 
> Ok you're right that case would need annotations.

Annotations are a different thing. Personally, I don't like adding them.

> I retreat my earlier statement that self sufficient include files
> are a good idea.  If it needs such hacks to do it it's probably not worth
> it. After all it won't fix a single bug.

  - It will fix bugs of the type: add #include <x.h> to y.c because on some
    architectures x.h isn't automatically pulled in by z.h.

  - It would help in cleaning up the zillions of includes in the .c files,
    decreasing compile time.

  - It would make it easier for developers, since if you need something, you
    just have to explicitly include the header file that defines it, and not
    have to find out the hard way what other stuff to include.

I agree, that's not that many `real bugs'.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

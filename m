Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269751AbUJGIW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269751AbUJGIW3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 04:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269753AbUJGIW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 04:22:29 -0400
Received: from witte.sonytel.be ([80.88.33.193]:5248 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S269751AbUJGIW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 04:22:27 -0400
Date: Thu, 7 Oct 2004 10:22:13 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>
cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: __init poisoning for i386, too
In-Reply-To: <20041006152924.5ae6e94d.akpm@osdl.org>
Message-ID: <Pine.GSO.4.61.0410071020480.9319@waterleaf.sonytel.be>
References: <20041006221854.GA1622@elf.ucw.cz> <20041006152924.5ae6e94d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004, Andrew Morton wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
> > Overwrite __init section so calls to __init functions from normal code
> > are catched, reliably. I wonder if this should be configurable... but
> > it is configurable on x86-64 so I copied it. Please apply,
> 
> No, I'll change it to just enable the thing unconditionally.

And can't such things be done in architecture-neutral code, to avoid code
duplication and out-of-sync code among different architectures?

The magic value that corresponds to an illegal instruction (as suggested by
wli) is arch-dependent, of course.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

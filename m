Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265995AbUBJQ30 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265998AbUBJQ3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:29:25 -0500
Received: from witte.sonytel.be ([80.88.33.193]:5337 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265995AbUBJQ3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:29:24 -0500
Date: Tue, 10 Feb 2004 17:29:15 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg KH <greg@kroah.com>
cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dmapool (was: Re: Linux 2.6.3-rc2)
In-Reply-To: <20040210162259.GA26620@kroah.com>
Message-ID: <Pine.GSO.4.58.0402101727130.2261@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org>
 <Pine.GSO.4.58.0402101424250.2261@waterleaf.sonytel.be>
 <Pine.GSO.4.58.0402101531240.2261@waterleaf.sonytel.be> <20040210145558.A4684@infradead.org>
 <20040210162259.GA26620@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004, Greg KH wrote:
> On Tue, Feb 10, 2004 at 02:55:58PM +0000, Christoph Hellwig wrote:
> > On Tue, Feb 10, 2004 at 03:32:47PM +0100, Geert Uytterhoeven wrote:
> > > This patch seems to fix the problem (all offending platforms include
> > > <asm/generic.h> if CONFIG_PCI only):
> >
> > Umm, no the whole point of the dmapool is that it's not pci-dependent.
> > Just fix your arch to have proper stub dma_ routines.  There were at
> > least two headsups during 2.5 and 2.6-test that this will be required.
>
> Exactly.  Why is your arch including a header file that you can't build?

It's included if CONFIG_PCI is enabled (for the few m68k platforms that do have
PCI). In that case everything should work fine (fingers crossed).

> How about dropping this into your arch if you can't use the
> include/asm-generic/dma-mapping.h file.  Or I can add it as
> include/asm-generic/dma-mapping-broken.h and you can repoint your arch
> to use it.  Which would be easier for you?

Since others may need it as well, include/asm-generic/dma-mapping-broken.h
should be fine.

Let's see what the sparc guys have to comment...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

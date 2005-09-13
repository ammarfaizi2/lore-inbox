Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbVIMR5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbVIMR5o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbVIMR5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:57:44 -0400
Received: from witte.sonytel.be ([80.88.33.193]:43956 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S964948AbVIMR5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:57:43 -0400
Date: Tue, 13 Sep 2005 19:57:30 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@infradead.org>
cc: J?rn Engel <joern@infradead.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Missing #include <config.h>
In-Reply-To: <20050913141246.GA3234@infradead.org>
Message-ID: <Pine.LNX.4.62.0509131956030.24748@numbat.sonytel.be>
References: <20050913135622.GA30675@phoenix.infradead.org>
 <20050913150825.A23643@flint.arm.linux.org.uk> <20050913141246.GA3234@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005, Christoph Hellwig wrote:
> On Tue, Sep 13, 2005 at 03:08:26PM +0100, Russell King wrote:
> > On Tue, Sep 13, 2005 at 02:56:23PM +0100, J?rn Engel wrote:
> > > After spending some hours last night and this morning hunting a bug,
> > > I've found that a different include order made a difference.  Some
> > > files don't work correctly, unless config.h is included before.
> > 
> > I'm still of the opinion that we should add
> > 
> > 	-imacros include/linux/config.h
> > 
> > to the gcc command line and stop bothering with trying to get
> > linux/config.h included into the right files and not in others.
> > (which then means we can eliminate linux/config.h from all files.)
> 
> Yes, absolutely.  That would help fixing lots of mess.

What about dependencies? Would it cause a recompile of everything if config.h
is changed?

[...]

Ah, I guess not, since config.h is filtered out of the deps anyway and replaced
by a smarter dependency on the correct CONFIG_*, right?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

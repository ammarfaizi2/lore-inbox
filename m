Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268095AbUJSJHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268095AbUJSJHd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268092AbUJSJHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:07:33 -0400
Received: from witte.sonytel.be ([80.88.33.193]:46227 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S268095AbUJSJHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:07:08 -0400
Date: Tue, 19 Oct 2004 11:06:22 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: cliff white <cliffw@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Enough with the ad-hoc naming schemes, please
In-Reply-To: <20041018214407.B6344@flint.arm.linux.org.uk>
Message-ID: <Pine.GSO.4.61.0410191050140.13789@waterleaf.sonytel.be>
References: <20041018180851.GA28904@waste.org> <20041018113807.488969ab.cliffw@osdl.org>
 <20041018214407.B6344@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004, Russell King wrote:
> On Mon, Oct 18, 2004 at 11:38:07AM -0700, cliff white wrote:
> > On Mon, 18 Oct 2004 13:08:51 -0500
> > Matt Mackall <mpm@selenic.com> wrote:
> > > I can't help but notice you've broken all the tools that rely on a
> > > stable naming scheme TWICE in the span of LESS THAN ONE POINT RELEASE.
> > > 
> > > In both cases, this could have been avoided by using Marcello's 2.4
> > > naming scheme. It's very simple: when you think something is "final",
> > > you call it a "release candidate" and tag it "-rcX". If it works out,
> > > you rename it _unmodified_ and everyone can trust that it hasn't
> > > broken again in the interval. If it's not "final" and you're accepting
> > > more than bugfixes, you call it a "pre-release" and tag it "-pre".
> > > Then developers and testers and automated tools all know what to
> > > expect.
> > 
> > Speaking for OSDL's automated testing team, we second this motion. 
> 
> <aol>me too</aol>  I've already made some representations to Linus
> in private, and now I'm actively queueing up patches which have been
> sitting around since the start of -rc1.  I, for one, no longer believe
> in any naming scheme associated with mainline.

Ah, I'm not the only one! Apparently not all obvious fixes for things that got
obviously broken in 2.6.9-rc* were applied :-(

Not to mention e.g. the m68k signal handling got broken because of the removal
(without any warning in advance on linux-arch) of notify_parent(), which is BTW
still used by 5 archs, either in code or in comments (never trust comments?).

Gr{oetje,eeting}s,

				    Geert (sometimes frustrated maintainer,
					   sometimes typing emails without
					   much calming down first ;-)

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

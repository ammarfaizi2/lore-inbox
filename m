Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289080AbSAIXc6>; Wed, 9 Jan 2002 18:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289081AbSAIXbv>; Wed, 9 Jan 2002 18:31:51 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:63109 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S289080AbSAIXbH>;
	Wed, 9 Jan 2002 18:31:07 -0500
Date: Thu, 10 Jan 2002 00:30:37 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Ville Herva <vherva@niksula.hut.fi>
cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Jani Forssell <jani.forssell@viasys.com>
Subject: Re: Via KT133 pci corruption: stock 2.4.18pre2 oopses as well
In-Reply-To: <20020109235722.L1200@niksula.cs.hut.fi>
Message-ID: <Pine.LNX.4.21.0201100025440.14057-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Ville Herva wrote:

> On Wed, Jan 09, 2002 at 01:00:53PM -0800, you [Andrew Morton] claimed:
> > Ville Herva wrote:
> > > 
> > > >>EIP; c0131ce0 <sync_page_buffers+10/b0>   <=====
> > 
> > Looks like a corrupted `next' pointer in the page's buffer_head
> > ring.  Your report is identical to Todd Eigenschink's repeatable
> > oops.  http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.3/0689.html
> > 
> > In another thread, yesterday, we were discussing the elusive
> > "end_request: buffer-list destroyed" crash.
> 
> (...)
>  
> > There were VM changes, and a messy, complex and undocumented change to
> > sync_page_buffers(), which was the point at which I ceased to understand
> > that function.
> 
> Nice, yet one more variable to the equation ;). And I thought I could rule
> out kernel bugs by reproducing this on supposedly stable kernel (the 2.2.20
> I used had all sort of patches in it; ide, e2compr and raid to name the
> largest ones.)
> 
> This could be a sync_page_buffers() bug, but what puzzles me is that I can
> reproduce the oopses on 2.2 as well (although they can of course be
> different oopses). 
> 
> Also, I'm seeing ide and network corruption that would very much point to
> pci transfer corruption. Of course, it can be that the oopses are not caused
> by that.

I havn't followed this thread but I have a machine with an Asus A7V
motherboard with KT133 chipset and we had massive corruption before
christmas, both ide and network had corrupted packets. and now after
christmas we ran memtest86 on it and a 256MB module was very very broken.
and we got alot of Oopses and all kinds of strange stuff happened.

We've replaved that memory module now and now it's better but I have to
say that the KT133 or atleast the Asus A7V motherboard seems to be quite
broken. we have a lot of spurious irq's and the ide controllers freak when
but under some load and start getting irq timeouts and resets the ide
channels over and over again with some delay in between when it kind of
works, slow as hell but works.

We are going to replace the motherboard with one with VIA KT266A chipset,
hope that works better.

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUFOVYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUFOVYh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 17:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265974AbUFOVYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 17:24:37 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:37017 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S265973AbUFOVYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 17:24:34 -0400
Date: Tue, 15 Jun 2004 14:24:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/5] kbuild
Message-ID: <20040615212432.GH14528@smtp.west.cox.net>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040615154136.GD11113@smtp.west.cox.net> <20040615174929.GB2310@mars.ravnborg.org> <20040615175453.GD14528@smtp.west.cox.net> <20040615190119.GC2310@mars.ravnborg.org> <20040615192740.GF14528@smtp.west.cox.net> <20040615210240.GL2310@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615210240.GL2310@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 11:02:40PM +0200, Sam Ravnborg wrote:

> On Tue, Jun 15, 2004 at 12:27:40PM -0700, Tom Rini wrote:
> > 
> > What I don't see is why:
> > 'znetboot - Build a zImage and put into /tftpboot/
> >  uImage - Build an image for U-Boot
> >  rom.img - Build an image to live on ROM
> >  srec - Build an SREC image'
> > 
> > etc, isn't sufficient, in the archhelp.
> 
> Two things.
> 1) You better remember to specify them each and every time.
>    Otherwise uImage gets out of sync with the kernel.

Yes, you better.  If you want the kernel to do a little extra for you,
you need to remember to tell it that.

> 2) I know the srec format, but that is no help to expaling me
>    the actual content of the file.
>    Memory layout, start address or whatever. Where to find this info.
>    Same goes for other targets. I you know your stuff no swaet.
>    But for $random hacker it becomes another obstacle

Let me try this a different way.  The only valid boot targets on ppc32
are:
- zImage (which is what all does)
- znetboot (zImage + copy to /tftpboot/)
- uImage (U-Boot'ify a kernel)

wrt the last one, I'm torn between making it something that always
happens, since it's just so easy, and if it fails, we can just not care
about it (||true it, or something) or just not worry about it, since if
you're using U-Boot most likely you've already flashed it on, and know
what you're doing).

The "pick the right target" mojo done to ppc32 is like doing it on i386,
it's not a good example of what'll be cleaned up.  Same, so it seems,
with ARM.  WRT MIPS, I've pointed Ralf at the thread, and he should
speak up soon, I hope :)

-- 
Tom Rini
http://gate.crashing.org/~trini/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136488AbREDTiN>; Fri, 4 May 2001 15:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136489AbREDTiD>; Fri, 4 May 2001 15:38:03 -0400
Received: from [136.159.55.21] ([136.159.55.21]:52612 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S136488AbREDThp>; Fri, 4 May 2001 15:37:45 -0400
Date: Fri, 4 May 2001 13:36:31 -0600
Message-Id: <200105041936.f44JaVY11944@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <Pine.GSO.4.21.0105041504240.21896-100000@weyl.math.psu.edu>
In-Reply-To: <200105041849.f44InZa11520@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0105041504240.21896-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Fri, 4 May 2001, Richard Gooch wrote:
> 
> > > Two of them: use less bloated shell (and link it statically) and
> > > clean your rc scripts.
> > 
> > No, because I'm not using the latest bloated version of bash, and I'm
> 
> Umm... Last version of bash I could call not bloated was _long_ time
> ago. Something like ash(1) might be a better idea for /bin/sh.

The shell is irrelevant. I can easily preload that too, if I wanted
to, since it's just one thing. But it's not practical to preload all
files used by name, because it's just too hard to find out all that is
needed. Too much people time required, and it is specific to one
distribution (and a particular revision at that).

> > The problem is all the various daemons and system utilities (mount,
> > hwclock, ifconfig and so on) that turn a kernel into a useful system.
> > And then of course there's X...
> 
> How do you partition the thing? I.e. what's the size of your root
> partition?  I'm usually doing something from 10Mb to 30Mb - that may
> be the reason of differences.

I don't bother splitting /usr off /. I gave up doing that when disc
became cheap. There's no point anymore. And since I have a lightweight
distribution (500 MiB and I get X, LaTeX, emacs, compilers, netscrap
and a pile of other things), it makes even less sense to split /usr
off. Sorry, I don't have those fancy desktops. Don't need 'em. I spend
most of my day in emacs and xterm.

And even if I did split /usr off, that would just mean I'd want to
record block accesses for that device as well. This is because part of
my boot process requires stuff in /usr. And after that, firing up xdm.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

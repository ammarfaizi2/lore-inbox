Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136494AbREDUFs>; Fri, 4 May 2001 16:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136497AbREDUFi>; Fri, 4 May 2001 16:05:38 -0400
Received: from [136.159.55.21] ([136.159.55.21]:23941 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S136494AbREDUF3>; Fri, 4 May 2001 16:05:29 -0400
Date: Fri, 4 May 2001 14:04:20 -0600
Message-Id: <200105042004.f44K4KB12214@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <Pine.GSO.4.21.0105041539360.21896-100000@weyl.math.psu.edu>
In-Reply-To: <200105041936.f44JaVY11944@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0105041539360.21896-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Fri, 4 May 2001, Richard Gooch wrote:
> 
> > I don't bother splitting /usr off /. I gave up doing that when disc
> > became cheap. There's no point anymore. And since I have a lightweight
> 
> Yes, there is. Locality. Resistance to fs fuckups. Resistance to
> disk fuckups. Easier to restore from tape. Different tunefs optimum
> (higher inodes/blocks ratio, for one thing). Ability to keep /usr
> read-only.  Enough?

The correct solution to avoiding fs fuckups is to keep /tmp, /var and
/home separate. Basically, anything that gets written to for reasons
other than sysadmin/upgrades.

However, my point is not that it's always a bad idea to split /usr,
simply that the converse is not true. IOW, it is not true to say that
/usr *should* be split off. For a generic workstation, splitting /usr
is not useful. Importantly, it is most certainly entirely valid to
keep /usr on /.

> > distribution (500 MiB and I get X, LaTeX, emacs, compilers, netscrap
> > and a pile of other things), it makes even less sense to split /usr
> > off. Sorry, I don't have those fancy desktops. Don't need 'em. I spend
> > most of my day in emacs and xterm.
> 
> What desktops? None of that crap on my boxen either. EMACS? What EMACS?
> LaTeX is unfortunately needed (I prefer troff and AMSTeX on the TeX side).
> Netrape? No chance in hell. bash <spit> is there, but I prefer to use
> rc.
> 
> I don't see what does it have to keeping root on a separate
> filesystem, though - the reasons have nothing to bloat in /usr/bin.

In any case, my point is that splitting /usr wouldn't help, because
I'd want to preload stuff from there as well. Splitting /usr doesn't
address the problem.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

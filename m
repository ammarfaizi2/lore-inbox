Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313627AbSDURN5>; Sun, 21 Apr 2002 13:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSDURN4>; Sun, 21 Apr 2002 13:13:56 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:14242 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S313627AbSDURNz>;
	Sun, 21 Apr 2002 13:13:55 -0400
Date: Sun, 21 Apr 2002 13:13:54 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ian Molton <spyro@armlinux.org>,
        linux-kernel@vger.kernel.org
Subject: Re: BK, deltas, snapshots and fate of -pre...
Message-ID: <20020421131354.C4479@havoc.gtf.org>
In-Reply-To: <20020421044616.5beae559.spyro@armlinux.org> <Pine.GSO.4.21.0204202347010.27210-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 12:05:27AM -0400, Alexander Viro wrote:
> "Linus documentation".
> 
> /me carefully stays the hell away from discussing whether it's a part of
> documented object or not and what would be the license on said object...

A discussion on _Linus_ licensing would be interesting ;-)

To be pedantic, though, I point out that the BK doc at the center of
this flamewar is GPL'd.


> FWIW, I doubt that dropping -pre completely in favour of dayly snapshots is
> a good idea - "2.5.N-preM oopses when ..." is preferable to "snapshot YY/MM/DD
> oopses when..." simply because it's easier to match bug reports that way.
> Having all deltas downloadable as diff+comment is wonderful, but it doesn't
> replace well-defined (and less frequent) resync points.
> 
> Comments?

hmmm hmmm.

My alternative suggestion, which only applies to development series
kernels, is to spit out pre-patches and releases more frequently.
The releases would be your formal testing points by users, and the
pre-patches would be the sync points for developers, and test points
for developers.  i.e. make the current system work as intended ;-)

Maybe write a script for Linus that automates his side of pre-patch
publishing (if it isn't 100% automatic now)?  i.e. my guess is that
pre-patching is currently automated maybe 70% or so...  This automation
I describe increments the pre-patch number in the makefile, checks
that update into BK, rolls a patch, scp's it to master, and posts the
changelog to linux-kernel.  I could roll a demo script that does this,
if people think this is a sane alternative.

IOW, I propose to create a "linuspush" script that replaces his current
"bk push" command.  Linus pushes batches of csets out at a time,
make these cset batches the pre-patches...

	Jeff, who wouldn't mind snapshots either





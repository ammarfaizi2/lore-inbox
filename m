Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWBVWvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWBVWvY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWBVWvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:51:24 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:28311
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751028AbWBVWvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:51:23 -0500
Date: Wed, 22 Feb 2006 14:51:05 -0800
From: Greg KH <gregkh@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Gabor Gombas <gombasg@sztaki.hu>,
       "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       penberg@cs.helsinki.fi, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222225105.GA6988@suse.de>
References: <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org> <20060222112158.GB26268@thunk.org> <20060222154820.GJ16648@ca-server1.us.oracle.com> <20060222162533.GA30316@thunk.org> <20060222173354.GJ14447@boogie.lpds.sztaki.hu> <20060222185923.GL16648@ca-server1.us.oracle.com> <20060222191832.GA14638@suse.de> <1140636588.2979.66.camel@laptopd505.fenrus.org> <20060222194024.GA15703@suse.de> <20060222204508.GO8852@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222204508.GO8852@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 09:45:08PM +0100, Jens Axboe wrote:
> On Wed, Feb 22 2006, Greg KH wrote:
> > On Wed, Feb 22, 2006 at 08:29:48PM +0100, Arjan van de Ven wrote:
> > > On Wed, 2006-02-22 at 11:18 -0800, Greg KH wrote:
> > > > What about trying a stock 2.6.6 or so kernel?  Does that work
> > > > differently from 2.6.15?
> > > 
> > > ... however it's very much designed only for the kernel that comes with
> > > it (with "it's" I mean all the userspace infrastructure); all the
> > > changes and additions since 2.6.9 aren't incorporated so you probably
> > > really want new alsa, new initscripts, new mkinitrd, new
> > > module-init-tools. some because of abi changes since 2.6.9, others
> > > because the kernel grew capabilities that are really needed for "nice"
> > > behavior.
> > 
> > I totally agree.  Distros are changing into two different groups these
> > days:
> > 	- everything tied together and intregrated nicely for a specific
> > 	  kernel version, userspace tool versions, etc.
> > 	- flexible and works with multiple kernel versions, different
> > 	  userspace tools, etc.
> > 
> > Distros in the first category are the "enterprise" releases (RHEL, SLES,
> > etc.), as well as some consumer oriented distros (SuSE, Ubuntu, Fedora
> > possibly.)
> > 
> > More flexible distros that handle different kernel versions are Gentoo,
> > Debian, and probably Fedora.
> > 
> > And this is a natural progression as people try to provide a more
> > complete "solution" for users.
> > 
> > When people to complain that they can't run a "kernel-of-the-day" on
> > their "enterprise" distro, they are not realizing that that distro was
> > just not developed to support that kind of thing at all.
> 
> I have to disagree somewhat violently to that statement, I'm afraid :-)
> At least for me, it's pretty much a requirement that I can put eg
> 2.6.18-rc2 on an enterprise install. It's a must to debug problems -
> both ways, actually, testing both a new rc kernel on that enterprise
> distro but also putting a vanilla kernel on the enterprise distro to
> test something that fails with the distro kernel.

I agree that is is a _good_ thing that us kernel developers can do this,
and that it isn't impossible (I do the same thing.)  But we also aren't
worrying about the fact that our sound stopped working, or that the
desktop icons don't show up anymore if we plug in a new device.  We are
a very special case.

For any "user", they should not ever count on using a different kernel
than what was shipped with the system (or updates) for an "enterprise"
distro.  There are just too many little things that easily go wrong.

> I'd absolutely hate if we got into a situation where you couldn't just
> put a new vanilla kernel on SLESx. Calling it a complete solution to
> just sounds like an excuse for breaking things that we don't have to.
> Please lets not make things so fragile!

We are trying, but as everyone is so quick to point out, we (myself
included) mess up at times :)

thanks,

greg k-h

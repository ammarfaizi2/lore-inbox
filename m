Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292705AbSCRT5y>; Mon, 18 Mar 2002 14:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292688AbSCRT5q>; Mon, 18 Mar 2002 14:57:46 -0500
Received: from [195.39.17.254] ([195.39.17.254]:39298 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S292705AbSCRT5k>;
	Mon, 18 Mar 2002 14:57:40 -0500
Date: Mon, 18 Mar 2002 20:25:02 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Jonathan Barker <jbarker@ebi.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: VFS mediator?
Message-ID: <20020318192502.GD194@elf.ucw.cz>
In-Reply-To: <E16lej0-0002FE-00@the-village.bc.nu> <Pine.GSO.4.21.0203141825070.329-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I have experimented with using NFS for that -- start a local daemon that
> > > exports a virtual filesystem and mount that. The great bonus is that it's
> > > platform independent -- it works on Solaris, HP-UX and even Ultrix just as
> > > well. Other projects have become more important, however, and I haven't
> > > finished it. If you're interested, drop me a line.
> > 
> > There are several of these and also some folks using the coda interface
> > to do the same work, as the coda interface is sometimes better suited. 
> 
> ... for some kinds of work.
> 
> First of all, "VFS mediator" is simply a userland filesystem.  That's
> precisely what it is - filesystem that talks to a process.  We've got
> quite a few of them and which one fits the task depends on the task.
> 
> 	* NFS (v2,v3):  Portable.  And that's the only good thing to say
> about it - it's stateless, it has messy semantics all over the place and
> implementing userland server requires a lot of glue.

Does not work... If you mount nfs server on localhost, you can deadlock.

> 	* CODA: nice if you want commit-on-close semantics and basically
> want a lot of regular files.  More or less portable, userland side doesn't
> require much glue.  Has a nice local caching and as the result bad for any
> RPC-style uses.

And the only one that works when r/w mounted on localhost.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa

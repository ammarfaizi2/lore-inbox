Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S129478AbRC1H21>; Wed, 28 Mar 2001 02:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131736AbRC1H2R>; Wed, 28 Mar 2001 02:28:17 -0500
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:14346 "HELO sh0n.net") by vger.kernel.org with SMTP id <S129478AbRC1H2J>; Wed, 28 Mar 2001 02:28:09 -0500
Date: Wed, 28 Mar 2001 02:27:47 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Disturbing news..
In-Reply-To: <20010328101910.D23336@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.30.0103280225460.8046-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, why can't the ELF loader module/kernel detect or have some sort of
restriction on modifying other/ELF binaries including itself from changing
the Entry point?

There has to be a way stop this. WHY would anyone want to modify the entry
point anyway? (there may be some reasons but I really dont know what).
Even if it's user level, this cant affect files with root permissions
(unless root is running them or suid).

Any idea?

On Wed, 28 Mar 2001, Matti Aarnio wrote:

> On Wed, Mar 28, 2001 at 01:16:02AM -0500, Shawn Starr wrote:
> > Date:	Wed, 28 Mar 2001 01:16:02 -0500 (EST)
> > From:	Shawn Starr <spstarr@sh0n.net>
> > To:	<linux-kernel@vger.kernel.org>
> > Subject: Disturbing news..
> >
> > http://news.cnet.com/news/0-1003-200-5329436.html?tag=lh
> > Isn't it time to change the ELF format to stop this crap?
> > Shawn.
>
> 	Why ?   "Double-click on attachment to run it" is typical
> 		M$ client stupidity -- and the reason why there
> 		are so many things that can mail themselves around.
>
> 	Changeing ELF-format would be comparable to what M$ did when
> 	they met the first Word macro viruses -- they changed the
> 	script language inside the Word...   What good did that do ?
> 	Did it harm people ?  You bet...
>
>
> 	You are downloading binaries off the net, and not compiling
> 	from the sources ?  (Yes, we all do that.  This is why folks
> 	these days carry PGP signatures at the RPM packages.)
>
>
> 	So, the program modifies ELF format executables by rewriting
> 	some instructions in the beginning (propably to map-in the virus
> 	code proper with X-bit on), and tags itself (PIC presumably) at
> 	the end of the file.
>
>
>
> 	Another issue is "safe conduct" practice of installing binaries
> 	with minimum privileges (ok, granted that for e.g. RPMs that
> 	usually means root), and *never* running them with undue levels
> 	of privileges -- not even as the owner of said executables.
>
>
>
> 	Ok, granted that we have dangers of getting arbitrary BAD programs
> 	into our systems, how can we combat that ?   Virus-scanners
> 	(as much good as they could do..) don't really work in UNIX
> 	environments where "small things" like intercept of every
> 	exec(), and open() via privileged program (scanner) is not
> 	available feature. (I think doing it by passing a AF_UNIX
> 	message with fd + flags to registered server, expecting answer
> 	for the open() -- this would happen *after* the file open is
> 	done with user privileges, but before the call returns.)
> 	(Trapping open() so that shared-libraries could be scanned.)
>
> 	There could be, I think, a method for doing such intercepts,
> 	which could be used by security scanners to implement some
> 	sense of security in Linux-like systems.
>
> 	Is it good enough, e.g. when some file is multiply-mapped to
> 	shared programs, and application rewrites parts of the file ?
> 	Can it detect that kind of multi-mapped writing-sharing ?
>
> 	Can such system be made fast ?  (Scanner becomes performance
> 	bottle-neck.)
>
>
> 	How about PROPER Orange Book B-level security ?
> 	E.g. NSA trusted-linux ?
>
>
> /Matti Aarnio
>
>


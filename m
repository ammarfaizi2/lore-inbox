Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbTBSRyC>; Wed, 19 Feb 2003 12:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbTBSRyC>; Wed, 19 Feb 2003 12:54:02 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:63748 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261855AbTBSRyB>; Wed, 19 Feb 2003 12:54:01 -0500
Date: Wed, 19 Feb 2003 13:00:39 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.61 (Yes, there are still Alpha users out there. :-) )
In-Reply-To: <20030217212922.GD351@lug-owl.de>
Message-ID: <Pine.LNX.3.96.1030219123109.10611A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; MICALG=pgp-sha1; PROTOCOL="application/pgp-signature"; BOUNDARY=kncZREqT6Wt3NQEl
Content-ID: <Pine.LNX.3.96.1030219123109.10611B@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--kncZREqT6Wt3NQEl
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-ID: <Pine.LNX.3.96.1030219123109.10611C@gatekeeper.tmr.com>

On Mon, 17 Feb 2003, Jan-Benedict Glaw wrote:

> On Mon, 2003-02-17 10:39:38 -0500, Fred K Ollinger <follinge@sas.upenn.edu>
> wrote in message <Pine.GSO.4.51.0302171039160.13696@mail2.sas.upenn.edu>:
> > > There were also some problems with make modules_install for me!
> > 
> > How did you handle it?
> 
> I had nothing to handle - everything went out of the box.
> 
> > What version of modutils was installed?
> 
> For recent 2.5.x kernels, you don't any longer need modutils. There was
> a major rewrite of all module related code which requires new tools.
> These are called "module-init-tools", my distribution has got a package
> for it (with the same name). If you cannot get that brand new software
> from your distributor, look at
> ftp://ftp.kernel.org/pub/linux/kernel/people/people/rusty/modules/ .

Be aware that for Redhat and SuSE distributions (and mandrake??) "make
install" will fail because mkinitrd doesn't know about the new modules
format.

I asked Rusty about this and he noted that he doesn't use mkinitrd, isn't
qualified to patch it, and has no plans to provide a working version.
Another user noted that there is an alpha version of the Debian program of
the same name which does work, but it isn't compatible (to what degree I
don't know).

So you can give up using modules for anything you want to use to boot,
change to Debian, or try and find the Debian alpha version and port that
to other distributions.

I'm sure the vendors will do this port at some point, until then there are
no quick solution but "build it all in."

There are issues with probe and probeall as well, as I recall one is
missing and the other doesn't work. They may both be missing and I just
got different error messages, or made different notes in my notes file, 
don't know.

I haven't seen a detail doc on exactly how the new interface works, which
seems useful if someone other than a guru wants to start porting modules
to the new system. It's probably in the doc which tells what benefits have
come from the new system, I haven't found that one, either.

Read the man page for modprobe.conf, it says there are many missing
features, then says the features which are there are so powerful you won't
miss the features you don't have, then says it's so easy you can write
your own if you think there's a need.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--kncZREqT6Wt3NQEl--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVFAAwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVFAAwg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 20:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVFAAwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 20:52:36 -0400
Received: from zlynx.org ([199.45.143.209]:27917 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S261222AbVFAAwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 20:52:32 -0400
Subject: Re: RT patch acceptance
From: Zan Lynx <zlynx@acm.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrea Arcangeli <andrea@suse.de>,
       Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, hch@infradead.org, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, Andi Kleen <ak@muc.de>,
       "Bill Huey (hui)" <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       James Bruce <bruce@andrew.cmu.edu>
In-Reply-To: <1117582887.4749.6.camel@localhost.localdomain>
References: <Pine.OSF.4.05.10505311347290.1707-100000@da410.phys.au.dk>
	 <1117556283.2569.26.camel@localhost.localdomain>
	 <20050531171143.GS5413@g5.random>
	 <1117561379.2569.57.camel@localhost.localdomain>
	 <20050531175152.GT5413@g5.random>
	 <1117564192.2569.83.camel@localhost.localdomain>
	 <20050531205424.GV5413@g5.random>
	 <1117574551.5511.19.camel@localhost.localdomain>
	 <1117576067.23573.16.camel@mindpipe>
	 <1117582887.4749.6.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rqn/vQ+1UrY7gIVF4GpT"
Date: Tue, 31 May 2005 18:50:03 -0600
Message-Id: <1117587003.25017.56.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rqn/vQ+1UrY7gIVF4GpT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-05-31 at 19:41 -0400, Steven Rostedt wrote:
[snip]
> True, but do they really know how good PREEMPT_RT is, compared to those
> that develop it and the kernel?  But I'm fighting to get PREEMPT_RT into
> the kernel, since I really think it would be used by quite a lot in the
> industry.  Just not the normal Desktop user.

I believe that if solid RT was available to the desktop user, it would
be used in many desktop applications.  It would definitely need to be
easy to enable for non-root applications.  Capabilities, SCHED_ISO_*,
rlimits...

Every media playback and recording application would like it.  Games
would love it, especially multi-threaded games. =20

[Stop reading here if you don't like games...]

Right now, a game is a big solid event loop, and it prioritizes by doing
the important things first in the loop, then maybe check the time and
drop something less important if it is taking too long, like skipping a
render frame in order to keep the sound and physics running at a smooth
rate.

But with multi-threaded games, the programmer loses a lot of scheduling
control.  He might like to run a 60Hz render thread, AI thread(s), sound
thread and physics thread, but cannot because he can't guarantee they
will stay in sync.  Everything stops moving if the physics thread gets
interrupted by a low-prio Folding@Home process for 200ms.  Good RT would
fix that, and multi-thread games would be great for multi-cpu,
multi-core, hyper-thread systems.

We should not have to shut down all our background applications to run a
video game (or other high-interactive CPU hogs).  It should run smooth
as glass even with distributed computation or Gentoo system compiles
running in the background.

If you don't believe <10 milliseconds matter to a gamer, you haven't
hung around with obsessive Quake3 players who tweak their mouse rates
over 200Hz, disable frame sync and turn off texture maps and lighting,
all to get that microscopic edge over the opponent.  Tell them about
being able to tweak the mouse and network interrupt priorities and set X
and Quake3 to RT priority.  They'll be all over it.
--=20
Zan Lynx <zlynx@acm.org>

--=-rqn/vQ+1UrY7gIVF4GpT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCnQY7G8fHaOLTWwgRAt+SAJ4kltjI9lq797JbYn9U9xzFXV5yhwCfQuoP
AgGov6nG7IxNC7elz/EY7Qc=
=vMaP
-----END PGP SIGNATURE-----

--=-rqn/vQ+1UrY7gIVF4GpT--


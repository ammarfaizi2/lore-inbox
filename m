Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268422AbTCFVxA>; Thu, 6 Mar 2003 16:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268423AbTCFVxA>; Thu, 6 Mar 2003 16:53:00 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:19942 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S268422AbTCFVw6>; Thu, 6 Mar 2003 16:52:58 -0500
Date: Thu, 6 Mar 2003 23:03:07 +0100
From: Martin Waitz <tali@admingilde.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@digeo.com>, Robert Love <rml@tech9.net>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-ID: <20030306220307.GA1326@admingilde.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Andrew Morton <akpm@digeo.com>, Robert Love <rml@tech9.net>,
	mingo@elte.hu, linux-kernel@vger.kernel.org
References: <20030228202555.4391bf87.akpm@digeo.com> <Pine.LNX.4.44.0303051910380.1429-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303051910380.1429-100000@home.transmeta.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Wed, Mar 05, 2003 at 07:20:34PM -0800, Linus Torvalds wrote:
> How about something more like this (yeah, untested, but you get the idea)=
:=20
> the person who wakes up an interactive task gets the interactivity bonus=
=20
> if the interactive task is already maxed out. I dunno how well this plays=
=20
> with the X server, but assuming most clients use UNIX domain sockets, the=
=20
> wake-ups _should_ be synchronous, so it should work well to say "waker=20
> gets bonus".

i used a similar method to correctly account resource usage
(cpu,energy,..) of processes in my diploma thesis:
work done by a sever (e.g. X) is accounted to the current client,
giving more resources to the server
http://admingilde.org/~martin/papers/

implementation is working but far from being mergeable...




RE: the patch, i think using sleep_avg is a wrong metric from the
beginning.

in addition, timeslices should be shortest for high priority processes
(depending on dynamic prio, not static)

but these are of course just simple statements and i don't have
a patch that makes a really good scheduler :(

--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  [Tali on IRCnet]  [tali.home.pages.de] _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /
			    -
Wer bereit ist, grundlegende Freiheiten aufzugeben, um sich=20
kurzfristige Sicherheit zu verschaffen, der hat weder Freiheit=20
noch Sicherheit verdient.            Benjamin Franklin (1706 - 1790)

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Z8Wbj/Eaxd/oD7IRAhUhAJ45pIxUq6hKfZabbckI09Js9npo5gCeN2n1
nu0YBh8gsp5arD1uNrl0/uI=
=v87b
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--

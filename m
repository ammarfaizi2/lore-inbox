Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWCHVIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWCHVIH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWCHVIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:08:07 -0500
Received: from threatwall.zlynx.org ([199.45.143.218]:50064 "EHLO zlynx.org")
	by vger.kernel.org with ESMTP id S1751175AbWCHVIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:08:05 -0500
Subject: Re: [PATCH] mm: yield during swap prefetching
From: Zan Lynx <zlynx@acm.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: =?ISO-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>,
       Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <cone.1141787137.882268.19235.501@kolivas.org>
References: <200603081013.44678.kernel@kolivas.org>
	 <200603081322.02306.kernel@kolivas.org> <1141784834.767.134.camel@mindpipe>
	 <200603081330.56548.kernel@kolivas.org>
	 <b8bf37780603071852r6bf3821fr7610597a54ad305b@mail.gmail.com>
	 <cone.1141787137.882268.19235.501@kolivas.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JnmW0dYjcbGr0gt5fDM1"
Date: Wed, 08 Mar 2006 14:07:43 -0700
Message-Id: <1141852064.21958.28.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-Envelope-From: zlynx@acm.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JnmW0dYjcbGr0gt5fDM1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-03-08 at 14:05 +1100, Con Kolivas wrote:
> Andr=E9 Goddard Rosa writes:
>=20
> > [...]
> >> > > Because being a serious desktop operating system that we are
> >> > > (bwahahahaha) means the user should not have special privileges to=
 run
> >> > > something as simple as a game. Games should not need special sched=
uling
> >> > > classes. We can always use 'nice' for a compile though. Real time =
audio
> >> > > is a completely different world to this.
> > [...]
> >> Well as I said in my previous reply, games should _not_ need special
> >> scheduling classes. They are not written in a real time smart way and =
they do
> >> not have any realtime constraints or requirements.
> >=20
> > Sorry Con, but I have to disagree with you on this.
> >=20
> > Games are very complex software, involving heavy use of hardware resour=
ces
> > and they also have a lot of time constraints. So, I think they should
> > use RT priorities
> > if it is necessary to get the resources needed in time.
>=20
> Excellent, I've opened the can of worms.
>=20
> Yes, games are a in incredibly complex beast.
>=20
> No they shouldn't need real time scheduling to work well if they are code=
d=20
> properly. However, witness the fact that most of our games are windows=20
> ports, therefore being lower quality than the original. Witness also the=20
> fact that at last with dual core support, lots and lots (but not all) of=20
> windows games on _windows_ are having scheduling trouble and jerky playba=
ck,=20
> forcing them to crappily force binding to one cpu.
[snip]

Games where you notice frame-rate chop because the *disk system* is
using too much CPU are perfect examples of applications that should be
using real-time.

Multiple CPU cores and multithreading in games is another perfect
example of programming that *needs* predictable real-time thread
priorities.  There is no other way to guarantee that physics processing
takes priority over graphics updates or AI, once each task becomes
separated from a monolithic main loop and spread over several CPU cores.

Because games often *are* badly written, a user-friendly Linux gaming
system does need a high-priority real-time task watching for a special
keystroke, like C-A-Del for example, so that it can kill the other
real-time tasks and return to the UI shell.

Games and real-time go together like they were made for each other.
--=20
Zan Lynx <zlynx@acm.org>

--=-JnmW0dYjcbGr0gt5fDM1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBED0efG8fHaOLTWwgRApodAJ9COGrzAcml6M/evrUrk7clMIU9+wCfZF0S
ALgGVbBcrrwS5nRPhSdtdEk=
=s+zF
-----END PGP SIGNATURE-----

--=-JnmW0dYjcbGr0gt5fDM1--


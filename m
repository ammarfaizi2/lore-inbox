Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263558AbTEDIg6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 04:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbTEDIg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 04:36:58 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:20974 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263558AbTEDIg4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 04:36:56 -0400
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: Valdis.Kletnieks@vt.edu, linux@horizon.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0305040301001.6490-100000@rtlab.med.cornell.edu>
References: <Pine.LNX.4.33L2.0305040301001.6490-100000@rtlab.med.cornell.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eHCPjQLbPTQfeGlBhRD6"
Organization: Red Hat, Inc.
Message-Id: <1052038157.1645.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 04 May 2003 10:49:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eHCPjQLbPTQfeGlBhRD6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-05-04 at 09:03, Calin A. Culianu wrote:
> On Sat, 3 May 2003 Valdis.Kletnieks@vt.edu wrote:
>=20
> > On Sat, 03 May 2003 13:19:52 -0000, linux@horizon.com  said:
> >
> > > An interesting question arises: is the number of useful interpreter
> > > functions (system, popen, exec*) sufficiently low that they could be
> > > removed from libc.so entirely and only staticly linked, so processes
> > > that didn't use them wouldn't even have them in their address space,
> > > and ones that did would have them at less predictible addresses?
> > >
> > > Right now, I'm thinking only of functions that end up calling execve(=
);
> > > are there any other sufficiently powerful interpreters hiding in comm=
on
> > > system libraries?  regexec()?
> >
> > This does absolutely nothing to stop an exploit from providing its own
> > inline version of execve().  There's nothing in libc that a process can=
't
> > do itself, inline.
> >
> > A better bet is using an LSM module that prohibits exec() calls from an=
y
> > unauthorized combinations of running program/user/etc.
>=20
> Is that practical?  I can see how with some daemons it would definitely b=
e
> useful to prohibit exec calls (maybe things like BIND don't need to exec
> anything).. but some daemons do need to exec.  An SMTPD may need to exec(=
)
> some helper processes (postfix for instance has a whole slew of helper
> programs it uses).. and things like sshd need to exec a shell, etc..
>=20
> It's still a good idea though, since some daemons don't need to exec,
> ever.  I guess this is one extra layer of protection.  As Ingo said in hi=
s
> announcement, the more layers of protection you have, the better.. and th=
e
> more difficult a cracker's job is.

would be easier to make a CAP_EXEC capability that bind can drop then ;)

--=-eHCPjQLbPTQfeGlBhRD6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+tNQNxULwo51rQBIRAi1sAJ9VPm1wPeERlpUJH1BuBgD62sko/ACaA6ch
D019dfHTV5/9tg4uratjS7E=
=u7Gw
-----END PGP SIGNATURE-----

--=-eHCPjQLbPTQfeGlBhRD6--

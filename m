Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRAWVRQ>; Tue, 23 Jan 2001 16:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129875AbRAWVRF>; Tue, 23 Jan 2001 16:17:05 -0500
Received: from linuxgate.linuxcare.com ([167.216.157.206]:48512 "HELO
	parts-unknown.org") by vger.kernel.org with SMTP id <S129771AbRAWVQy>;
	Tue, 23 Jan 2001 16:16:54 -0500
Date: Tue, 23 Jan 2001 13:16:53 -0800
From: David Benfell <benfell@parts-unknown.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [OT?] Coding Style
Message-ID: <20010123131652.B2356@parts-unknown.org>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3A6D78EA.5B09C379@coppice.org> <Pine.LNX.4.21.0101231716001.1713-100000@the-babel-tower.nobis-crew.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101231716001.1713-100000@the-babel-tower.nobis-crew.org>; from Pixel@the-babel-tower.nobis-crew.org on Tue, Jan 23, 2001 at 05:17:15PM +0100
X-Moon: The Moon is Waning Crescent (3% of Full)
X-stardate: [-30]6079.29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2001 at 05:17:15PM +0100, Nicolas Noble wrote:
>=20
> >     a =3D b + c; /* add a to b, and store it as c */
>=20
> I think *this* comment is very fun, since it make me asking myself if I
> really know the C language :)
>=20
I trust we all got a chuckle out of this one.

I come from an era where obscure code was the rule and we were just
glad to have comments.  So it's a little bit of a wake-up call when I
see the current debate.

There are a couple of memorable points I've seen so far here:

1) Linus points out that if you change the code, it will usually break
the formatting of a trailing comment.

2) A complaint that comments often don't jive with the code.

I think we're missing something here, mainly point #2.  If you're
paying attention to the comments when you're modifying the code, point
#1 becomes a lot less critical because you should also be updating the
comments.

To state what (to me) seems like it must be obvious:

Sometimes solutions to problems are obviously correct.  Sometimes they
aren't so obviously correct (emphasis on obviously).  And, try as you
might, the increased complexity of modern code must surely have led to
new boobytraps.  Comments are appropriate whenever the right solution
is not obviously correct or whenever you're tiptoeing through a
minefield of issues.  They are appropriate whenever and wherever you
choose an efficient solution over one which is "human-readable."
Comments should be mandatory wherever you generate code which might be
misunderstood or when an obvious solution to one problem also happens
to fix something else which is a less obvious.

The argument which was made a while ago, which I think bears repeating
here, is that code serves two purposes:

1) the mechanical process of instructing the machine to do something.
2) to clearly communicate its purpose to any who may come later.

The first point is obvious.  The second leads to lots of arguments on
style.  (So programmers still don't want to type out long variable
names?)

What I would argue for here is the application of common sense.  Write
a piece of code.  Comment it as appropriate.  Then look at it as if
you were attempting to explain it to someone else, not necessarily as
gifted as yourself.  All of your explanation should be there, in
writing in well-formatted comments or in readable code.  Your code has
a purpose (to solve a problem); it often helps to clearly state what
that problem is, then how your code addresses it.

Very often, this explanation takes a lot more space than you can tack
on at the end of a line of code.  In that case, the comments should go
right where Linus says he wants them, in advance of the code you're
documenting, in near-essay form.

The point here is that the communication is the important thing.  In
your haste to just generate that quick fix, you waste time later when
you or someone else tries to unravel what the hell you did.  This is
not a new argument.  I remember hearing it in school 25 years ago (so
you know it must be even older than that).

--=20
David Benfell
benfell@greybeard95a.com
---
The grand leap of the whale up the Fall of Niagara is esteemed, by all
who have seen it, as one of the finest spectacles in nature.
                -- Benjamin Franklin.

				[from fortune]

		=20

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpt9MQACgkQddQOAFMO0suU/QCbB+nOhs0wzJRkaf2IFLLatxY2
CgEAn3cG6a9kF6cLl/p7SKMY6CFM3BWt
=u1RR
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

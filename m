Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbUCXUXQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 15:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbUCXUXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 15:23:16 -0500
Received: from mail.dsvr.co.uk ([212.69.192.8]:58016 "EHLO mail.dsvr.co.uk")
	by vger.kernel.org with ESMTP id S261463AbUCXUXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 15:23:02 -0500
Date: Wed, 24 Mar 2004 20:22:59 +0000
From: Jonathan Sambrook <jonathan.sambrook@dsvr.co.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Message-ID: <20040324202259.GJ20333@jsambrook>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <200403232352.58066.dtor_core@ameritech.net> <20040324102233.GC512@elf.ucw.cz> <200403240748.31837.dtor_core@ameritech.net> <20040324151831.GB25738@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yhze8HlyfmXt1APY"
Content-Disposition: inline
In-Reply-To: <20040324151831.GB25738@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yhze8HlyfmXt1APY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

At 16:18 on Wed 24/03/04, pavel@suse.cz masquerading as 'Pavel Machek' wrot=
e:
> Hi!
>=20
> > > Except when it is not in syslog, because it was after atomic copy or
> > > before atomic copy back. swsusp is pretty unique in this respect.
> > >
> >=20
> > And I would consider an error that happens after atomic copy critical. =
If
> > this happens all attempts to draw progress bar, etc. should be stopped =
and
> > suspend should probably abort as well.
>=20
> Well, not all printks() are errors this hard. And at some points, it
> is no longer possible to abort (after pagedir is on disk, its okay to
> panic (machine will resume normally after that), but its not okay to
> simply return. You could fix signature then return, but it would be hard)=
=2E=20
>=20
> > What happens if swsusp1 gets such an error during atomic phase? Will it
> > continue or abort? If it continues I would imagine user not noticing the
> > message it it flashes the split second before the box powers off.=20
>=20
> It continues. Fortunately powerdown takes enough time on most machines
> that messages can be readed ...=20

> if you pay attetion.

Which is not a normal usage scenario.

Common scenario:

 suspend machine then go home/to bed


 BTW Pavel I'm not arguing that the code has to stay in without
 modification
 (e.g. massively stripped down or whatever). But this is one place where
 kernel code is a lot closer to Joe Enduser's awareness than is usually
 the case, so IMUO, the priorities shift.

 That said, this discussion seems to be necessary to refine what is
 necessary from what has been creatively evolved.

 Jonathan

> 								Pavel
> --=20
> Horseback riding is like software...
> ...vgf orggre jura vgf serr.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
                  =20
 Jonathan Sambrook=20
Software  Developer=20
 Designer  Servers

--yhze8HlyfmXt1APY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAYe4jSUOTbbpGXDwRAr1lAJ9eD+7byjAf+x+U52Y836h8Ga83dwCfaqbL
F9u9Mx1LrySqD8PhE04JRgs=
=MOyM
-----END PGP SIGNATURE-----

--yhze8HlyfmXt1APY--

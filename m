Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUJGOlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUJGOlP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 10:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266308AbUJGOlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 10:41:14 -0400
Received: from lug-owl.de ([195.71.106.12]:57303 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S265697AbUJGOlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 10:41:12 -0400
Date: Thu, 7 Oct 2004 16:41:11 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Message-ID: <20041007144110.GF5033@lug-owl.de>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041005212712.I6910@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zh71TqSqNUxNGGUI"
Content-Disposition: inline
In-Reply-To: <20041005212712.I6910@flint.arm.linux.org.uk>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zh71TqSqNUxNGGUI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-10-05 21:27:12 +0100, Russell King <rmk+lkml@arm.linux.org.uk>
wrote in message <20041005212712.I6910@flint.arm.linux.org.uk>:
> On Tue, Oct 05, 2004 at 08:52:14PM +0200, J=F6rn Engel wrote:
> It's rather annoying because it currently means that, when my PCMCIA net
> interface on the firewall comes up, the IPv4 configuration works fine
> but IPv6 configuration falls dead on its nose without any explaination
> why.
>=20
> And, like I say, redirecting fd0,1,2 fixes it.

I see this at home, too, but here, I use radvd to distribute a working
IPv6 configuration. However, the root cause seems to be different: this
card (some cheap NE2k clone driven by pcnet_cs) seems to ignore the
router advertisements. If I 'ifconfig eth0 promisc' the interface right
after insertion (before the timer for interface IPv6-auto-configutation
expires), it works as expected...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--zh71TqSqNUxNGGUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBZVWGHb1edYOZ4bsRAkNAAKCEfTPAUBOwbMMvrxJPp0Fu763COwCaAgu1
MBkchhLA7Jy8suLxfC0/CE8=
=9Y3t
-----END PGP SIGNATURE-----

--zh71TqSqNUxNGGUI--

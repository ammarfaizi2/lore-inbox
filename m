Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbTJOPFm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 11:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263378AbTJOPFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 11:05:41 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:16600 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263370AbTJOPFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 11:05:31 -0400
Date: Wed, 15 Oct 2003 17:05:30 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Unbloating the kernel, action list
Message-ID: <20031015150530.GJ20846@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <HMQWM7$61FA432C2B793029C11F4F77EEAABD1F@libero.it> <20031014214311.GC933@inwind.it> <16710000.1066170641@flay> <20031014155638.7db76874.cliffw@osdl.org> <20031015124842.GE20846@lug-owl.de> <20031015131015.GR16158@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YGDJTm4HeavG21wE"
Content-Disposition: inline
In-Reply-To: <20031015131015.GR16158@holomorphy.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YGDJTm4HeavG21wE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-10-15 06:10:15 -0700, William Lee Irwin III <wli@holomorphy.co=
m>
wrote in message <20031015131015.GR16158@holomorphy.com>:
> On Wed, Oct 15, 2003 at 02:48:42PM +0200, Jan-Benedict Glaw wrote:
> > I can put on the table:
> > Unfortunately, you need an additional kernel patch because nearly all
> > distros are using mach=3D=3Di486 which gives you nice sigills on an i386
> > otherwise...
>=20
> Can you quantify the performance impact of cmov emulation (or whatever
> it is)? I have a vague notion it could be hard given the daunting task
> of switching userspace around to verify it.

I can't. I'm haven't seen a really noticeable impact, but that doesn't
tell much:) However, there's no other chance than emulating cmov and
locked xchgs. If glibc/libstdc++ would go back, ABI would break and you
couldn't any longer copy programs build within one distribution over to
another.

So I think I'll diff out the patch and send it for review (note: it was
_not_ initially written by me!).

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--YGDJTm4HeavG21wE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/jWI6Hb1edYOZ4bsRAs/0AJ98c0TjDvisIZq8jMcpqUFKZmD4uACffvVC
wJzxdAFH7AshgPlfdajISBQ=
=ZWf+
-----END PGP SIGNATURE-----

--YGDJTm4HeavG21wE--

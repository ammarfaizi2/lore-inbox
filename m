Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751999AbWJJHJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbWJJHJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 03:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWJJHJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 03:09:36 -0400
Received: from lug-owl.de ([195.71.106.12]:27534 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751999AbWJJHJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 03:09:35 -0400
Date: Tue, 10 Oct 2006 09:09:33 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Andrew Morton <akpm@osdl.org>, Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sct@redhat.com, adilger@clusterfs.com, linux-ext4@vger.kernel.org
Subject: Re: 2.6.18-mm2: ext3 BUG?
Message-ID: <20061010070933.GE30283@lug-owl.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Jiri Slaby <jirislaby@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	sct@redhat.com, adilger@clusterfs.com, linux-ext4@vger.kernel.org
References: <45257A6C.3060804@gmail.com> <20061005145042.fd62289a.akpm@osdl.org> <4525925C.6060807@gmail.com> <20061005171428.636c087c.akpm@osdl.org> <20061008063330.GA30283@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VRy2DAmnTueP9XfJ"
Content-Disposition: inline
In-Reply-To: <20061008063330.GA30283@lug-owl.de>
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VRy2DAmnTueP9XfJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-10-08 08:33:30 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de> wr=
ote:
> On Thu, 2006-10-05 17:14:28 -0700, Andrew Morton <akpm@osdl.org> wrote:

> In one case, there was a test case mentioned. I'll run that on my
> affected box in a non-productive LV, like this:
>=20
> dd bs=3D1M count=3D200 if=3D/dev/zero of=3Dtest0
> while :; do
> 	echo "cp 0-1"; cp test0 test1 || break
> 	echo "cp 1-2"; cp test1 test2 || break
> 	echo "cp 2-3"; cp test2 test3 || break
> 	echo "cp 3-4"; cp test3 test4 || break
> 	echo "od 0" ; od test0 || break
> 	echo "rm 1"; rm test1 || break
> 	echo "rm 2"; rm test2 || break
> 	echo "rm 3"; rm test3 || break
> 	echo "rm 4"; rm test4 || break
> done

While I could reproduce it with a 200MB file, it seems I can't break
it with a 10MB file.

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
  Signature of:                        Lauf nicht vor Deinem Gl=C3=BCck dav=
on:
  the second  :                             Es k=C3=B6nnte hinter Dir stehe=
n!

--VRy2DAmnTueP9XfJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFK0ctHb1edYOZ4bsRAqgNAJ9xok1m7sA8N4Tgh0sL5+eqO7VAJQCeNraU
IXd8/BWSa2Fu9c8bHba8l8g=
=hmYk
-----END PGP SIGNATURE-----

--VRy2DAmnTueP9XfJ--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270678AbUJULj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270678AbUJULj4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 07:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269057AbUJULhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 07:37:05 -0400
Received: from ns.schottelius.org ([213.146.113.242]:5002 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S270678AbUJULeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 07:34:08 -0400
Date: Thu, 21 Oct 2004 13:33:47 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Guenter Millahn <Guenter.Millahn@Informatik.TU-Cottbus.DE>,
       Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org,
       jakub@redhat.com
Subject: Re: Linux speed on sun4c
Message-ID: <20041021113347.GO15294@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	"David S. Miller" <davem@redhat.com>,
	Guenter Millahn <Guenter.Millahn@Informatik.TU-Cottbus.DE>,
	Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org,
	jakub@redhat.com
References: <20010630220612.C14361@vitelus.com> <15166.50418.583094.554723@pizda.ninka.net> <20010703175922.A7970@pt.Informatik.TU-Cottbus.DE> <15170.20516.201818.401387@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l3ej7W/Jb2pB3qL2"
Content-Disposition: inline
In-Reply-To: <15170.20516.201818.401387@pizda.ninka.net>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.9cLinux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--l3ej7W/Jb2pB3qL2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Did anybody wrote a patch for that?

Nico

David S. Miller [Tue, Jul 03, 2001 at 04:07:16PM -0700]:
>=20
> Guenter Millahn writes:
>  > David, can you publish your idea for a fix? Possibly anybody elese can=
 make
>  > the patch?
>=20
> Currently under Linux when a constext is recycled because a new
> context is needed but all are in use, we basically toss all of
> the MMU segments that context owned.
>=20
> This is bogus because if the contexts are the limited resource
> not the MMU segments themselves, we take a lot of false MMU
> misses on each context switch for no reason.
>=20
> The solution is to link the MMU segment software state structures
> into the mm_struct.  When an 'mm' reacquires a hw context, if any
> MMU segments remain on the mm's list, just pluck them back into
> the MMU.
>=20
> Later,
> David S. Miller
> davem@redhat.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--l3ej7W/Jb2pB3qL2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQIVAwUBQXeembOTBMvCUbrlAQLTzxAAngiPzA57YfOBHs+FjK8qRsi1IjDFVKnd
k1N0r6wAxDPepKS91O84dkeFm5t2FeiWvCIp5fYboaM/fVE4EsUOdrTLeqQFKSur
zRz1m4LEBqSQgi/DzMRxacjZyzagf8PHOQpd9cYXmRUxVzHt8IzXxaLI9hzhrT2/
dZyWPMtOC8a+sAnA+WC/b3Vw/YxWSNmMrtViR6pwJ8Ep8VBKWixX2h8sSFpTOykv
VF6R21N21mNGK4aV8PEbYo8lSTdJxk9KouTIo+Jwe+6oYRkEsrdsiFbbIyo/PhYU
HNFS/aSHocV/DS2dwtiK8zulmmJhF0kJxvS/RNmetWFSDQfrds388fq0Nd0+zpfF
/z2Q8Mnj41PMDz6XjpHwcRF/qKIu+S0NpUZ6rWXDEmbiB45ZMEKOk8iCRF1fTLud
ebLeahAoYalKPR3jz8GTN5oxcUI6wQFcfUjwF+HUNIXg3k+/4bV//I0jX7I+PP96
dKu51+uGK2Bk7NC9PoLB4eqlSC2DacfO6+DoYSQ03EAvfh+3wPuqspQsaQYRoMNj
IPIzq9M8FncjR0G7W+eZcp1UL074HM3P0iYFtqD4bIlQ8DkwTnPqn0dbEagEGbn1
Y1ZIoafmTn8MX375zlC+j0sr6mwtywZJD7lJ/fARIuiC1PrUQqonAPLzlnkI6H8q
udUpxz3IbYA=
=u5ua
-----END PGP SIGNATURE-----

--l3ej7W/Jb2pB3qL2--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbTHZGXO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 02:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbTHZGXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 02:23:14 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.36.229]:957 "EHLO
	ms-smtp-01.texas.rr.com") by vger.kernel.org with ESMTP
	id S262635AbTHZGXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 02:23:12 -0400
Subject: Re: [OOPS] less /proc/net/igmp
From: Owen Ford <oford@arghblech.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20030826.150331.102449369.yoshfuji@linux-ipv6.org>
References: <20030825163206.GA1340@penguin.penguin>
	 <20030826.150331.102449369.yoshfuji@linux-ipv6.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ybMvwcf5ocIVo1p3LmD1"
Message-Id: <1061878985.3463.2.camel@spider.hotmonkeyporn.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 26 Aug 2003 01:23:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ybMvwcf5ocIVo1p3LmD1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-08-26 at 01:03, YOSHIFUJI Hideaki / =E5=90=89=E8=97=A4=E8=8B=
=B1=E6=98=8E wrote:
> Hello.
>=20
> In article <20030825163206.GA1340@penguin.penguin> (at Mon, 25 Aug 2003 1=
8:32:06 +0200), Marcel Sebek <sebek64@post.cz> says:
>=20
> > This Oops appears on 2.5.74+ kernels (including 2.6.0-test4) when
> > I'm trying to read /proc/net/igmp with 'less', 'cat' displays
> > the file content without oops:
> :
> > [snip]
> >  ...
> > bash# mount /proc
> > bash# cat /proc/net/igmp
> > Idx	Device    : Count Querier	Group    Users Timer	Reporter
> > bash# less /proc/net/igmp
> > Idx	Device    : Count Querier	Group    Users Timer	Reporter
> > bash# ifup -a
> > bash# cat /proc/net/igmp
> > Idx	Device    : Count Querier	Group    Users Timer	Reporter
> > 1	lo        :     0      V2
> > 				010000E0     1 0:FFFA22F0		0
> > bash# less /proc/net/igmp
> > Unable to handle kernel paging request at virtual address 08051be0
> >  printing eip:
> > 08051be0
> > *pde =3D 0fb66067
> > *pfe =3D 00000000
> > Oops: 0004 [#1]
> > CPU:    0
> > EIP:    0073:[<08051be0>]    Not tainted
> > EFLAGS: 00010246
> > EIP is at 0x8051be0
> > eax: 0805fb68   ebx: 00000001   ecx: 00000000   edx: 00000019
> > esi: 08060649   edi: 08057543   ebp: bffffd8c   esp: bfffda50
> > ds: 007b   es: 007b   ss: 007b
> > Process less (pid 20, threadinfo =3D cfab6000 task =3D c13560cd)
> >  <0>Kernel panic: Fatal exception in interrupt
> > In interrupt handler - not syncing
>=20
> I could not reproduce this issue.  anyone?

I can confirm. I have it with 2.6.0-test4.

Let me know what useful info I can provide.  The oops is the same.

--=20
Owen Ford <oford@arghblech.com>

--=-ybMvwcf5ocIVo1p3LmD1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/SvzJ4bjUYpnk5/QRAi2GAJ9EGzA7p+6L6nNm5zqwj5FzxsAbbgCgrE8F
rLZRH4wydMudYix9lCA4bQg=
=MN0v
-----END PGP SIGNATURE-----

--=-ybMvwcf5ocIVo1p3LmD1--


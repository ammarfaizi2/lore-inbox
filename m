Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267528AbTA3P5F>; Thu, 30 Jan 2003 10:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267532AbTA3P5E>; Thu, 30 Jan 2003 10:57:04 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:44809 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S267528AbTA3P5C>; Thu, 30 Jan 2003 10:57:02 -0500
Date: Thu, 30 Jan 2003 17:06:19 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: "Pocrovsky, Lev" <LPocrovsky@analogic.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: .align help
Message-ID: <20030130160618.GA6588@arthur.ubicom.tudelft.nl>
References: <61C1E83D9DA9D311A871009027D617F0017DE6A1@PEAEXCH1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <61C1E83D9DA9D311A871009027D617F0017DE6A1@PEAEXCH1>
User-Agent: Mutt/1.4i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2003 at 11:53:22AM -0500, Pocrovsky, Lev wrote:
> I am building up a library using xmm and mmx registers in Linux environme=
nt.
> At the begin of this activity I was given a sample routine,  which contai=
ns
> a line
>=20
> .align   16
>=20
> in a text segment.
> As far as I can understand the line of the sort does not have any sense a=
nd
> GCC-compiler must ignore it. Nevertheless I noticed by running test progr=
ams
> that unpredictably some times the line does impact on execution time,
> sometimes it does not.
>=20
> Any explanation ?

The .align directive aligns the next code (or data, depending on the
use) to the value following the directive. How it is interpreted
depends on the target architecture and ABI. For more information, check
the "as" info pages. (hint: tkinfo and pinfo are considered better info
browses than GNU info).

The impact on execution time is quite normal: modern CPUs like (and
most RISC CPUs even demand) aligned memory accesses, so I bet .align 16
would at least make the execution time the consistent. Non-aligned
memory accesses on the i386 family make that the CPU has to fix them
up, which costs time.


Erik

--=20
J.A.K. (Erik) Mouw
Email: J.A.K.Mouw@its.tudelft.nl  mouw@nl.linux.org
WWW: http://www-ict.its.tudelft.nl/~erik/

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+OU16/PlVHJtIto0RAr0cAJ9qjb6R4lZJuQQaJh2V9FlAqwuU9gCggccP
VBvyprItiiHRecGK8PXJBwQ=
=o66J
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

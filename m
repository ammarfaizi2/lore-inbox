Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268501AbUIXF5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268501AbUIXF5g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 01:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268526AbUIXFyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 01:54:23 -0400
Received: from zeus.kernel.org ([204.152.189.113]:50824 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S268501AbUIXFsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 01:48:50 -0400
Date: Fri, 24 Sep 2004 01:48:44 -0400
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
       Andrew Morton <akpm@osdl.org>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [1/1] connector: Kernel connector - userspace <-> kernelspace "linker".
Message-ID: <20040924054844.GO30131@ruslug.rutgers.edu>
Mail-Followup-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
	Andrew Morton <akpm@osdl.org>, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <1095331899.18219.58.camel@uganda> <20040921124623.GA6942@uganda.factory.vocord.ru> <20040924000739.112f07dd@zanzibar.2ka.mipt.ru> <20040923215447.GD30131@ruslug.rutgers.edu> <1095997232.17587.8.camel@uganda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kr14OxHsRwZHHqxS"
Content-Disposition: inline
In-Reply-To: <1095997232.17587.8.camel@uganda>
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kr14OxHsRwZHHqxS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 24, 2004 at 07:40:32AM +0400, Evgeniy Polyakov wrote:
> On Fri, 2004-09-24 at 01:54, Luis R. Rodriguez wrote:
> > RFC:=20
> >=20
> > Can and should we work towards using this as interface for drivers that
> > need callbacks from an external (closed source) library/HAL?
>=20
> As I mentioned to Richard Jonson, it can be considered as
> ioctl. ioctl-ng!
> Unified interface (as ioctl) can be used for any type of modules.
> It is just a bit extended ioctl :)
>=20
> And _yes_, it can be used to turn on/off binary-only callbacks.
> Remember pwc - closed part can register callback and open part can
> send message, or even closed part can register notification when
> open part registers itself and begin to "trash the kernel".
>=20
> I understand that it is not right way to include it is into the kernel,
> but I personally do not understand how it is different=20
> from just extended ioctl. It was designed to be usefull and convenient,
> and it is.
>=20
> BTW, any binary-only module can _itself_ create netlink socket
> with input callback. And that is all - it will be absolutely
> the same as above.
>=20
> One may consider connector as yet-another-netlink-helper.
>=20

Eh. I'm just wondering if there's any *right* way of using binary
callbacks on a linux driver so that it doesn't *taint* and possibly
*trash it*, as you said. I was wondering if perhaps through the
connector we could somehow protect the kernel of possibly ill-behaved callb=
acks.

Comments?

	Luis

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--kr14OxHsRwZHHqxS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBU7U7at1JN+IKUl4RAmPrAJ9wEi5xKV+97H/viSOrxyda89l6yACgmRZr
3ilj8b4TnhHMG0xOeASvblk=
=YK7d
-----END PGP SIGNATURE-----

--kr14OxHsRwZHHqxS--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267767AbUIXDnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267767AbUIXDnl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266878AbUIXDmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 23:42:21 -0400
Received: from dea.vocord.ru ([217.67.177.50]:20451 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S267666AbUIXDfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 23:35:46 -0400
Subject: Re: [1/1] connector: Kernel connector - userspace <-> kernelspace
	"linker".
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
Cc: Andrew Morton <akpm@osdl.org>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040923215447.GD30131@ruslug.rutgers.edu>
References: <1095331899.18219.58.camel@uganda>
	 <20040921124623.GA6942@uganda.factory.vocord.ru>
	 <20040924000739.112f07dd@zanzibar.2ka.mipt.ru>
	 <20040923215447.GD30131@ruslug.rutgers.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8fpkCBNjFfMFdPaA8Oer"
Organization: MIPT
Message-Id: <1095997232.17587.8.camel@uganda>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Sep 2004 07:40:32 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8fpkCBNjFfMFdPaA8Oer
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-09-24 at 01:54, Luis R. Rodriguez wrote:
> RFC:=20
>=20
> Can and should we work towards using this as interface for drivers that
> need callbacks from an external (closed source) library/HAL?

As I mentioned to Richard Jonson, it can be considered as
ioctl. ioctl-ng!
Unified interface (as ioctl) can be used for any type of modules.
It is just a bit extended ioctl :)

And _yes_, it can be used to turn on/off binary-only callbacks.
Remember pwc - closed part can register callback and open part can
send message, or even closed part can register notification when
open part registers itself and begin to "trash the kernel".

I understand that it is not right way to include it is into the kernel,
but I personally do not understand how it is different=20
from just extended ioctl. It was designed to be usefull and convenient,
and it is.

BTW, any binary-only module can _itself_ create netlink socket
with input callback. And that is all - it will be absolutely
the same as above.

One may consider connector as yet-another-netlink-helper.

--=20
	Evgeniy Polyakov

Crash is better than data corruption. -- Art Grabowski

--=-8fpkCBNjFfMFdPaA8Oer
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBU5cwIKTPhE+8wY0RArB9AJ9BVtouc/+Y4NtRR36frbG5W/k/gACeKd9o
Va1gj+T3Fd5AXJOAOMWsLpU=
=mKmD
-----END PGP SIGNATURE-----

--=-8fpkCBNjFfMFdPaA8Oer--


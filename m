Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267747AbUG3RQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267747AbUG3RQj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 13:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267749AbUG3RQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 13:16:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38291 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267754AbUG3RQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 13:16:10 -0400
Date: Fri, 30 Jul 2004 18:16:06 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Gigabit Ethernet support for forcedeth
Message-ID: <20040730171606.GE8175@redhat.com>
References: <20040730100421.GB8175@redhat.com> <410A4A1C.4040608@colorfullife.com> <20040730162023.GD8175@redhat.com> <410A7CBF.2020708@colorfullife.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c/lwuELUGxxkaMpf"
Content-Disposition: inline
In-Reply-To: <410A7CBF.2020708@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--c/lwuELUGxxkaMpf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 30, 2004 at 06:52:15PM +0200, Manfred Spraul wrote:

> The log is very odd - why are there two lines with
>=20
> >forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.28.
>=20
> Did you rmmod/insmod the driver twice?

I think it's just the way that ifup works.  I'm not entirely sure why
the line appears twice.

> Could you manually insmod the driver, wait for two seconds and then call=
=20
> ifup?

Aha.  That works fine.

So here is how to make it fail:

/sbin/modprobe forcedeth; \
/sbin/ip link set dev eth0 up

All subsequent runs of 'ethtool eth0' show:

Settings for eth0:
        Supports Wake-on: g
        Wake-on: d
        Link detected: no

regardless of how long I leave it.

So is this a driver problem or a problem with the way /sbin/ifup
works?

Tim.
*/

--c/lwuELUGxxkaMpf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBCoJV9gevn0C09XYRAiW0AJ4wnmoWfExAvoWC8Tfh47tXVuCqygCdEnbv
wVk/pMl5GZ/ShO9mVGo3SIw=
=RDLw
-----END PGP SIGNATURE-----

--c/lwuELUGxxkaMpf--

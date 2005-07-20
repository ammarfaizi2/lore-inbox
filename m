Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVGTLwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVGTLwV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 07:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVGTLwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 07:52:21 -0400
Received: from smtp1.pp.htv.fi ([213.243.153.37]:8392 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261177AbVGTLwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 07:52:19 -0400
Date: Wed, 20 Jul 2005 14:52:18 +0300
From: Paul Mundt <lethal@linux-sh.org>
To: snogglethorpe@gmail.com, miles@gnu.org
Cc: Jan Dittmer <jdittmer@ppp0.net>, linux-kernel@vger.kernel.org
Subject: Re: defconfig for v850, please
Message-ID: <20050720115218.GB9754@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	snogglethorpe@gmail.com, miles@gnu.org,
	Jan Dittmer <jdittmer@ppp0.net>, linux-kernel@vger.kernel.org
References: <42DE17DC.7050506@ppp0.net> <fc339e4a05072002355e4062d6@mail.gmail.com> <42DE1DDE.90503@ppp0.net> <fc339e4a0507200302d9f0141@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <fc339e4a0507200302d9f0141@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 20, 2005 at 07:02:53PM +0900, Miles Bader wrote:
> Some archs seem to provide defconfigs for various different platforms,
> which seems nice, and there seems to be some sort of framework for
> doing this, but ...
>=20
For most of the architectures aimed at embedded systems, having an
arch/foo/defconfig makes no sense. The basic "framework" is to have
arch/foo/configs and place all of your board-specific defconfigs in there
(as boardname_defconfig -- the reason for this is that you get free make
targets of the same name which copy the defconfig over, see 'make help').

If you have a particular board that you can assume will be kept
reasonably up-to-date, you can set KBUILD_DEFCONFIG in your Makefile to
set the default config to use by name, and then you can forego having an
arch/foo/defconfig entirely (you can look at sh and some of the other
architectures to see this being done).

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFC3jry1K+teJFxZ9wRAmdPAKCFZn9bvowII9fCq1yvBI3h2zlD3wCfdnBe
04TnWkhhZe4nwQiuAIFH4Y4=
=+R63
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266237AbUFYJ0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266237AbUFYJ0c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 05:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266255AbUFYJ0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 05:26:32 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:32677 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S266237AbUFYJ0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 05:26:13 -0400
Date: Fri, 25 Jun 2004 11:25:57 +0200
From: Martin Waitz <tali@admingilde.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mariusz Mazur <mmazur@kernel.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.7.0
Message-ID: <20040625092557.GG27805@admingilde.org>
Mail-Followup-To: Krzysztof Halasa <khc@pm.waw.pl>,
	Jeff Garzik <jgarzik@pobox.com>, Mariusz Mazur <mmazur@kernel.pl>,
	linux-kernel@vger.kernel.org
References: <200406240020.39735.mmazur@kernel.pl> <40DA0F7D.60606@pobox.com> <m3n02s9a9f.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gTtJ75FAzB1T2CN6"
Content-Disposition: inline
In-Reply-To: <m3n02s9a9f.fsf@defiant.pm.waw.pl>
User-Agent: Mutt/1.3.28i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gTtJ75FAzB1T2CN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Thu, Jun 24, 2004 at 06:43:56PM +0200, Krzysztof Halasa wrote:
> > HPA suggested include/abi and I don't think anyone objected.

well, include/abi looks very generic. For userspace code, I really
like to have 'linux' in the include file name, so that it's clear that
some linux-specific header is being used.

> /usr/include/abi -> linux/include/abi
> /usr/include/linux -> abi (obsolete, to be removed with 2.8)
> Appropriate $ARCH + generic dirs (names?).

what about keeping /usr/include/linux for the userspace visible part
of the linux headers and using a new name for the internal headers.
That way we don't have to change userspace applications and can
do all modifications in the kernel tree at the time we want.

For example:

 * mkdir include/kernel (plus arch-specific versions)
 * add placeholer files that simply #include the old include/linux file
 * start replacing in-kernel #includes with the include/kernel version.
 * move the #ifdef __KERNEL__ parts from include/linux to include/kernel

This can be done incrementally, too.

--=20
Martin Waitz

--gTtJ75FAzB1T2CN6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA2++kj/Eaxd/oD7IRAh0sAJoDj4ubGaN1sl++jYUBUKK9Z0VLGwCghCEc
HpH42yD8YWLgzQoL2EZSnDM=
=q5v5
-----END PGP SIGNATURE-----

--gTtJ75FAzB1T2CN6--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVBFMJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVBFMJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 07:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVBFMJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 07:09:28 -0500
Received: from natjimbo.rzone.de ([81.169.145.162]:58550 "EHLO
	natjimbo.rzone.de") by vger.kernel.org with ESMTP id S261340AbVBFMIS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 07:08:18 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] PPC/PPC64: Abstract cpu_feature checks.
Date: Sun, 6 Feb 2005 12:57:34 +0100
User-Agent: KMail/1.6.2
Cc: olof@austin.ibm.com (Olof Johansson), linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, trini@kernel.crashing.org,
       paulus@samba.org, anton@samba.org, hpa@zytor.com
References: <20050204072254.GA17565@austin.ibm.com> <20050205184647.GA17417@austin.ibm.com> <20050206032645.GA18845@austin.ibm.com>
In-Reply-To: <20050206032645.GA18845@austin.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_0YgBCOfG9h2gYcV";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200502061257.40798.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_0YgBCOfG9h2gYcV
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On S=FCnndag 06 Februar 2005 04:26, Olof Johansson wrote:
>=20
> Abstract most manual mask checks of cpu_features with cpu_has_feature()
> =A0
Just to get back to the point of consistant naming: In case we do the
other proposed changes as well, is everyone happy with the following
function names?

cpu_has_feature(CPU_FTR_X)	cur_cpu_spec->cpu_features & CPU_FTR_X
cpu_feature_possible(CPU_FTR_X)	CPU_FTR_POSSIBLE_MASK & CPU_FTR_X

fw_has_feature(FW_FEATURE_X)	cur_cpu_spec->fw_features & FW_FTR_X

platform_is(PLATFORM_X)		systemcfg->platform =3D=3D PLATFORM_X
platform_possible(PLATFORM_X)	PLATFORM_POSSIBLE_MASK & PLATFORM_X
platform_compatible(PLATFORM_X)	systemcfg->platform & PLATFORM_X


It's not as consistant as I'd like it to be, but it's the best I could
come up with.

	Arnd <><

--Boundary-02=_0YgBCOfG9h2gYcV
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCBgY05t5GS2LDRf4RAnO4AJ4xhr2vU8CdfRIqHoy+BndYSudGkwCfe/fA
bBX9FXaAJz2WLOEbGGzGyyM=
=dfoX
-----END PGP SIGNATURE-----

--Boundary-02=_0YgBCOfG9h2gYcV--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932587AbWASJTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbWASJTE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWASJTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:19:03 -0500
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:11700 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932575AbWASJTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:19:01 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Chase Venters <chase.venters@clientec.com>
Subject: Re: scsi cmd slab leak? (Was Re: [ck] Anyone been having OOM killer problems lately?)
Date: Thu, 19 Jan 2006 20:18:49 +1100
User-Agent: KMail/1.9
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
References: <200601181951.16708.chase.venters@clientec.com> <200601191849.45002.kernel@kolivas.org> <200601190316.05247.chase.venters@clientec.com>
In-Reply-To: <200601190316.05247.chase.venters@clientec.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1288584.PIYjHUxP9e";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601192018.51972.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1288584.PIYjHUxP9e
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 19 January 2006 20:15, Chase Venters wrote:
> On Thursday 19 January 2006 01:49, Con Kolivas wrote:
> > > 	Do I have something madly leaking in my kernel?
> >
> > Yes! post /proc/slabinfo
>
> (attached). Looks like quite a few scsi commands! Next steps?
>
> > Con
>
> Thanks!
> Chase

Inded it does
scsi_cmd_cache    1547440 1547440    384   10    1 : tunables   54   27    =
8 :=20
slabdata 154744 154744      0

This looks suspiciously large. To be absolutely certain, though, you have t=
o=20
reproduce the problem with a vanilla kernel, and no binary drivers anywhere=
=2E=20
My patches don't touch the scsi code directly, but the only way to be certa=
in=20
is to use vanilla.

Cheers,
Con

--nextPart1288584.PIYjHUxP9e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDz1l7ZUg7+tp6mRURAqBzAJ9E3DGJNrfEKk4VApggwzhsH0pORgCbBsQi
JAnniCCVE0ZXO7mB+kBY77c=
=i8a5
-----END PGP SIGNATURE-----

--nextPart1288584.PIYjHUxP9e--

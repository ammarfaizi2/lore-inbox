Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbULFW7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbULFW7n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 17:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbULFW7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 17:59:43 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:20713 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261469AbULFW7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 17:59:36 -0500
Date: Tue, 7 Dec 2004 00:59:34 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARCH_SLAB_MINALIGN for 2.6.10-rc3
Message-ID: <20041206225934.GA30317@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Manfred Spraul <manfred@colorfullife.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41B37E06.3030702@colorfullife.com> <20041205222001.GB25689@linux-sh.org> <41B4D9F8.6000309@colorfullife.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <41B4D9F8.6000309@colorfullife.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Manfred,

On Mon, Dec 06, 2004 at 11:15:20PM +0100, Manfred Spraul wrote:
> With your patch, ARCH_SLAB_MINALIGN is not a hard limit: A few lines=20
> further down align is reset to word size if SLAB_RED_ZONE is set. I=20
> don't like the asymmetry - it just asks for trouble.
>=20
Yes, that's true. I don't see much of a point in leaving it as
BYTES_PER_WORD in the SLAB_RED_ZONE case, at least this wasn't
intentional. Would you accept ARCH_SLAB_MINALIGN if this was set
regardless of whether SLAB_RED_ZONE is set or not?

I suppose we can live with align being 0 in the CONFIG_DEBUG_SLAB
case as the unaligned accesses are not fatal..

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBtORW1K+teJFxZ9wRAsE9AJ9IPegK1s36XoI9KZS441eeQhb1sQCfZqPy
fFBCEIn1o6hXnFd9iHMKuhs=
=r3Vn
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

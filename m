Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVDCMFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVDCMFY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 08:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVDCMFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 08:05:24 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:53396 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261702AbVDCMFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 08:05:17 -0400
Date: Sun, 3 Apr 2005 22:05:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dag Arne Osvik <da@osvik.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Use of C99 int types
Message-Id: <20050403220508.712e14ec.sfr@canb.auug.org.au>
In-Reply-To: <424FD9BB.7040100@osvik.no>
References: <424FD9BB.7040100@osvik.no>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__3_Apr_2005_22_05_08_+1000_Wh=7.0P_hXMToPD."
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__3_Apr_2005_22_05_08_+1000_Wh=7.0P_hXMToPD.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 03 Apr 2005 13:55:39 +0200 Dag Arne Osvik <da@osvik.no> wrote:
>
> I've been working on a new DES implementation for Linux, and ran into
> the problem of how to get access to C99 types like uint_fast32_t for
> internal (not interface) use.  In my tests, key setup on Athlon 64 slows
> down by 40% when using u32 instead of uint_fast32_t.

If you look in stdint.h you may find that uint_fast32_t is actually
64 bits on Athlon 64 ... so does it help if you use u64?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__3_Apr_2005_22_05_08_+1000_Wh=7.0P_hXMToPD.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCT9v54CJfqux9a+8RAnMHAJ4sehVoqc2jEAzNvw1aLGaEM+wraQCcDALv
IKRQ35mOfxq9aKNoNjaPFJY=
=eAAp
-----END PGP SIGNATURE-----

--Signature=_Sun__3_Apr_2005_22_05_08_+1000_Wh=7.0P_hXMToPD.--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWFJLDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWFJLDn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 07:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWFJLDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 07:03:43 -0400
Received: from nsm.pl ([195.34.211.229]:17947 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1750954AbWFJLDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 07:03:42 -0400
Date: Sat, 10 Jun 2006 13:03:36 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
Message-ID: <20060610110335.GA7959@irc.pl>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org
References: <E1Foqjw-00010e-Ln@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <E1Foqjw-00010e-Ln@candygram.thunk.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2006 at 07:50:08PM -0400, Theodore Ts'o wrote:
> So without further ado, here are some ideas of ways that we can slim
> down struct inode:
>=20
> 1) Move i_blksize (optimal size for I/O, reported by the stat system
>    call).  Is there any reason why this needs to be per-inode, instead
>    of per-filesystem?
>=20
> 2) Move i_blkbits (blocksize for doing direct I/O in bits) to struct
>    super.  Again, why is this per-inode?

  ZFS filesystem uses dynamic, per-file blocksizes. Some Linux
filesystem may implement something like this in order to be called
"modern".

--=20
Tomasz Torcz                 "God, root, what's the difference?"
zdzichu@irc.-nie.spam-.pl         "God is more forgiving."


--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFEiqcHThhlKowQALQRAlIcAJ0cCVLpFnO/fsdrX58of3tzqnYCLACdE1RJ
3n9K1WOGLjDhde0qpd3GqUA=
=3Yx0
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--

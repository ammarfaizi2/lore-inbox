Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132517AbRDUHE6>; Sat, 21 Apr 2001 03:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132520AbRDUHEt>; Sat, 21 Apr 2001 03:04:49 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:28935
	"HELO gw.goop.org") by vger.kernel.org with SMTP id <S132517AbRDUHEm>;
	Sat, 21 Apr 2001 03:04:42 -0400
Date: Sat, 21 Apr 2001 00:04:40 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>, autofs@linux.kernel.org
Subject: Re: Fix for SMP deadlock in autofs4
Message-ID: <20010421000439.B14074@goop.org>
Mail-Followup-To: Jeremy Fitzhardinge <jeremy@goop.org>,
	Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	autofs@linux.kernel.org
In-Reply-To: <Pine.LNX.4.31.0104202253010.15553-100000@penguin.transmeta.com> <Pine.GSO.4.21.0104210217000.23618-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0104210217000.23618-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Apr 21, 2001 at 02:21:38AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 21, 2001 at 02:21:38AM -0400, Alexander Viro wrote:
> Looks sane for me. However, I would add check for dentry being hashed and
> would skip the unhashed ones. Otherwise you can get a directory that
> had been removed but is still busy - doesn't look like a right thing to
> do. Jeremy?

It wouldn't hurt.  It can't happen in practice since unlink/rmdir happen
in very controlled ways (only the automount daemon is allowed to perform
those ops, so it will keep them in sync).

	J

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjrhMQcACgkQf6p1nWJ6IgKPmACdEcXgEmM5o0F6/AnNUkl0JYQD
uQQAn2SzFrovzBAPLhjo3KTe0vgOKRgl
=1Ywc
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--

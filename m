Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266986AbTBCTIi>; Mon, 3 Feb 2003 14:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266989AbTBCTIi>; Mon, 3 Feb 2003 14:08:38 -0500
Received: from splat.lanl.gov ([128.165.17.254]:17572 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S266986AbTBCTIe>; Mon, 3 Feb 2003 14:08:34 -0500
Date: Mon, 3 Feb 2003 12:18:06 -0700
From: Eric Weigle <ehw@lanl.gov>
To: Ben Greear <greearb@candelatech.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: problems achieving decent throughput with latency.
Message-ID: <20030203191806.GN3250@lanl.gov>
References: <200302031611.h13GBl9D019119@darkstar.example.net> <3E3EAF04.9010308@candelatech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OGLMwEELQbPC02lM"
Content-Disposition: inline
In-Reply-To: <3E3EAF04.9010308@candelatech.com>
User-Agent: Mutt/1.4i
X-Eric-Conspiracy: There is no conspiracy
X-Editor: Vim, http://www.vim.org
X-GnuPG-fingerprint: 112E F8CA 12A9 771E DB10  6514 D4B0 D758 59EA 9C4F
X-GnuPG-key: http://public.lanl.gov/ehw/ehw.gpg.key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OGLMwEELQbPC02lM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

You might want to have a look at
	http://www.psc.edu/networking/perf_tune.html
It's a pretty good reference on TCP tuning.

Also, one gotcha: in earlier versions of 2.4 the window scaling factor was
set using the DEFAULT window size instead of the MAXIMUM window size; that
is, window scaling is set such that neither autotuning nor application level
tuning can actually tune to the maximum size (it can't be represented with
the default window scale factor). I don't think this has been fixed yet,
so you may have to set your default to be the same as your maximum for test=
s.


-Eric

--=20
------------------------------------------------------------
        Eric H. Weigle -- http://public.lanl.gov/ehw/
"They that can give up essential liberty to obtain a little
temporary safety deserve neither" -- Benjamin Franklin
------------------------------------------------------------

--OGLMwEELQbPC02lM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+PsBu1LDXWFnqnE8RAoJUAJ0VhGgUQT6JGmr2KRXHYGtIGg492wCg8AF5
QDQJSmwZl081OmY3913tu8k=
=GETi
-----END PGP SIGNATURE-----

--OGLMwEELQbPC02lM--

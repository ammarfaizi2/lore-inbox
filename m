Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265247AbSJaRFK>; Thu, 31 Oct 2002 12:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265248AbSJaRFJ>; Thu, 31 Oct 2002 12:05:09 -0500
Received: from relay.snowman.net ([63.80.4.38]:36357 "EHLO relay.snowman.net")
	by vger.kernel.org with ESMTP id <S265247AbSJaRFC>;
	Thu, 31 Oct 2002 12:05:02 -0500
Date: Thu, 31 Oct 2002 12:11:15 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: Stephen Wille Padnos <stephen.willepadnos@verizon.net>,
       Dax Kelson <dax@gurulabs.com>, Chris Wedgwood <cw@f00f.org>,
       Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: What's left over.
Message-ID: <20021031171115.GT15886@ns>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Stephen Wille Padnos <stephen.willepadnos@verizon.net>,
	Dax Kelson <dax@gurulabs.com>, Chris Wedgwood <cw@f00f.org>,
	Rik van Riel <riel@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <3DC15931.9030601@verizon.net> <Pine.GSO.4.21.0210311126450.16688-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yoeRfslQKq6hDqSj"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0210311126450.16688-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.4i
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 12:06:51 up 88 days, 19:42, 12 users,  load average: 0.01, 0.04, 0.06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yoeRfslQKq6hDqSj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Alexander Viro (viro@math.psu.edu) wrote:
> On Thu, 31 Oct 2002, Stephen Wille Padnos wrote:
> > Unless I'm missing something, that only works if all the users need=20
> > *exactly* the same permissions to all files, which isn't a good assumpt=
ion.
>=20
> That's the point.  In practice shared writable access to a directory can =
be
> easily elevated to full control of each others' accounts, since most of
> userland code is written in implicit assumption that nothing bad happens =
with
> directory structure under it.  And there is nothing kernel can do about t=
hat -
> attacker does action you had explicitly allowed and your program goes bon=
kers
> since it can't cope with that.  Mechanism used to allow that action doesn=
't
> enter the picture - be it ACLs, groups or something else.

So you're not really arguing against ACLs, you're complaining that
userspace is broken when there's shared write access.  That's fine,
userspace should be fixed, inclusion of ACLs into the kernel shouldn't
be denied because of this.  ACLs should be optional, of course, and if
you want them some really noisy warnings about the problems of shared
writeable area with current userspace tools.  Of course, that same
warning should probably be included in 'groupadd'.

	Stephen

--yoeRfslQKq6hDqSj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9wWQyrzgMPqB3kigRAq8WAJ9vekJgZ9HL87pm7j+VWsE70gNP9gCffZZj
G1sZLSUr25RjUngTru7Le8k=
=zS9h
-----END PGP SIGNATURE-----

--yoeRfslQKq6hDqSj--

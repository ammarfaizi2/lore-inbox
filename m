Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288614AbSATOXi>; Sun, 20 Jan 2002 09:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288623AbSATOX3>; Sun, 20 Jan 2002 09:23:29 -0500
Received: from i1582.vwr.wanadoo.nl ([194.134.214.53]:29316 "HELO
	localhost.localnet") by vger.kernel.org with SMTP
	id <S288614AbSATOXK>; Sun, 20 Jan 2002 09:23:10 -0500
Date: Sun, 20 Jan 2002 15:23:59 +0100
From: Remi Turk <remi@abcweb.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors
Message-ID: <20020120152359.B326@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain> <Pine.LNX.3.95.1020118163838.3008B-100000@chaos.analogic.com> <a2afsg$73g$2@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <a2afsg$73g$2@ncc1701.cistron.net>; from miquels@cistron.nl on Sat, Jan 19, 2002 at 12:50:24AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 19, 2002 at 12:50:24AM +0000, Miquel van Smoorenburg wrote:
> There is no way to recreate a file with a nlink count of 0,
> well that is until someone adds flink(fd, newpath) to the kernel.
Which I actually posted a patch for in 2.4.0-test1 time :)

% ll -i old
32619 -rw-r--r--   1 remi     users          14 Jul 31 15:44 old
% exec 5<old
% rm old
% ~/src/flink/flink 5 new
% ll -i new
32619 -rw-r--r--   1 remi     users          14 Jul 31 15:44 new

The more interesting part - open(O_ANONYMOUS) or something like
that looked much harder to do. (IOW, I gave up ;) )

Happy hacking

	Remi

--=20
See the light and feel my warm desire,
Run through your veins like the evening sun
It will live but no eyes will see it,
I'll bless your name before I die.

Key fingerprint =3D CC90 A1BA CF6D 891C 5B88  C543 6C5F C469 8F20 70F4

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8StL/bF/EaY8gcPQRAkFBAJ9CAO05J+sVLkjw/A+NFXHOPE0VqwCePVJC
hgpr9ATESkMHB4Lih38OE5g=
=3Byt
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--

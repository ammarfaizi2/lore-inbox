Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129029AbQKIPwC>; Thu, 9 Nov 2000 10:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129040AbQKIPvx>; Thu, 9 Nov 2000 10:51:53 -0500
Received: from airbus.mayn.de ([194.145.150.13]:30260 "HELO mayn.de")
	by vger.kernel.org with SMTP id <S129029AbQKIPvg>;
	Thu, 9 Nov 2000 10:51:36 -0500
Date: Thu, 9 Nov 2000 16:49:00 +0100
From: Thomas Köhler <jean-luc@picard.franken.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.2.17 bug found
Message-ID: <20001109164900.A3505@picard.franken.de>
Mail-Followup-To: Thomas Köhler <jean-luc@picard.franken.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.91.1001109171915.5142B-100000@aries>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.91.1001109171915.5142B-100000@aries>; from 1997s112@educ.disi.unige.it on Thu, Nov 09, 2000 at 05:20:22PM +0200
X-Operating-System: Linux picard 2.2.17
X-Editor: VIM - Vi IMproved 6.0l ALPHA http://www.vim.org/
X-IRC: tirc; Nick: jeanluc
X-URL: http://jeanluc-picard.de/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2000 at 05:20:22PM +0200,
Andrea Pintori <1997s112@educ.disi.unige.it> wrote:
>=20
> I've a Debian dist, Kernel 2.2.17, no patches, all packages are stable.

I've Debian unstable, Kernel 2.2.17

> here what I found:
>=20
> [/tmp] mkdir old
> [/tmp] chdir old
> [/tmp/old] mv . ../new
> [/tmp/old]                    (should be /tmp/new !!)

Uhm, no. $PWD only gets updated on cd, not on mv. Thus, the old value is
OK!

> [/tmp/old] mkdir fff
> error: cannot write...
> [tmp/old] ls > fff
> error: cannot write...

This seems wrong. But I'd rather say this is a bug in your shell, not in
the kernel!

/tmp> mkdir old
/tmp> cd old=20
/tmp/old> mv . ../new
/tmp/old> mkdir fff
/tmp/old> ls -al=20
total 12
drwxr-xr-x    3 jean-luc jean-luc     4096 Nov  9 16:46 .
drwxrwxrwt    8 root     root         4096 Nov  9 16:46 ..
drwxr-xr-x    2 jean-luc jean-luc     4096 Nov  9 16:46 fff
/tmp/old> cd ../new
/tmp/new> ls -al
total 12
drwxr-xr-x    3 jean-luc jean-luc     4096 Nov  9 16:46 .
drwxrwxrwt    8 root     root         4096 Nov  9 16:46 ..
drwxr-xr-x    2 jean-luc jean-luc     4096 Nov  9 16:46 fff

Works for both bash-2.04 and zsh-3.1.9-dev7 (as in Debian unstable).

> Does anybody knew this bug?

Well, I can't even reproduce it ;)

Ciao,
Thomas

--=20
 Thomas K=F6hler Email:   jean-luc@picard.franken.de     | LCARS - Linux
     <><        WWW:     http://jeanluc-picard.de      | for Computers
                IRC:             jeanluc               | on All Real
               PGP public key available from Homepage! | Starships

--DocE+STaALJfprDB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6CsdsTEYXWMJlHuYRAiplAKCU7a4L5vMc40H5eTNfy3tA7vFgqQCfTJs7
XPKkXL5T1ZKjvM1JbRUO170=
=5ueK
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

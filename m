Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129613AbRCAOmM>; Thu, 1 Mar 2001 09:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129612AbRCAOmE>; Thu, 1 Mar 2001 09:42:04 -0500
Received: from hermes.sistina.com ([208.210.145.141]:42509 "HELO sistina.com")
	by vger.kernel.org with SMTP id <S129619AbRCAOlw>;
	Thu, 1 Mar 2001 09:41:52 -0500
Date: Thu, 1 Mar 2001 08:41:33 -0600
From: AJ Lewis <lewis@sistina.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: devfs and /proc/ide/hda
Message-ID: <20010301084133.C16667@sistina.com>
In-Reply-To: <3A9CCA76.3E6AB93A@optushome.com.au> <20010228161023.A19929@win.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010228161023.A19929@win.tue.nl>; from dwguest@win.tue.nl on Wed, Feb 28, 2001 at 04:10:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2001 at 04:10:23PM +0100, Guest section DW wrote:
> On Wed, Feb 28, 2001 at 08:52:54PM +1100, Glenn McGrath wrote:
>=20
> > Im running kernel 2.4.1, I have entries like /proc/ide/hda,
> > /proc/ide/ide0/hda etc irrespective of wether im using devfs or
> > traditional device names.
> >=20
> > Is always using traditional device names for /proc/ide intentional, or
> > is it something nobody has gotten around to fixing yet?
>=20
> If only humans look at /proc, and they like typing long names,
> then there is no objection against changing /proc.
> As it is, however, quite a few programs look at /proc for
> information about devices. I don't think it would be a good
> idea to "fix" /proc and simultaneously break all these programs.

What it should do is change based on whether devfs is mounted or not.  It
doesn't make *any* sense to have /dev/ide/host0/foo/bar in your
/proc/partitions entries if you aren't mounting devfs.  The /proc/partitions
entry is the only way I know of for something like LVM to determine which
devices to scan for Volume Groups.  If you can't read /proc/partitions, it
has to attempt to scan all block devices it recognizes, regardless of
whether they are actually on the system or not.  This can take several
minutes.

--=20
AJ Lewis
Sistina Software Inc.                  Voice:  612-379-3951
1313 5th St SE, Suite 111              Fax:    612-379-3952
Minneapolis, MN 55414                  E-Mail: lewis@sistina.com
http://www.sistina.com

Current GPG fingerprint =3D 3B5F 6011 5216 76A5 2F6B  52A0 941E 1261 0029 2=
648
Get my key at: http://www.sistina.com/~lewis/gpgkey
 (Unfortunately, the PKS-type keyservers do not work with multiple sub-keys)

-----Begin Obligatory Humorous Quote----------------------------------------
Choose a job you love, and you will never have to work a day in your life.
-----End Obligatory Humorous Quote------------------------------------------

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6nl+dpE6/iGtdjLERAsLJAJ94tQpG8ST0ZQtQjxHTR67+xsQx+QCfbSix
Q4QgGzGepyWxzevmNCw6TYc=
=fzLP
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--

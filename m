Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129618AbRCZXFW>; Mon, 26 Mar 2001 18:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129624AbRCZXFN>; Mon, 26 Mar 2001 18:05:13 -0500
Received: from hermes.sistina.com ([208.210.145.141]:20744 "HELO sistina.com")
	by vger.kernel.org with SMTP id <S129568AbRCZXFC>;
	Mon, 26 Mar 2001 18:05:02 -0500
Date: Mon, 26 Mar 2001 17:03:58 -0600
From: AJ Lewis <lewis@sistina.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Andreas Dilger <adilger@turbolinux.com>,
        LA Walsh <law@sgi.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: 64-bit block sizes on 32-bit systems
Message-ID: <20010326170358.A2872@sistina.com>
In-Reply-To: <20010326181803.F31126@parcelfarce.linux.theplanet.co.uk> <200103261747.f2QHlEX19564@webber.adilger.int> <20010326190945.I31126@parcelfarce.linux.theplanet.co.uk> <m17l1cz88v.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <m17l1cz88v.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Mon, Mar 26, 2001 at 11:37:52AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2001 at 11:37:52AM -0700, Eric W. Biederman wrote:
> Matthew Wilcox <matthew@wil.cx> writes:
>=20
> > On Mon, Mar 26, 2001 at 10:47:13AM -0700, Andreas Dilger wrote:
> > > What do you mean by problems 5 years down the road?  The real issue i=
s that
> > > this 32-bit block count limit affects composite devices like MD RAID =
and
> > > LVM today, not just individual disks.  There have been several postin=
gs
> > > I have seen with people having a problem _today_ with a 2TB limit on
> > > devices.
> >=20
> > people who can afford 2TB of disc can afford to buy a 64-bit processor.
>=20
> Currently that doesn't solve the problem as block_nr is held in an int.
> And as gcc compiles an int to a 32bit number on a 64bit processor, the
> problem still isn't solved.
>=20
> That at least we need to address.

What I don't understand is why we can't just put an option in the Linux
config to enable 64-bit block support, as we have with the High Memory
Support option.  That way the user could select that option if they want it,
regardless of the processor they are using.  Jens Axboe <axboe@suse.de>
already mentioned he had patched the kernel to do someting similar earlier
this month on a similar thread on linux-kernel.

It makes sense to have this option when we have an enterprise level LVM
and 64-bit file systems such as the Global File System (GFS) for Linux.

Regards,
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
APATHY ERROR: Don't bother striking any key.
-----End Obligatory Humorous Quote------------------------------------------

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6v8repE6/iGtdjLERAg+GAJ9FDEX1tb9HVc0kC0g1TPHlUaBCVwCeJPz/
wJ1TLg0SDTH0JNp+tqk0tZs=
=9JRM
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

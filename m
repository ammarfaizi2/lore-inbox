Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132260AbRBRATs>; Sat, 17 Feb 2001 19:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132241AbRBRATi>; Sat, 17 Feb 2001 19:19:38 -0500
Received: from toscano.org ([64.50.191.142]:43216 "HELO bubba.toscano.org")
	by vger.kernel.org with SMTP id <S132260AbRBRATb>;
	Sat, 17 Feb 2001 19:19:31 -0500
Date: Sat, 17 Feb 2001 19:19:30 -0500
From: Pete Toscano <pete.lkml@toscano.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1ac17 hang on mounting loopback fs
Message-ID: <20010217191930.A12036@bubba.toscano.org>
Mail-Followup-To: Pete Toscano <pete.lkml@toscano.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <14990.18933.849551.526672@mercury.st.hmc.edu> <E14UE0r-00071Q-00@the-village.bc.nu> <14990.57922.176851.105401@mercury.st.hmc.edu> <20010218020140.F5199@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010218020140.F5199@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Sun, Feb 18, 2001 at 02:01:40AM +0200
X-Unexpected: The Spanish Inquisition
X-Uptime: 7:11pm  up 26 min,  6 users,  load average: 1.40, 0.89, 0.45
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hmmm... I've been trying to play with GRUB on my 2.4.2-pre4 system.  For
safety's sake, I wanted to make a bookdisk with mkbootdisk.  After
reading this, I see now why mkbootdisk was locking in the D state with
the loop mounted... Would this also explain not being able to seek
forward while writing a floppy? =20

I was trying to make the GRUB boot disk by writing the stage 1 and 2
loaders to the floppy (as per the GRUB docs) with dd:

[root@bubba grub]# dd of=3D/dev/fd0 if=3Dstage1 bs=3D512 count=3D1
1+0 records in
1+0 records out
[root@bubba grub]# dd of=3D/dev/fd0 if=3Dstage2 bs=3D512 seek=3D1
dd: advancing past 1 blocks in output file `/dev/fd0': Permission denied

With 2.4.1, I get a different error message, but, AFAICT, the same
result.

pete


Alan Cox writes:
> > # mount -t ext2 -o loop /spare/i486-linuxaout.img /spare/mnt
> > loop: enabling 8 loop devices
>=20
> Loop does not currently work in 2.4. It might partly work by luck
> but thats it.  This will change as and when the new loop patches go
> in. Until then if you need loop use 2.2

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6jxUSsMikd2rK89sRAqg8AJsFBPOsOCJcQOiW8Oc0IGeirElzlQCdHXnL
5zrlakll6HG4bIPDBIn6HJ4=
=NMW5
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--

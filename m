Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267513AbRGMRng>; Fri, 13 Jul 2001 13:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267515AbRGMRn1>; Fri, 13 Jul 2001 13:43:27 -0400
Received: from ns.suse.de ([213.95.15.193]:3077 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S267514AbRGMRnU>;
	Fri, 13 Jul 2001 13:43:20 -0400
Date: Fri, 13 Jul 2001 19:43:18 +0200
From: Joerg Reuter <jreuter@suse.de>
To: Maksim Krasnyanskiy <maxk@qualcomm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG?] vtund broken by tun driver changes in 2.4.6
Message-ID: <20010713194317.A18866@suse.de>
In-Reply-To: <Pine.LNX.4.33.0107070058350.29490-100000@mackman.net.suse.lists.linux.kernel> <009601c106ff$a3cb2070$6baaa8c0@kevin.suse.lists.linux.kernel> <20010713133329.DDCEB19A57@lamarr.suse.de> <01071308585200.00792@btdemo1.qualcomm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <01071308585200.00792@btdemo1.qualcomm.com>
User-Agent: Mutt/1.3.19i
X-Face: #DGJ)DCeau/h"w7G~n9r|/jxvQQrtU)nat27v-><7':==-=.mfnXc+8&qOj`*R|qPr14[|4
	E_BUo5T*NT\(+fE7wr3}QoN*!c7\.Z.DiA{ko;01^TCi$K}1TIV|bNO.$jm;i<A,|
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 13, 2001 at 08:58:52AM -0700, Maksim Krasnyanskiy wrote:

> Ioctls were defined _without_ IOW macros. And that was ugly. That's why I=
 redifened them.
> So, if you recompile everything will be fine.

So you break binary compatibilty within a _stable_ kernel release just
for the sake of beauty? Besides, this does not only affect VTUND but
also other applications like Hercules. Just recompiling Hercules doesn't
help here anyway, because it (rightfully) refuses to include kernel
headers but (due to the lack of net/if_tun.h within glibc) constructs
the IOCTL command on its own.

> > And BTW, you shouldn't include kernel headers from user space programs,=
 should you.
> That rule doesn't apply here.=20

Can you tell me why it does not apply here? Just because you happen to
be the author of both the driver (which is, without doubt, very
valuable) and _one_ of several applications using it?

--=20
Joerg Reuter                                    http://yaina.de/jreuter
And I make my way to where the warm scent of soil fills the evening air.=20
Everything is waiting quietly out there....                 (Anne Clark)

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE7TzM1XQh8bpcgulARAg1yAJwJMYx3uJ1nxa+aztNXAppcUccieACfcK+L
lz4XtF19sD2WqSnvu4wZLPY=
=2VkA
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

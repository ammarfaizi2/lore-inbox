Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290926AbSAaFHQ>; Thu, 31 Jan 2002 00:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290927AbSAaFHH>; Thu, 31 Jan 2002 00:07:07 -0500
Received: from [65.169.83.229] ([65.169.83.229]:60043 "EHLO
	hst000004380um.kincannon.olemiss.edu") by vger.kernel.org with ESMTP
	id <S290926AbSAaFGr>; Thu, 31 Jan 2002 00:06:47 -0500
Date: Wed, 30 Jan 2002 23:05:59 -0600
From: Benjamin Pharr <ben@benpharr.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.3: Unresolved Symbols in ppp_deflate.o and ufs.o
Message-ID: <20020131050559.GA24062@hst000004380um.kincannon.olemiss.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.4.18pre2
X-PGP-ID: 0x6859792C
X-PGP-Key: http://www.benpharr.com/public_key.asc
X-PGP-Fingerprint: 7BF0 E432 3365 C1FC E0E3  0BE2 44E1 3E1E 6859 792C
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

After moving the files from linux/ and applying the i810 patch posted to
the list, I made it all the way to the end of a "make dep bzImage
modules modules_install" without any errors. However, I got this right
at the end:

make[1]: Leaving directory `/usr/src/linux-2.5.3/arch/i386/lib'
cd /lib/modules/2.5.3; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.3; fi
depmod: *** Unresolved symbols in
/lib/modules/2.5.3/kernel/drivers/net/ppp_deflate.o
depmod: 	zlib_inflateIncomp
depmod: *** Unresolved symbols in /lib/modules/2.5.3/kernel/fs/ufs/ufs.o
depmod: 	lock_kernel
depmod: 	unlock_kernel
benix:/usr/src/linux-2.5.3#=20

Ben Pharr


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8WNC3ROE+HmhZeSwRAidLAJwIShUAK/6vKnmBW68fJZ4KuJd8xQCgrlUF
ihAxK3iZYRZpK9L2ufaU2cY=
=89De
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--

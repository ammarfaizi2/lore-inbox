Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbSK0Tym>; Wed, 27 Nov 2002 14:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264723AbSK0Tym>; Wed, 27 Nov 2002 14:54:42 -0500
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:28755 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S264715AbSK0Tyl>;
	Wed, 27 Nov 2002 14:54:41 -0500
Date: Wed, 27 Nov 2002 21:01:53 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.49-mm2
Message-ID: <20021127210153.A8411@jaquet.dk>
References: <3DE48C4A.98979F0C@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DE48C4A.98979F0C@digeo.com>; from akpm@digeo.com on Wed, Nov 27, 2002 at 01:11:38AM -0800
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2002 at 01:11:38AM -0800, Andrew Morton wrote:
>=20
> url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.49/2.5.49-mm2/

I'm fairly sure this is not specific to -mm2 since it looks
at lot like my problem from plain 2.5.49
(http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D103805691602076&w=3D2)
but -mm2 gave me some usable debug output:

Debug: Sleeping function called from illegal context at include/
linux/rwsem.h:66
Call Trace: __might_sleep+0x54/0x58
           sys_mprotect+0x97/0x22b
           syscall_call+0x7/0xb

Unable to handle kernel paging request at virtual address 4001360c

(I did not copy the rest but can reproduce at will.)

AFAICS, the fingered function is down_write at mprotect.c:262
but I fail to see why it is in a illegal context...

Hope this is useful for somebody. I am willing to test patches.

Regards,
  Rasmus

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE95SSxlZJASZ6eJs4RAsfAAKCMPWVTMp9viGs1wzl7oRS4BoGYkQCeNAAa
8G6Rl053deFhkxS54KhQchg=
=HfYA
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSHMIVO>; Tue, 13 Aug 2002 04:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSHMIVO>; Tue, 13 Aug 2002 04:21:14 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:15748 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S313898AbSHMIVM>; Tue, 13 Aug 2002 04:21:12 -0400
Date: Tue, 13 Aug 2002 11:19:46 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] __func__ -> __FUNCTION__
Message-ID: <20020813081946.GC2192@alhambra.actcom.co.il>
References: <3D58A45F.A7F5BDD@zip.com.au> <ajaa5h$61f$1@cesium.transmeta.com> <3D58BF90.56C75C66@zip.com.au> <20020813075944.GA2192@alhambra.actcom.co.il> <3D58BEC3.50508@zytor.com> <20020813081028.GB2192@alhambra.actcom.co.il> <3D58C0FB.1020503@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+b2GFy/wpzNn/yIF"
Content-Disposition: inline
In-Reply-To: <3D58C0FB.1020503@zytor.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+b2GFy/wpzNn/yIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2002 at 01:19:07AM -0700, H. Peter Anvin wrote:
>=20
> But it won't work on a compiler that actually *supports* __func__...
>=20
> I think that is gcc 3.1 or higher, but I'm not the authority...

Again, works for me.

http://home.tiscalinet.ch/t_wolf/tw/c/c9x_changes.html (search for
__func__) would seem to imply that you are correct, though. Perhaphs
someone more knowledgable about gcc could shed some light? =20

mulix@tea:~/tmp$ cat foo.c
#include <stdio.h>

#if DEF_FUNC
#ifndef __func__
#define __func__ __FUNCTION__
#endif /* !defined __func__ */
#endif /* DEF_FUNC */=20

int main()
{
	printf("%s\n", __func__);=20
	return 0;=20
}
mulix@tea:~/tmp$ gcc3 -v
Reading specs from /usr/local/lib/gcc-lib/i686-pc-linux-gnu/3.1/specs
Configured with: ../gcc-3.1/configure --enable-threads
--enable-languages=3Dc,c++
Thread model: posix
gcc version 3.1
mulix@tea:~/tmp$ gcc3 foo.c -DDEF_FUNC=3D1 -o foo
mulix@tea:~/tmp$ ./foo
main
mulix@tea:~/tmp$ gcc3 foo.c -DDEF_FUNC=3D0 -o foo
mulix@tea:~/tmp$ ./foo
main
mulix@tea:~/tmp$=20

> >ObCompleteyUnrelatedQuestions: where can I find klibc?=20
>=20
> ftp://ftp.kernel.org/pub/linux/libs/klibc/

Much obliged.=20
--=20
"Hmm.. Cache shrink failed - time to kill something?
 Mhwahahhaha! This is the part I really like. Giggle."
					 -- linux/mm/vmscan.c
http://vipe.technion.ac.il/~mulix/	http://syscalltrack.sf.net

--+b2GFy/wpzNn/yIF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9WMEiKRs727/VN8sRAvbXAKCxxv9YbSDsUEuz0ZceiFVjMh3G5ACfXy0U
H9CwwJH3TEG+979gXFy8cm4=
=3lqa
-----END PGP SIGNATURE-----

--+b2GFy/wpzNn/yIF--

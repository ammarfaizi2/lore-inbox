Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262649AbSJBWvi>; Wed, 2 Oct 2002 18:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262650AbSJBWvh>; Wed, 2 Oct 2002 18:51:37 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:60072 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S262649AbSJBWvg>; Wed, 2 Oct 2002 18:51:36 -0400
Date: Wed, 2 Oct 2002 17:56:51 -0500
From: Bob McElrath <bob+linux-kernel@mcelrath.org>
To: Bill Huey <billh@gnuppy.monkey.org>, linux-kernel@vger.kernel.org
Subject: Re: NVIDIA binary-only driver patch for 2.5.40
Message-ID: <20021002225651.GK29725@draal.physics.wisc.edu>
References: <20021002161006.GM25319@draal.physics.wisc.edu> <20021002224913.GA3438@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9/GiYV45wF7IL3Iq"
Content-Disposition: inline
In-Reply-To: <20021002224913.GA3438@gnuppy.monkey.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9/GiYV45wF7IL3Iq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Bill Huey [billh@gnuppy.monkey.org] wrote:
> On Wed, Oct 02, 2002 at 11:10:06AM -0500, Bob McElrath wrote:
> > Here is an updated patch to the binary-only drivers provided by NVIDIA
> > (version 1.0-3123) for kernel 2.5.40.  I have tested it for both 2D and
> > 3D and it seems to work fine.  (Warcraft III under linux 2.5.40 should
> > be a good enough test, no?)
>=20
> It doesn't exactly compile correctly:
>=20
> root@gnuppy> /linux1/NVIDIA/NVIDIA_kernel-1.0-3123% 21# make
> echo \#define NV_COMPILER \"`cc -v 2>&1 | tail -1`\" > nv_compiler.h
> cc -c -Wall -Wimplicit -Wreturn-type -Wswitch -Wformat -Wchar-subscripts =
-Wparentheses -Wpointer-arith -Wcast-qual -Wno-
> D_LOOSE_KERNEL_NAMES -DNTRM -D_GNU_SOURCE -DRM_HEAPMGR -D_LOOSE_KERNEL_NA=
MES -D__KERNEL__ -DMODULE  -DNV_MAJOR_VERSION=3D1
> 3  -DNV_UNIX   -DNV_LINUX   -DNVCPU_X86       -I. -I/lib/modules/2.5.40/b=
uild/include -Wno-cast-qual nv.c
> In file included from /lib/modules/2.5.40/build/include/linux/irq.h:19,
> 		from /lib/modules/2.5.40/build/include/asm/hardirq.h:6,
> 		from /lib/modules/2.5.40/build/include/linux/interrupt.h:25,
> 		from nv-linux.h:59,
> 		from nv.c:14:
> /lib/modules/2.5.40/build/include/asm/irq.h:16: irq_vectors.h: No such fi=
le or directory
> make: *** [nv.o] Error 1
> root@gnuppy> /linux1/NVIDIA/NVIDIA_kernel-1.0-3123% 22#=20

oh yeah...that...

I forgot I made a link from arch/i386/mach-generic/irq_vectors.h to
include/asm/irq_vectors.h.

The above error is in include/asm/irq.h and not a problem with the
nvidia driver itself.  (poke poke kernel maintainers)

Cheers,
-- Bob

Bob McElrath (bob+linux-kernel@mcelrath.org)=20
Univ. of Wisconsin at Madison, Department of Physics

    "The purpose of separation of church and state is to keep forever from
    these shores the ceaseless strife that has soaked the soil of Europe in
    blood for centuries." -- James Madison


--9/GiYV45wF7IL3Iq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2bebIACgkQjwioWRGe9K0T8QCfei5aMn1tmCT9kpqT+yuIsEGt
EeMAnROvffFFwJac1eelQ66sorud2HEg
=yXnb
-----END PGP SIGNATURE-----

--9/GiYV45wF7IL3Iq--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275928AbSIUSaV>; Sat, 21 Sep 2002 14:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275930AbSIUSaV>; Sat, 21 Sep 2002 14:30:21 -0400
Received: from h24-68-71-10.vc.shawcable.net ([24.68.71.10]:38148 "EHLO
	kruhftwerk.dyndns.org") by vger.kernel.org with ESMTP
	id <S275928AbSIUSaU>; Sat, 21 Sep 2002 14:30:20 -0400
Date: Sat, 21 Sep 2002 11:35:27 -0700
From: Burton Samograd <kruhft@kruhft.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: problems building bzImage with 2.5.*
Message-ID: <20020921183527.GL22811@kruhft.dyndns.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Content-Disposition: inline
X-GPG-key: http://kruhftwerk.dyndns.org/kruhft.pubkey.asc
X-Operating-System: Linux kruhft.dyndns.org 2.4.19-gentoo-r9 
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm quite new to the list and I'm not sure if this has been posted
already but I thought I would give it a shot. I've been trying to
build the 2.5.* kernels (2.5.37 at the moment but this has happened
with previous version as well) and when doing a make bzImage i keep
getting the following error during the final linkage:

<-- snip make entering and leaving individual driver directories with no
  errors -->

 =20
  Generating build number
make[1]: Entering directory `/usr/src/linux-2.5.37/init'
  Generating /usr/src/linux-2.5.37/include/linux/compile.h (updated)
  gcc -Wp,-MD,./.version.o.d -D__KERNEL__
  -I/usr/src/linux-2.5.37/include -Wall -Wstrict-prototypes
  -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
  -fno-common -pipe -mpreferred-stack-boundary=3D2 -march=3Di686
  -I/usr/src/linux-2.5.37/arch/i386/mach-generic -nostdinc
  -iwithprefix include    -DKBUILD_BASENAME=3Dversion   -c -o version.o
  version.c
   ld -m elf_i386  -r -o built-in.o main.o version.o do_mounts.o
make[1]: Leaving directory `/usr/src/linux-2.5.37/init'
  ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s
  arch/i386/kernel/head.o arch/i386/kernel/init_task.o
  init/built-in.o --start-group  arch/i386/kernel/built-in.o
  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o
  kernel/built-in.o mm/built-in.o fs/built-in.o ipc/built-in.o
  security/built-in.o  lib/lib.a  arch/i386/lib/lib.a
  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o
  net/built-in.o --end-group -o vmlinux
drivers/built-in.o(.data+0xac34): undefined reference to `local
symbols in discarded section .text.exit'
make: *** [vmlinux] Error 1

<-- end of error -->

This is with gcc 3.1.1 on gentoo.

Also, is there a dependable link to searching the archives for this
list?  I found some on the faq page but the results were less than
useful.

Thanks in advance.

burton

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9jLvvLq/0KC7fYbURArJ1AJ92h33JLVRyLlN6rA7T7NJ4qbSaqgCffYuI
w7iEWvJQseiVM+WvRohtVko=
=VDJX
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--

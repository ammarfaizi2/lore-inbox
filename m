Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWDBKXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWDBKXF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 06:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWDBKXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 06:23:04 -0400
Received: from 169.248.adsl.brightview.com ([80.189.248.169]:2569 "EHLO
	getafix.willow.local") by vger.kernel.org with ESMTP
	id S932305AbWDBKXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 06:23:03 -0400
Date: Sun, 2 Apr 2006 11:22:59 +0100
From: John Mylchreest <johnm@gentoo.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, paulus@samba.org
Subject: Re: [PATCH 1/1] POWERPC: Fix ppc32 compile with gcc+SSP in 2.6.16
Message-ID: <20060402102259.GM16917@getafix.willow.local>
References: <20060401224849.GH16917@getafix.willow.local> <20060402085850.GA28857@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kK1uqZGE6pgsGNyR"
Content-Disposition: inline
In-Reply-To: <20060402085850.GA28857@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kK1uqZGE6pgsGNyR
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 02, 2006 at 10:58:50AM +0200, Olaf Hering <olh@suse.de> wrote:
>  On Sat, Apr 01, John Mylchreest wrote:
>=20
> > Since ppc32 has been made to use arch/powerpc it has introduced a build=
-time
> > regression where userland CFLAGS are being leaked. This is especially o=
bvious
> > when a user tries to "make zImage" with an SSP enabled gcc.
>=20
> What build error do you get?

As requested :)

$ gcc -v
Reading specs from /usr/lib/gcc/powerpc-unknown-linux-gnu/3.4.4/specs
Configured with: /var/tmp/portage/gcc-3.4.4-r1/work/gcc-3.4.4/configure
--prefix=3D/usr --bindir=3D/usr/powerpc-unknown-linux-gnu/gcc-bin/3.4.4
--includedir=3D/usr/lib/gcc/powerpc-unknown-linux-gnu/3.4.4/include
--datadir=3D/usr/share/gcc-data/powerpc-unknown-linux-gnu/3.4.4
--mandir=3D/usr/share/gcc-data/powerpc-unknown-linux-gnu/3.4.4/man
--infodir=3D/usr/share/gcc-data/powerpc-unknown-linux-gnu/3.4.4/info
--with-gxx-include-dir=3D/usr/lib/gcc/powerpc-unknown-linux-gnu/3.4.4/inclu=
de/g++-v3
--host=3Dpowerpc-unknown-linux-gnu --build=3Dpowerpc-unknown-linux-gnu
--enable-altivec --disable-nls --with-system-zlib --disable-checking
--disable-werror --disable-libunwind-exceptions --disable-multilib
--disable-libgcj --enable-languages=3Dc,c++ --enable-shared
--enable-threads=3Dposix --enable-__cxa_atexit --enable-clocale=3Dgnu
Thread model: posix
gcc version 3.4.4 (Gentoo Hardened 3.4.4-r1, HTB-3.4.4-1.00,
ssp-3.4.4-1.0, pie-8.7.8)

  BOOTLD  arch/powerpc/boot/zImage.vmode
  arch/powerpc/boot/prom.o(.text+0x19c): In function `call_prom':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/prom.o(.text+0x3a8): In function `call_prom_ret':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/prom.o(.text+0x448): In function `write':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/prom.o(.text+0x4d8): In function `string_match':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/prom.o(.text+0x5ac): In function `claim':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/prom.o(.got2+0x4): undefined reference to `__guard'
  arch/powerpc/boot/stdio.o(.text+0x84): In function `strnlen':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/stdio.o(.text+0x130): In function `skip_atoi':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/stdio.o(.text+0x374): In function `number':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/stdio.o(.text+0x5b0): In function `vsprintf':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/stdio.o(.text+0xba8): In function `sprintf':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/stdio.o(.text+0xca4): more undefined references to
  `__stack_smash_handler' follow
  arch/powerpc/boot/stdio.o(.got2+0x0): undefined reference to `__guard'
  arch/powerpc/boot/main.o(.text+0x198): In function `gunzip':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/main.o(.text+0x318): In function `try_claim':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/main.o(.text+0x5b0): In function `start':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/main.o(.got2+0x20): undefined reference to `__guard'
  arch/powerpc/boot/infblock.o(.text+0xac): In function
  `zlib_inflate_blocks_reset':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/infblock.o(.text+0x180): In function
  `zlib_inflate_blocks_new':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/infblock.o(.text+0x428): In function
  `zlib_inflate_blocks':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/infblock.o(.text+0xd00): In function
  `zlib_inflate_blocks_free':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/infblock.o(.got2+0x0): undefined reference to
  `__guard'
  arch/powerpc/boot/infcodes.o(.text+0x68): In function
  `zlib_inflate_codes_new':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/infcodes.o(.text+0x18c): In function
  `zlib_inflate_codes':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/infcodes.o(.text+0x8ec): In function
  `zlib_inflate_codes_free':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/infcodes.o(.got2+0x0): undefined reference to
  `__guard'
  arch/powerpc/boot/inffast.o(.text+0x1a4): In function
  `zlib_inflate_fast':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/inffast.o(.got2+0xc): undefined reference to
  `__guard'
  arch/powerpc/boot/inflate.o(.text+0x1b8): In function `zlib_adler32':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/inflate.o(.text+0x21c): In function
  `zlib_inflate_workspacesize':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/inflate.o(.text+0x2e0): In function
  `zlib_inflateReset':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/inflate.o(.text+0x38c): In function
  `zlib_inflateEnd':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/inflate.o(.text+0x438): In function
  `zlib_inflateInit2_':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/inflate.o(.text+0x570): more undefined references to
  `__stack_smash_handler' follow
  arch/powerpc/boot/inflate.o(.got2+0x0): undefined reference to
  `__guard'
  arch/powerpc/boot/inftrees.o(.text+0x248): In function `huft_build':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/inftrees.o(.text+0x63c): In function
  `zlib_inflate_trees_bits':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/inftrees.o(.text+0x784): In function
  `zlib_inflate_trees_dynamic':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/inftrees.o(.text+0xa68): In function
  `zlib_inflate_trees_fixed':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/inftrees.o(.got2+0x0): undefined reference to
  `__guard'
  arch/powerpc/boot/infutil.o(.text+0x114): In function
  `zlib_inflate_flush':
  : undefined reference to `__stack_smash_handler'
  arch/powerpc/boot/infutil.o(.got2+0x0): undefined reference to
  `__guard'
  make[2]: *** [arch/powerpc/boot/zImage.vmode] Error 1
  make[1]: *** [zImage] Error 2
  make: *** [zImage] Error 2
 =20

--=20
Role:            Gentoo Linux Kernel Lead
Gentoo Linux:    http://www.gentoo.org
Public Key:      gpg --recv-keys 9C745515
Key fingerprint: A0AF F3C8 D699 A05A EC5C  24F7 95AA 241D 9C74 5515


--kK1uqZGE6pgsGNyR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEL6YDNzVYcyGvtWURAhFuAJ9fRGD0VGPVrZPmz2838ZYdYopVSQCdHpPh
f9Dwgjl7qDSNxyb15P1ty6s=
=ACtz
-----END PGP SIGNATURE-----

--kK1uqZGE6pgsGNyR--

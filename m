Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbVKLVhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbVKLVhf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 16:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbVKLVhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 16:37:35 -0500
Received: from mout1.freenet.de ([194.97.50.132]:18330 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S932504AbVKLVhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 16:37:33 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: Linuv 2.6.15-rc1
Date: Sat, 12 Nov 2005 22:37:16 +0100
User-Agent: KMail/1.8.3
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <200511122145.38409.mbuesch@freenet.de> <Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
Cc: linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <200511122237.17157.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart1388875.tcmuNVc8HF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1388875.tcmuNVc8HF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 12 November 2005 22:00, you wrote:
>=20
> On Sat, 12 Nov 2005, Michael Buesch wrote:
> >=20
> > Latest GIT tree does not boot on my G4 PowerBook.
>=20
> What happens if you do
>=20
> 	make ARCH=3Dpowerpc
>=20
> and build everything that way (including the "config" phase)?

I did
make mrproper
copy the .config over again
make ARCH=3Dpowerpc menuconfig
exit and save from menuconfig
make ARCH=3Dpowerpc

The result of the build is:

  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/powerpc/kernel/built-in.o: In function `platform_init':
: undefined reference to `prep_init'
arch/powerpc/kernel/built-in.o:(__ksymtab+0x4d8): undefined reference to `u=
cSystemType'
arch/powerpc/kernel/built-in.o:(__ksymtab+0x4e0): undefined reference to `_=
prep_type'
make: *** [.tmp_vmlinux1] Error 1


=2D-=20
Greetings Michael.

--nextPart1388875.tcmuNVc8HF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDdmCNlb09HEdWDKgRAkN2AJ9vzqHidntpXbUrhDSMfK3QiyJYbwCgg2AE
Oll/uEGQ2i+usB7+Yr9NFgU=
=5kHs
-----END PGP SIGNATURE-----

--nextPart1388875.tcmuNVc8HF--

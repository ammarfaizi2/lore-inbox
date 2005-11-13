Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVKMVCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVKMVCg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 16:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbVKMVCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 16:02:35 -0500
Received: from smtp06.auna.com ([62.81.186.16]:25733 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S1750705AbVKMVCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 16:02:35 -0500
Date: Sun, 13 Nov 2005 22:02:13 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: x86 building altivec for raid ?
Message-ID: <20051113220213.55fc6fae@werewolf.auna.net>
X-Mailer: Sylpheed-Claws 1.9.100cvs7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_lqreqzfpTXzeFCGDyvgpGWH;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.218.105] Login:jamagallon@able.es Fecha:Sun, 13 Nov 2005 22:02:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_lqreqzfpTXzeFCGDyvgpGWH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all...

Long time ago noticed this, but did not remember to report till this night:
x86 seems to build altivec source files for md checksums:

  CC      drivers/md/raid6recov.o
  CC      fs/partitions/ldm.o
  CC      fs/proc/task_mmu.o
  HOSTCC  drivers/md/mktables
  CC      net/core/dev_mcast.o
  UNROLL  drivers/md/raid6int1.c
  UNROLL  drivers/md/raid6int2.c
  UNROLL  drivers/md/raid6int4.c
  UNROLL  drivers/md/raid6int8.c
  UNROLL  drivers/md/raid6int16.c
  CC      fs/proc/inode.o
  UNROLL  drivers/md/raid6int32.c
  UNROLL  drivers/md/raid6altivec1.c
  UNROLL  drivers/md/raid6altivec2.c
  UNROLL  drivers/md/raid6altivec4.c
  UNROLL  drivers/md/raid6altivec8.c
  CC      fs/partitions/msdos.o
  CC      drivers/md/raid6mmx.o
  CC      fs/proc/root.o
  CC      net/core/dst.o
  LD      fs/partitions/built-in.o
  CC      net/core/neighbour.o
  CC      drivers/md/raid6sse1.o
 =20
(buld lines are out of order due to a make -j4)

Kernel is 2.6.14-mm2.
This is an x86 box, why does it compile raid6altivec*.c ? I suppose it
does not generate any code, because of some #ifdef magic, but why does
it build them anyways ? Looks a bit strange.

Thanks.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam2 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_lqreqzfpTXzeFCGDyvgpGWH
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDd6nVRlIHNEGnKMMRAomyAJ9tmzEB3gyM9i40C36VWnvE3KXxdgCglV6v
PEumdZVQdoF68JH+hqwPKkc=
=sv7M
-----END PGP SIGNATURE-----

--Sig_lqreqzfpTXzeFCGDyvgpGWH--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263208AbTDWJcS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 05:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTDWJcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 05:32:17 -0400
Received: from pop.gmx.net ([213.165.64.20]:59795 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263208AbTDWJcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 05:32:16 -0400
Date: Wed, 23 Apr 2003 11:44:09 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc1-ac1 / undefined reference to `sync_dquots_dev'
Message-ID: <20030423094409.GA5546@mob.wid>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
x-gpg-key: CF286A67
x-gpg-fingerprint: 717B AE57 49B3 410F A733  FE6A 2D43 E1E3 CF28 6A67
From: Felix Triebel <ernte23@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

compiling 2.4.21-rc1-ac1 gives:

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/k=
ernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/d=
o_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o=
 fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o driv=
ers/net/net.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/s=
csidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o =
drivers/media/media.o drivers/isdn/vmlinux-obj.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/sr=
c/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
fs/fs.o(.text+0x1b349): In function `do_quotactl':
: undefined reference to `sync_dquots_dev'

I used gcc 3.2.3,
need more info?

regards,
Felix Triebel

ps. I'm not subscribed to the list, please CC to me.

--=20

excerpt from "The GNU Privacy Handbook":

A digital signature certifies and timestamps a document. If the document is
subsequently modified in any way, a verification of the signature will fail=
. A
digital signature can serve the same purpose as a hand-written signature wi=
th
the additional benefit of being tamper-resistant.

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----

iD8DBQE+pmBoLUPh488oamcRAj/FAKCJb4Bx2mZyPa62zUfxzRGzb1cb9gCeMqfL
uqaP8DSmU0rQMCg03tV2Aq4=
=kmNK
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--

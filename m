Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbTF3P5P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 11:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbTF3P5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 11:57:15 -0400
Received: from 24-216-225-11.charter.com ([24.216.225.11]:3293 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S265234AbTF3P4z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 11:56:55 -0400
Date: Mon, 30 Jun 2003 12:11:12 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: What did I miss?
Message-ID: <20030630161112.GB24137@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



2.4.21-ac3 kernel.  Compiling it without module support and alot of
devices.  I'm getting this:

gcc -D__KERNEL__
-I/exp/src1/kernels/2.4.21/Server/General/linux-2.4.21-ac3-general-SMP/incl=
ude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2
-march=3Di586   -nostdinc -iwithprefix include -DKBUILD_BASENAME=3Dsocket
-c -o socket.o socket.c
gcc -D__KERNEL__
-I/exp/src1/kernels/2.4.21/Server/General/linux-2.4.21-ac3-general-SMP/incl=
ude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2
-march=3Di586   -nostdinc -iwithprefix include
-DKBUILD_BASENAME=3Dsysctl_net  -c -o sysctl_net.o sysctl_net.c
rm -f network.o
ld -m elf_i386  -r -o network.o socket.o core/core.o ethernet/ethernet.o
802/802.o sched/sched.o netlink/netlink.o ipv4/ipv4.o
ipv4/netfilter/netfilter.o unix/unix.o packet/packet.o bridge/bridge.o
sunrpc/sunrpc.o 8021q/8021q.o sysctl_net.o
make[2]: Leaving directory
`/exp/src1/kernels/2.4.21/Server/General/linux-2.4.21-ac3-general-SMP/net'
make[1]: Leaving directory
`/exp/src1/kernels/2.4.21/Server/General/linux-2.4.21-ac3-general-SMP/net'
ld -m elf_i386 -T
/exp/src1/kernels/2.4.21/Server/General/linux-2.4.21-ac3-general-SMP/arch/i=
386/vmlinux.lds
-e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o
init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/parport/driver.o drivers/char/char.o
drivers/block/block.o drivers/misc/misc.o drivers/net/net.o
drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o
drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o
drivers/usb/usbdrv.o drivers/media/media.o drivers/input/inputdrv.o
drivers/message/i2o/i2o.o drivers/md/mddev.o \
        net/network.o \
        /exp/src1/kernels/2.4.21/Server/General/linux-2.4.21-ac3-general-SM=
P/arch/i386/lib/lib.a
/exp/src1/kernels/2.4.21/Server/General/linux-2.4.21-ac3-general-SMP/lib/li=
b.a
/exp/src1/kernels/2.4.21/Server/General/linux-2.4.21-ac3-general-SMP/arch/i=
386/lib/lib.a
\
        --end-group \
        -o vmlinux
drivers/net/net.o(.data+0x854): undefined reference to `local symbols in
discarded section .text.exit'
make: *** [vmlinux] Error 1



(Please ignore CR wrapping by VI).

WTF is broken?  No obvious error messages outside a reference to net.o.
I've tried enabling and removing different options but this doesn't seem
to go away.  Any idea what option/driver is horked up?

Robert

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/AGEg8+1vMONE2jsRAuq1AKDoZzaHribCVRpdvRxKmjr09lCjIgCeIiXA
ccGwLWBNB2tPYuGB9++aNfI=
=9zhz
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--

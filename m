Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264659AbSKRS2Y>; Mon, 18 Nov 2002 13:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264620AbSKRS2X>; Mon, 18 Nov 2002 13:28:23 -0500
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:57516 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S264659AbSKRS1D>; Mon, 18 Nov 2002 13:27:03 -0500
Date: Mon, 18 Nov 2002 19:33:59 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.48
Message-Id: <20021118193359.6ab0ae99.us15@os.inf.tu-dresden.de>
In-Reply-To: <Pine.LNX.4.44.0211172036590.32717-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0211172036590.32717-100000@penguin.transmeta.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.5claws156 (GTK+ 1.2.10; Linux 2.5.47)
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.zw8j)MbW5Nf?Fg"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.zw8j)MbW5Nf?Fg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2002 20:41:05 -0800 (PST) Linus Torvalds (LT) wrote:

Hi Linus,

2.5.48 broke completely monolithic kernels.

   ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o
arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o
arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o 
crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o
arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
init/built-in.o(.init.text+0x684): In function `start_kernel':
: undefined reference to `extable_init'
make: *** [vmlinux] Error 1

#
# Loadable module support
#
# CONFIG_MODULES is not set


If module support is enabled, the thing links beautifully.

Regards,
-Udo.

--=.zw8j)MbW5Nf?Fg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE92TKZnhRzXSM7nSkRAqVOAJ9M6eCuF/Hisv5c3pdDByYwqzrS1QCeJDjr
iNY9E/1SYqs0lHa7JqGh7ac=
=DW0Y
-----END PGP SIGNATURE-----

--=.zw8j)MbW5Nf?Fg--

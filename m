Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbTDLVoA (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 17:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbTDLVoA (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 17:44:00 -0400
Received: from iucha.net ([209.98.146.184]:57943 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S261816AbTDLVn6 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 17:43:58 -0400
Date: Sat, 12 Apr 2003 16:55:44 -0500
To: Greg KH <greg@kroah.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: oops in bus_add_driver with 2.5.67-bk4
Message-ID: <20030412215544.GA1663@iucha.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
X-message-flag: Outlook: Where do you want [your files] to go today?
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.3i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2.5.67-bk4 oopses at boot with:

ohci-hcd 00:02.2: Silicon Integrated S 7001
ohci-hcd 00:02.2: irq 5, pci mem e485b000
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
ohci-hcd 00:02.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 3 ports detected
ohci-hcd 00:02.3: Silicon Integrated S 7001 (#2)
ohci-hcd 00:02.3: irq 10, pci mem e485d000
ohci-hcd 00:02.3: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 3 ports detected
Unable to handle kernel NULL pointer dereference at virtual address 00000040
 printing eip:
c0282904
*pde =3D 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0282904>]    Not tainted
EFLAGS: 00010282
EIP is at devclass_add_driver+0x34/0x90
eax: 00000040   ebx: fffffff8   ecx: fffffff0   edx: ffff0001
esi: 00000040   edi: 00000000   ebp: c03f8658   esp: c151df50
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=3Dc151c000 task=3Ddff8e040)
Stack: c03f88c0 c03f8674 c03f7c44 00000000 c03f7c00 c0282152 c03f8658 c03f8=
640=20
       00000001 00000000 00000000 c0282628 c03f8658 00000000 00000000 c0282=
628=20
       c03f8408 c02dc8b3 c03f8658 00000000 c04570e0 c02324f7 c03f8408 c044c=
3e3=20
Call Trace:
 [<c0282152>] bus_add_driver+0x82/0xe0
 [<c0282628>] driver_register+0x38/0x40
 [<c0282628>] driver_register+0x38/0x40
 [<c02dc8b3>] usb_register+0x73/0xb0
 [<c02324f7>] pci_register_driver+0x47/0x60
 [<c012c27f>] init_workqueues+0xf/0x50
 [<c01050a3>] init+0x33/0x190
 [<c0105070>] init+0x0/0x190
 [<c0108abd>] kernel_thread_helper+0x5/0x18

Code: 0f c1 10 85 d2 0f 85 48 04 00 00 89 2c 24 e8 99 fe ff ff 85=20
 <0>Kernel panic: Attempted to kill init!

Kernel compiled with=20
florin@beaver:~$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/3.2.3/specs
Configured with: ../src/configure -v
--enable-languages=3Dc,c++,java,f77,proto,pascal,objc,ada --prefix=3D/usr
--mandir=3D/usr/share/man --infodir=3D/usr/share/info
--with-gxx-include-dir=3D/usr/include/c++/3.2 --enable-shared
--with-system-zlib --enable-nls --without-included-gettext
--enable-__cxa_atexit --enable-clocale=3Dgnu --enable-java-gc=3Dboehm
--enable-objc-gc i386-linux
Thread model: posix
gcc version 3.2.3 20030407 (Debian prerelease)

Let me know if you need more details.

florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+mItgNLPgdTuQ3+QRAmkWAJ4tw/9/48VOqe13oBGTjjd15LySbgCfdgSk
hHo3qqeOBz0gvxt8ume8OKw=
=thk1
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--

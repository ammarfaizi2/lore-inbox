Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbSLVPoG>; Sun, 22 Dec 2002 10:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264771AbSLVPoG>; Sun, 22 Dec 2002 10:44:06 -0500
Received: from iucha.net ([209.98.146.184]:3664 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id <S264730AbSLVPoE>;
	Sun, 22 Dec 2002 10:44:04 -0500
Date: Sun, 22 Dec 2002 09:52:11 -0600
From: Florin Iucha <florin@iucha.net>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Next round of AGPGART fixes.
Message-ID: <20021222155211.GB650@iucha.net>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20021220124137.GA28068@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <20021220124137.GA28068@suse.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook: Where do you want [your files] to go today?
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2002 at 12:41:37PM +0000, Dave Jones wrote:
> Linus,
>  Please pull from bk://linux-dj.bkbits.net/agpgart to get at the
> following fixes..
[snip]
> GNU diff for those who care (against Linus' bk tree) is at
> ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/2.5.52/agpgart-f=
ixes-1.diff

I'm using bk7 which contains all your patch except via* stuff which I'm
not interested in.
Agpgart and sis-agp compiled as modules. Modprobe agpgart succeeds,=20
modprobe sis-agp oopses:

agpgart: Detected SiS 735 chipset
Unable to handle kernel paging request at virtual address 1f000207
 printing eip:
e085400c
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<e085400c>]    Not tainted
EFLAGS: 00010282
EIP is at 0xe085400c
eax: c15f5c80   ebx: 000000c0   ecx: 00000000   edx: 1f000207
esi: 00000000   edi: 00000000   ebp: e0992408   esp: df9c7ec4
ds: 0068   es: 0068   ss: 0068
Process modprobe (pid: 498, threadinfo=3Ddf9c6000 task=3Ddd0bb900)
Stack: e08720c8 df9c7ee4 00000246 c15df740 000000c0 c15f5c00 00000000 e0872=
2d0=20
       c15f5c00 000000c0 c15f5c00 000000c0 e099424a c15f5c00 00000000 00000=
0c4=20
       e0875090 c15f5c00 e09923e0 c02391fe c15f5c00 e09943c0 c15f5c4c e0992=
408=20
Call Trace:
 [<e08720c8>] agp_backend_initialize+0x18/0x190 [agpgart]
 [<e08722d0>] agp_register_driver+0x20/0xc0 [agpgart]
 [<e099424a>] agp_sis_probe+0x7a/0x90 [sis_agp]
 [<e0875090>] +0x30/0xa8 [agpgart]
 [<e09923e0>] agp_sis_pci_driver+0x0/0xa0 [sis_agp]
 [<c02391fe>] pci_device_probe+0x5e/0x70
 [<e09943c0>] agp_sis_pci_table+0x0/0x38 [sis_agp]
 [<e0992408>] agp_sis_pci_driver+0x28/0xa0 [sis_agp]
 [<c0273f05>] bus_match+0x45/0x80
 [<e0992408>] agp_sis_pci_driver+0x28/0xa0 [sis_agp]
 [<c027401e>] driver_attach+0x5e/0x80
 [<e0992408>] agp_sis_pci_driver+0x28/0xa0 [sis_agp]
 [<e0992424>] agp_sis_pci_driver+0x44/0xa0 [sis_agp]
 [<e0992408>] agp_sis_pci_driver+0x28/0xa0 [sis_agp]
 [<c0274317>] bus_add_driver+0xa7/0xd0
 [<e0992408>] agp_sis_pci_driver+0x28/0xa0 [sis_agp]
 [<e0992424>] agp_sis_pci_driver+0x44/0xa0 [sis_agp]
 [<c027479f>] driver_register+0x2f/0x40
 [<e0992408>] agp_sis_pci_driver+0x28/0xa0 [sis_agp]
 [<c0239337>] pci_register_driver+0x47/0x60
 [<e0992408>] agp_sis_pci_driver+0x28/0xa0 [sis_agp]
 [<e0994273>] agp_sis_init+0x13/0x60 [sis_agp]
 [<e09923e0>] agp_sis_pci_driver+0x0/0xa0 [sis_agp]
 [<c012f500>] sys_init_module+0x1b0/0x1d0
 [<c010af0b>] syscall_call+0x7/0xb

Code: 69 32 63 5f 63 6f 72 65 00 00 00 00 00 00 00 00 00 00 00 00=20

If it matters, the compiler is:
bear:~# gcc-3.2 -v
Reading specs from /usr/lib/gcc-lib/i386-linux/3.2.2/specs
Configured with: ../src/configure -v --enable-languages=3Dc,c++,java,f77,pr=
oto,pascal,objc,ada --prefix=3D/usr --mandir=3D/usr/share/man --infodir=3D/=
usr/share/info --with-gxx-include-dir=3D/usr/include/c++/3.2 --enable-share=
d --with-system-zlib --enable-nls --without-included-gettext --enable-__cxa=
_atexit --enable-clocale=3Dgnu --enable-java-gc=3Dboehm --enable-objc-gc i3=
86-linux
Thread model: posix
gcc version 3.2.2 20021212 (Debian prerelease)

Cheers,
florin
--=20

"If it's not broken, let's fix it till it is."

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+Bd+rNLPgdTuQ3+QRAomyAJ9aAF/w2Sz4TSLtPlMFE7YmHfvqagCdHX8U
vCTJOcoO+ooWgibLH4sWfO8=
=GBa4
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--

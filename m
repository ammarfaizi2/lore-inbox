Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261627AbSKLP5u>; Tue, 12 Nov 2002 10:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261723AbSKLP5u>; Tue, 12 Nov 2002 10:57:50 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:62896 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261627AbSKLP5t>; Tue, 12 Nov 2002 10:57:49 -0500
Subject: [2.5 bk current] Compile error in module.c
From: Paul Larson <plars@austin.ibm.com>
To: rusty@rustcorp.com.au
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-zCH6+R6ao/F8Ph/vicXT"
X-Mailer: Ximian Evolution 1.0.5 
Date: 12 Nov 2002 10:00:12 -0600
Message-Id: <1037116812.10626.6.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zCH6+R6ao/F8Ph/vicXT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

The ltp nightly run last night failed to compile with the following
errors:

  gcc -Wp,-MD,kernel/.module.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=3D2
-march=3Di686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include  =20
-DKBUILD_BASENAME=3Dmodule -DKBUILD_MODNAME=3Dmodule -DEXPORT_SYMTAB  -c -o
kernel/module.o kernel/module.c
In file included from kernel/module.c:19:
include/linux/module.h:239: warning: `symbol_put' redefined
include/linux/module.h:57: warning: this is the location of the previous
definition
kernel/module.c:555: parse error before `do'
kernel/module.c:560: parse error before `do'
kernel/module.c:560: parse error before `&'
kernel/module.c:560: warning: type defaults to `int' in declaration of
`_raw_spin_lock'
kernel/module.c:560: warning: function declaration isn't a prototype
kernel/module.c:560: conflicting types for `_raw_spin_lock'
include/asm/spinlock.h:117: previous declaration of `_raw_spin_lock'
kernel/module.c:560: warning: data definition has no type or storage
class
kernel/module.c:561: warning: type defaults to `int' in declaration of
`ks'
kernel/module.c:561: braced-group within expression allowed only inside
a function
kernel/module.c:575: `symbol_put_addr' undeclared here (not in a
function)
kernel/module.c:575: initializer element is not constant
kernel/module.c:575: (near initialization for
`__ksymtab_symbol_put_addr.value')gcc: Internal compiler error: program
cc1 got fatal signal 11
make[1]: *** [kernel/module.o] Error 1
make: *** [kernel] Error 2
jeep:/kernel/bk/linux-2.5# {standard input}: Assembler messages:
{standard input}:0: Warning: end of file not at end of a line; newline
inserted

--=-zCH6+R6ao/F8Ph/vicXT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj3RJYwACgkQg9lkBG+YkH9liwCeNZBo5i2oTTR0PofQsHSrMvv3
ENsAn38/Yqn3mF8wdiRxUGyV4UGYntWc
=4pAI
-----END PGP SIGNATURE-----

--=-zCH6+R6ao/F8Ph/vicXT--


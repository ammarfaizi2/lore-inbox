Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310139AbSCKW5p>; Mon, 11 Mar 2002 17:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293749AbSCKW5g>; Mon, 11 Mar 2002 17:57:36 -0500
Received: from rj.sgi.com ([204.94.215.100]:10673 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S293736AbSCKW4b>;
	Mon, 11 Mar 2002 17:56:31 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: zlib vulnerability and modutils
Date: Tue, 12 Mar 2002 09:56:20 +1100
Message-ID: <4394.1015887380@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

A double free vulnerability has been found in zlib which can be used in
a DoS or possibly in an exploit.  Distributions are now shipping
upgraded versions of zlib, installing the new version of zlib will fix
programs that use the shared library.

modutils has an option --enable-zlib which lets modprobe and insmod
read modules that have been compressed with gzip.  If you built your
modutils with --enable-zlib and are using insmod.static then you must
rebuild modutils after first upgrading zlib.  This only applies if
modutils was built with --enable-zlib (the default is not to use zlib)
and you also use static versions of modutils.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE8jTYQi4UHNye0ZOoRAnnhAKCrNZ2l8i1JHEVY3fJBnGYrpqAEBgCcDM0q
tPtmhPq2fdJODlfzLlAatmU=
=8r7c
-----END PGP SIGNATURE-----


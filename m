Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272758AbRILLSC>; Wed, 12 Sep 2001 07:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272755AbRILLRw>; Wed, 12 Sep 2001 07:17:52 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:16139 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S272749AbRILLRj>;
	Wed, 12 Sep 2001 07:17:39 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Distributors: /lib/modules/`uname -r`/pcmcia will be removed
Date: Wed, 12 Sep 2001 21:17:01 +1000
Message-ID: <1633.1000293421@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Older versions of pcmcia-cs used insmod with hard coded paths, newer
versions use modprobe with just the module name and let modutils take
care of find the module.  /lib/modules/`uname -r`/pcmcia was created in
2.4 kernels as a temporary measure, to give pcmcia users a chance to
upgrade their packages.  Alas, I found a distribution with a pcmcia
install script that uses insmod and a hard coded pathname.  That will
fail in kernel 2.5, /lib/modules/`uname -r`/pcmcia will not exist.  It
will also fail in kernel 2.4 for anybody testing kbuild 2.5.

There is never a good reason to use insmod or hard code a pathname for
standard kernel modules in 2.4 onwards.  Use modprobe and let modutils
do the work.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE7n0Qri4UHNye0ZOoRAm5cAJ9eY6c/9zJMMaKXpYSsOIFya6FcuQCgsGVC
WCMppjaEUY/taKdavWOdYtk=
=0KGB
-----END PGP SIGNATURE-----


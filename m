Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUGXXCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUGXXCa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 19:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUGXXC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 19:02:29 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:26605 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S263024AbUGXXCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 19:02:21 -0400
Message-ID: <4102EA75.2060109@g-house.de>
Date: Sun, 25 Jul 2004 01:02:13 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: unable to compile latest 2.6-BK with gcc-3.5 
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi,

although i've seen quite a few issues and fixes with gcc-3.5 on lkml, i
don't know how many of them (the fixes) made it to the current tree, as
i am not able to compile a current linux-2.6-BK tree (updated today).
below is the console output, a nicer view is here (without the line-breaks):

http://www.nerdbynature.de/bits/prinz/gcc-3.5/gcc-3.5_linux-2.6-BK.log


this is done with:

evil@prinz:/usr/src/linux-2.6-BK$ gcc --version
gcc (GCC) 3.5.0 20040718 (experimental) (Debian 3.5-0pre0)
Copyright (C) 2004 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

evil@prinz:/usr/src/linux-2.6-BK$ ld -V
GNU ld version 2.14.90.0.7 20031029 Debian GNU/Linux
  Supported emulations:
   elf_i386
   i386linux
   elf_x86_64

...on debian/unstable (i386)

Thanks,
Christian.

- ---------------------
evil@prinz:/usr/src/linux-2.6-BK$ make mrproper && make V=1 config
  CLEAN   scripts/package
make -f scripts/Makefile.build obj=scripts/basic
  gcc -Wp,-MD,scripts/basic/.fixdep.d -Wall -Wstrict-prototypes -O2
- -fomit-frame-pointer        -o scripts/basic/fixdep scripts/basic/fixdep.c
  gcc -Wp,-MD,scripts/basic/.split-include.d -Wall -Wstrict-prototypes
- -O2 -fomit-frame-pointer        -o scripts/basic/split-include
scripts/basic/split-include.c
  gcc -Wp,-MD,scripts/basic/.docproc.d -Wall -Wstrict-prototypes -O2
- -fomit-frame-pointer        -o scripts/basic/docproc
scripts/basic/docproc.c
make -f scripts/Makefile.build obj=scripts/kconfig config
  cat scripts/kconfig/zconf.tab.h_shipped > scripts/kconfig/zconf.tab.h
  gcc -Wp,-MD,scripts/kconfig/.conf.o.d -Wall -Wstrict-prototypes -O2
- -fomit-frame-pointer       -c -o scripts/kconfig/conf.o
scripts/kconfig/conf.c
  gcc -Wp,-MD,scripts/kconfig/.mconf.o.d -Wall -Wstrict-prototypes -O2
- -fomit-frame-pointer       -c -o scripts/kconfig/mconf.o
scripts/kconfig/mconf.c
scripts/kconfig/mconf.c:91: error: static declaration of 'current_menu'
follows non-static declaration
scripts/kconfig/lkc.h:63: error: previous declaration of 'current_menu'
was here
make[1]: *** [scripts/kconfig/mconf.o] Error 1
make: *** [config] Error 2

- --
BOFH excuse #67:

descramble code needed from software company
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBAup0+A7rjkF8z0wRAtIbAKCIoSg4FI7baF0TIjUWRnR3bWJyeQCgt97e
R0ni0KLbVrWL5vJB78v8wJw=
=Qr2E
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWJARfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWJARfE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 13:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWJARfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 13:35:02 -0400
Received: from mx2.mail.ru ([194.67.23.122]:59149 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S932114AbWJARfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 13:35:01 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18: qconf.moc does not get rebuilt in separate build directory
Date: Sun, 1 Oct 2006 21:34:52 +0400
User-Agent: KMail/1.9.4
Cc: sam@ravnborg.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610012134.53322.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I am not sure what happened; but at some point it refused to do xconfig. This 
is vanilla 2.6.18.

{pts/1}% LC_ALL=C make -C $PWD O=$HOME/build/linux-2.6.18 V=1 xconfig
make: Entering directory `/home/bor/src/linux-git'
make -C /home/bor/build/linux-2.6.18 \
        KBUILD_SRC=/home/bor/src/linux-git \
        KBUILD_EXTMOD="" -f /home/bor/src/linux-git/Makefile xconfig
make -f /home/bor/src/linux-git/scripts/Makefile.build obj=scripts/basic
/bin/sh /home/bor/src/linux-git/scripts/mkmakefile \
            /home/bor/src/linux-git /home/bor/build/linux-2.6.18 2 6
  GEN     /home/bor/build/linux-2.6.18/Makefile
mkdir -p include/linux include/config
make -f /home/bor/src/linux-git/scripts/Makefile.build obj=scripts/kconfig 
xconfig
  
g++ -Wp,-MD,scripts/kconfig/.qconf.o.d -Iscripts/kconfig -O2 -DQT_SHARED -DQT_NO_DEBUG -DQT_THREAD_SUPPORT -D_REENTRANT  -I/usr/lib/qt3//include -D 
LKC_DIRECT_LINK -c -o 
scripts/kconfig/qconf.o /home/bor/src/linux-git/scripts/kconfig/qconf.cc
/home/bor/src/linux-git/scripts/kconfig/qconf.cc:30:21: error: qconf.moc: No 
such file or directory
make[2]: *** [scripts/kconfig/qconf.o] Error 1
make[1]: *** [xconfig] Error 2
make: *** [xconfig] Error 2
make: Leaving directory `/home/bor/src/linux-git'

{pts/1}% make --version
GNU Make 3.81
Copyright (C) 2006  Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

This program built for i586-mandriva-linux-gnu

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFH/w9R6LMutpd94wRAhgNAKDA2X/PB11xaOgqdtJNg1O1iYUH7wCfTA1G
gA8hEszsWC5h087/+5smJTI=
=kLj4
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVGQIQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVGQIQR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 04:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVGQIQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 04:16:17 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:17166 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261180AbVGQIQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 04:16:16 -0400
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org, blaisorblade@yahoo.it, jdike@addtoit.com
Subject: UML build broken on 2.6.13-rc3-mm1
Message-Id: <E1Du4JM-0004dH-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 17 Jul 2005 10:15:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following build failure on 2.6.13-rc3-mm1.  It builds fine
on 2.6.13-rc3.

Can anybody help fixing it?

Thanks,
Miklos
  
/usr/src/quilt/linux$ make ARCH=um V=1
if test ! /usr/src/quilt/linux -ef /usr/src/quilt/linux; then \
/bin/sh /usr/src/quilt/linux/scripts/mkmakefile              \
    /usr/src/quilt/linux /usr/src/quilt/linux 2 6         \
    > /usr/src/quilt/linux/Makefile;                                 \
    echo '  GEN    /usr/src/quilt/linux/Makefile';                   \
fi
  CHK     include/linux/version.h
rm -rf .tmp_versions
mkdir -p .tmp_versions
make -f scripts/Makefile.build obj=scripts/basic
make -f scripts/Makefile.build obj= /mk_sc
scripts/Makefile.build:13: /Makefile: No such file or directory
scripts/Makefile.build:64: kbuild: Makefile.build is included improperly
make[1]: *** No rule to make target `/Makefile'.  Stop.
make: *** [/mk_sc] Error 2

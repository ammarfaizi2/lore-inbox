Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbTKPTcu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 14:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTKPTcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 14:32:50 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:30983 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S263173AbTKPTcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 14:32:48 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9 - make xconfig fails for buildtree != srctree
Date: Sun, 16 Nov 2003 22:20:17 +0300
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311162220.17245.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

{pts/0}% ./makelinux V=1 xconfig
make: Entering directory `/home/bor/src/linux-2.6.0-test9'
make -C /home/bor/build/linux-2.6.0-test9               \
KBUILD_SRC=/home/bor/src/linux-2.6.0-test9      KBUILD_VERBOSE=1        \
KBUILD_CHECK= -f /home/bor/src/linux-2.6.0-test9/Makefile xconfig
make -f /home/bor/src/linux-2.6.0-test9/scripts/Makefile.build obj=scripts 
scripts/fixdep
make[2]: `scripts/fixdep' is up to date.
make -f /home/bor/src/linux-2.6.0-test9/scripts/Makefile.build 
obj=scripts/kconfig xconfig
  g++ -Wp,-MD,scripts/kconfig/.qconf.o.d  -O2  
-I/home/bor/src/linux-2.6.0-test9//usr/lib/qt3//include -c -o 
scripts/kconfig/qconf.o 
/home/bor/src/linux-2.6.0-test9/scripts/kconfig/qconf.cc
/home/bor/src/linux-2.6.0-test9/scripts/kconfig/qconf.cc:6:26: qapplication.h: 
No such file or directory

apparently it prepends $(srctree) (or just $(src)) to Qt include path, but I 
failed to see where.

-andrey


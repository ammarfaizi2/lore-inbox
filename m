Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbTEIG0Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 02:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbTEIG0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 02:26:25 -0400
Received: from mh.bit.edu.cn ([202.204.80.6]:21733 "EHLO bit.edu.cn")
	by vger.kernel.org with ESMTP id S262307AbTEIG0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 02:26:24 -0400
From: Kang Kai <kkai@bit.edu.cn>
To: lkml <linux-kernel@vger.kernel.org>
Subject: failed to  "make xconfig" after patching patch-2.4.21-rc2.bz2
Date: Fri, 9 May 2003 14:39:15 +0800
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305091439.15319.kkai@bit.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all..
I just patched a new fresh linux-2.4.20 with patch-2.4.21-rc2.bz2.
But  I failed to  "make xconfig", the error is:

rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.4.20/scripts'
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkparse.o 
tkparse.cgcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o 
tkcond.o tkcond.c
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkgen.o tkgen.c
gcc -o tkparse tkparse.o tkcond.o tkgen.o
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
drivers/ide/Config.in: 46: can't handle dep_bool/dep_mbool/dep_tristate 
condition
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.20/scripts'
make: *** [xconfig] Error 2

K.

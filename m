Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbTEAPOg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 11:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbTEAPOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 11:14:36 -0400
Received: from smtp.inet.fi ([192.89.123.192]:9674 "EHLO smtp.inet.fi")
	by vger.kernel.org with ESMTP id S261358AbTEAPOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 11:14:35 -0400
From: Kimmo Sundqvist <rabbit80@mbnet.fi>
Organization: Unorganized
To: linux-kernel@vger.kernel.org
Subject: 2.5.68-mm3 and a simple mistake
Date: Thu, 1 May 2003 18:26:31 +0300
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305011826.31389.rabbit80@mbnet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What have I done wrong?

This is Debian 3.0r1.  I am running 2.5.68-osdl2 and decided to try 
2.5.68-mm3.  I did tar -xvf with linux-2.5.68.tar in /usr/src, then bunzipped 
2.5.68-mm3.bz2 in /usr/src.  Before beginning this, I had removed the 2.5.68 
directory I had used with compiling -osdl2, so the linux-2.5.68 dir was 
fresh.  I did "patch -p0 < 2.5.68-mm3" which went through fine.  I configured 
it to my liking, and since this is Debian, did "make-kpkg -rev dp1 
kernel_image" (dp = dual processor, as opposed to my little brother's old 
Pentium 133).  That had worked with 2.5.68-osdl2, but now I got:

*
* Library routines
*
CRC32 functions (CRC32) [M/n/y/?] m
make[1]: Leaving directory `/usr/src/linux-2.5.68'
/usr/bin/make -f ./debian/rules dummy_do_dep
make[1]: Entering directory `/usr/src/linux-2.5.68'
/usr/bin/make    \
                                 ARCH=i386  dep
make[2]: Entering directory `/usr/src/linux-2.5.68'
*** Warning: make dep is unnecessary now.
make[2]: Leaving directory `/usr/src/linux-2.5.68'
make[1]: Leaving directory `/usr/src/linux-2.5.68'
/usr/bin/make    \
                                 ARCH=i386 clean
make[1]: Entering directory `/usr/src/linux-2.5.68'
/usr/bin/make -f scripts/Makefile.clean obj=arch/i386/boot
/usr/bin/make -f scripts/Makefile.clean obj=arch/i386/boot/compressed
/usr/bin/make -f scripts/Makefile.clean obj=arch/i386/kernel
/usr/bin/make -f scripts/Makefile.clean obj=arch/i386/kernel/acpi
/usr/bin/make -f scripts/Makefile.clean obj=arch/i386/kernel/cpu
/usr/bin/make -f scripts/Makefile.clean obj=arch/i386/kernel/cpu/cpufreq
/usr/bin/make -f scripts/Makefile.clean obj=arch/i386/kernel/cpu/mcheck
/usr/bin/make -f scripts/Makefile.clean obj=arch/i386/kernel/cpu/mtrr
/usr/bin/make -f scripts/Makefile.clean obj=arch/i386/kernel/timers
/usr/bin/make -f scripts/Makefile.clean obj=arch/i386/lib
/usr/bin/make -f scripts/Makefile.clean obj=arch/i386/mach-default
/usr/bin/make -f scripts/Makefile.clean obj=arch/i386/mach-generic
scripts/Makefile.clean:10: arch/i386/mach-generic/Makefile: No such file or 
directory
make[2]: *** No rule to make target `arch/i386/mach-generic/Makefile'.  Stop.
make[1]: *** [_clean_arch/i386/mach-generic] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.68'
make: *** [stamp-kernel-configure] Error 2

I know the personal helpdesk stuff, but I seriously suspect there's an issue 
someone else might also run into.

gcc version 2.95.4 20011002 (Debian prerelease)

The patch was downloaded today (1st of May) afternoon (EEST) from:
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.68/2.5.68-mm3/

-Kimmo Sundqvist

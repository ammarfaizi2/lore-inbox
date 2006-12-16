Return-Path: <linux-kernel-owner+w=401wt.eu-S1753669AbWLPNUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669AbWLPNUR (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 08:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753674AbWLPNUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 08:20:16 -0500
Received: from mail.trixing.net ([87.230.125.58]:32936 "EHLO mail.trixing.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753669AbWLPNUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 08:20:15 -0500
X-Greylist: delayed 2554 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 08:20:14 EST
Message-ID: <4583E888.8030302@l4x.org>
Date: Sat, 16 Dec 2006 13:37:28 +0100
From: Jan Dittmer <jdi@l4x.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061116 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, sam@ravnborg.org
References: <20061214225913.3338f677.akpm@osdl.org>
In-Reply-To: <20061214225913.3338f677.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.1.37
X-SA-Exim-Mail-From: jdi@l4x.org
Subject: (Cross) compiling fails on first try (was Re: 2.6.20-rc1-mm1)
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 14:12:04 +0200)
X-SA-Exim-Scanned: Yes (on mail.trixing.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any ideas? Happens only on some archs (not affected is alpha, i386, ia64, sparc,
sparc64). Happens not with 2.6.19(.1). See http://l4x.org/k/ for more logs.
2.6.20-rc1 is also affected.


# make HOSTCC=gcc-3.4 ARCH=um CROSS_COMPILE= CROSS32_COMPILE= O=/tmp/tmp.abUIc11429/out/um defconfig
 <cut>
# make HOSTCC=gcc-3.4 ARCH=um CROSS_COMPILE= CROSS32_COMPILE= O=/tmp/tmp.abUIc11429/out/um
  GEN     /tmp/tmp.abUIc11429/out/um/Makefile
scripts/kconfig/conf -s arch/um/Kconfig
  MKDIR /tmp/tmp.abUIc11429/out/um/arch/um/include
  SYMLINK arch/um/include/kern_constants.h
  SYMLINK include/asm-um/arch
  SYMLINK arch/um/include/sysdep
  SYMLINK arch/um/os
  SYMLINK include/asm-um/archparam.h
  SYMLINK include/asm-um/system.h
  SYMLINK include/asm-um/sigcontext.h
  SYMLINK include/asm-um/processor.h
  SYMLINK include/asm-um/ptrace.h
  SYMLINK include/asm-um/module.h
  SYMLINK include/asm-um/vm-flags.h
  SYMLINK include/asm-um/elf.h
  SYMLINK include/asm-um/host_ldt.h
  CHK     arch/um/include/uml-config.h
  UPD     arch/um/include/uml-config.h
  CC      arch/um/sys-x86_64/user-offsets.s
  CHK     arch/um/include/user_constants.h
  UPD     arch/um/include/user_constants.h
  Using /tmp/x as source for kernel
  GEN     /tmp/tmp.abUIc11429/out/um/Makefile
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CHK     include/linux/utsrelease.h
"2.6.20-rc1-mm1cat:include/config/kernel.release:Nosuchfileordirectory" exceeds 64 characters
make[1]: *** [include/linux/utsrelease.h] Error 1
make: *** [_all] Error 2

# make HOSTCC=gcc-3.4 ARCH=um CROSS_COMPILE= CROSS32_COMPILE= O=/tmp/tmp.abUIc11429/out/um
  SYMLINK arch/um/include/kern_constants.h
  SYMLINK arch/um/include/sysdep
make[2]: `arch/um/sys-x86_64/user-offsets.s' is up to date.
  Using /tmp/x as source for kernel
  GEN     /tmp/tmp.abUIc11429/out/um/Makefile
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     include/linux/utsrelease.h
  UPD     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-um
  CC      arch/um/kernel/asm-offsets.s
  GEN     include/asm-um/asm-offsets.h
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/bin2c
  CC      init/main.o
  CC      init/version.o
  CC      init/do_mounts.o
  LD      init/mounts.o
  CC      init/noinitramfs.o


Thanks,

Jan

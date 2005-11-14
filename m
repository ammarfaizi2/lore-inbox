Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbVKNKD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbVKNKD4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 05:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbVKNKD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 05:03:56 -0500
Received: from www.postmet.com.128.244.195.in-addr.arpa ([195.244.128.17]:20872
	"HELO mail.postmet.com") by vger.kernel.org with SMTP
	id S1751063AbVKNKDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 05:03:55 -0500
Subject: PROBLEM:kernel complilation
From: Alexander Kozyrev <ceo@postmet.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: PostMet Corporation
Message-Id: <1131962621.7294.20.camel@sis1700.postmet.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 14 Nov 2005 12:03:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1)[root@asterisk1 linux-2.6.9-11.EL]# uname -a
Linux asterisk1.local 2.6.9-11.EL #1 Wed Jun 8 16:59:52 CDT 2005 i686
i686 i386 GNU/Linux


2) [root@asterisk1 linux-2.6.9-11.EL]# cat /proc/version
Linux version 2.6.9-11.EL (buildcentos@build1.hughesjr.centos.org) (gcc
version 3.4.3 20050227 (Red Hat 3.4.3-22)) #1 Wed Jun 8 16:59:52 CDT
2005

3) Problem with kernel/built-in.o! No any files (and built-in.o) in dir
kernel.

<....>
  gcc -Wp,-MD,arch/i386/lib/.usercopy.o.d -nostdinc -iwithprefix include
-D__KERNEL__ -Iinclude -Iinclude2 -I/usr/src/linux-2.6.9-11.EL/include
-I/usr/src/linux-2.6.9-11.EL/arch/i386/lib -Iarch/i386/lib -Wall
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Os
-fomit-frame-pointer -g -Wdeclaration-after-statement -pipe -msoft-float
-m32 -fno-builtin-sprintf -fno-builtin-log2 -fno-builtin-puts
-mpreferred-stack-boundary=2 -fno-unit-at-a-time -march=pentium3
-I/usr/src/linux-2.6.9-11.EL/include/asm-i386/mach-default
-Iinclude/asm-i386/mach-default  -DKBUILD_BASENAME=usercopy
-DKBUILD_MODNAME=usercopy -c -o arch/i386/lib/.tmp_usercopy.o
/usr/src/linux-2.6.9-11.EL/arch/i386/lib/usercopy.c
  rm -f arch/i386/lib/lib.a; ar  rcs arch/i386/lib/lib.a
arch/i386/lib/bitops.o arch/i386/lib/checksum.o arch/i386/lib/delay.o
arch/i386/lib/getuser.o arch/i386/lib/memcpy.o arch/i386/lib/strstr.o
arch/i386/lib/usercopy.o
  set -e; . /usr/src/linux-2.6.9-11.EL/scripts/mkversion > .tmp_version;
mv -f .tmp_version .version; make -f
/usr/src/linux-2.6.9-11.EL/scripts/Makefile.build obj=init
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  gcc -Wp,-MD,init/.version.o.d -nostdinc -iwithprefix include
-D__KERNEL__ -Iinclude -Iinclude2 -I/usr/src/linux-2.6.9-11.EL/include
-I/usr/src/linux-2.6.9-11.EL/init -Iinit -Wall -Wstrict-prototypes
-Wno-trigraphs -fno-strict-aliasing -fno-common -Os -fomit-frame-pointer
-g -Wdeclaration-after-statement -pipe -msoft-float -m32
-fno-builtin-sprintf -fno-builtin-log2 -fno-builtin-puts
-mpreferred-stack-boundary=2 -fno-unit-at-a-time -march=pentium3
-I/usr/src/linux-2.6.9-11.EL/include/asm-i386/mach-default
-Iinclude/asm-i386/mach-default  -DKBUILD_BASENAME=version
-DKBUILD_MODNAME=version -c -o init/.tmp_version.o
/usr/src/linux-2.6.9-11.EL/init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o
init/mounts.o init/initramfs.o
  ld -m elf_i386  -o .tmp_vmlinux1 -T arch/i386/kernel/vmlinux.lds
arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o
--start-group  usr/built-in.o  arch/i386/kernel/built-in.o 
arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o 
arch/i386/crypto/built-in.o  kernel/built-in.o  mm/built-in.o 
fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o 
lib/lib.a  arch/i386/lib/lib.a  lib/built-in.o 
arch/i386/lib/built-in.o  drivers/built-in.o  sound/built-in.o 
arch/i386/pci/built-in.o  arch/i386/power/built-in.o  net/built-in.o
--end-group
ld: kernel/built-in.o: No such file: No such file or directory
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [_all] Error 2

4) Was tried:

[root@asterisk1 linux-2.6.9-11.EL]# make  V=1 kernel/
O=/usr/src/kernels/custom
make -C /usr/src/kernels/custom         \
KBUILD_SRC=/usr/src/linux-2.6.9-11.EL        KBUILD_VERBOSE=1   \
KBUILD_CHECK= KBUILD_EXTMOD=""  \
        -f /usr/src/linux-2.6.9-11.EL/Makefile kernel/
make -f /usr/src/linux-2.6.9-11.EL/scripts/Makefile.build
obj=scripts/basic
make -f /usr/src/linux-2.6.9-11.EL/scripts/Makefile.build obj=scripts
make -f /usr/src/linux-2.6.9-11.EL/scripts/Makefile.build
obj=scripts/genksyms
make -f /usr/src/linux-2.6.9-11.EL/scripts/Makefile.build
obj=scripts/mod
  CHK     include/linux/version.h
make -f /usr/src/linux-2.6.9-11.EL/scripts/Makefile.build
obj=arch/i386/kernel arch/i386/kernel/asm-offsets.s
make[2]: `arch/i386/kernel/asm-offsets.s' is up to date.
make KBUILD_MODULES=1 -f
/usr/src/linux-2.6.9-11.EL/scripts/Makefile.build obj=kernel

5) Tried one more time:
[root@asterisk1 linux-2.6.9-11.EL]# make  V=1 O=/usr/src/kernels/custom
make -C /usr/src/kernels/custom         \
KBUILD_SRC=/usr/src/linux-2.6.9-11.EL        KBUILD_VERBOSE=1   \
KBUILD_CHECK= KBUILD_EXTMOD=""  \
        -f /usr/src/linux-2.6.9-11.EL/Makefile _all
if /usr/bin/env test ! /usr/src/linux-2.6.9-11.EL -ef
/usr/src/kernels/custom; then \
/bin/sh /usr/src/linux-2.6.9-11.EL/scripts/mkmakefile              \
    /usr/src/linux-2.6.9-11.EL /usr/src/kernels/custom 2 6         \
    > /usr/src/kernels/custom/Makefile;                                
\
fi
  Using /usr/src/linux-2.6.9-11.EL as source for kernel
if [ -h /usr/src/linux-2.6.9-11.EL/include/asm -o -f
/usr/src/linux-2.6.9-11.EL/.config ]; then \
        echo "  /usr/src/linux-2.6.9-11.EL is not clean, please run
'make mrproper'";\
        echo "  in the '/usr/src/linux-2.6.9-11.EL' directory.";\
        /bin/false; \
fi;
if [ ! -d include2 ]; then mkdir -p include2; fi;
ln -fsn /usr/src/linux-2.6.9-11.EL/include/asm-i386 include2/asm
  CHK     include/linux/version.h
rm -rf .tmp_versions
mkdir -p .tmp_versions

-- 



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263428AbTEITmD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 15:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263434AbTEITmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 15:42:03 -0400
Received: from relay1.volja.net ([217.72.64.59]:1807 "EHLO relay1.volja.net")
	by vger.kernel.org with ESMTP id S263428AbTEITlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 15:41:55 -0400
Message-ID: <006001c31664$c7292910$9b5248d9@gregan3sx20jj1>
From: "Grega Fajdiga" <Gregor.Fajdiga@voljatel.net>
To: <linux-kernel@vger.kernel.org>
Subject: Fw: comparison between signed and unsigned warnings
Date: Fri, 9 May 2003 21:54:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Grega Fajdiga" <Gregor.Fajdiga@voljatel.net>
To: <lkml@vger.kernel.org>
Sent: Friday, May 09, 2003 9:48 PM
Subject: comparison between signed and unsigned warnings


> Good day,
>
> I'm using SUSE 8.2 with GCC 3.3 and get a lot of
> "comparison between signed and unsigned" warnings.
> This is a short excerpt:
> make -f scripts/Makefile.build obj=scripts
> make -f scripts/Makefile.build obj=scripts/genksyms
>   SPLIT   include/linux/autoconf.h -> include/config/*
> make -f scripts/Makefile.build obj=arch/i386/kernel
> arch/i386/kernel/asm-offsets.s
>
>
>
gcc -Wp,-MD,arch/i386/kernel/.asm-offsets.s.d -D__KERNEL__ -Iinclude -Wall -
>
Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
>  -mpreferred-stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-defa
ul
> t -nostdinc -iwithprefix
>
include    -DKBUILD_BASENAME=asm_offsets -DKBUILD_MODNAME=asm_offsets -S -o
> arch/i386/kernel/asm-offsets.s arch/i386/kernel/asm-offsets.c
>   CHK     include/asm-i386/asm_offsets.h
>   UPD     include/asm-i386/asm_offsets.h
>   Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
> make -f scripts/Makefile.build obj=init
>
>
>
gcc -Wp,-MD,init/.main.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stac
k-
>
boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -nostdinc -iwithp
> refix include    -DKBUILD_BASENAME=main -DKBUILD_MODNAME=main -c -o
> init/.tmp_main.o init/main.c
> scripts/fixdep init/.main.o.d init/main.o
>
'gcc -Wp,-MD,init/.main.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes
>  -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-sta
ck
> -boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -nostdinc -iwi
th
> prefix include    -DKBUILD_BASENAME=main -DKBUILD_MODNAME=main -c -o
> init/.tmp_main.o init/main.c' > init/.main.o.tmp; rm -f init/.main.o.d;
> mv -f init/.main.o.tmp init/.main.o.cmd
>   CHK     include/linux/compile.h
> dnsdomainname: Unknown host
>   UPD     include/linux/compile.h
>
>
>
gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototyp
>
es -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-sta
>
ck-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -nostdinc -iwi
> thprefix
include    -DKBUILD_BASENAME=version -DKBUILD_MODNAME=version -c -o
> init/.tmp_version.o init/version.c
> scripts/fixdep init/.version.o.d init/version.o
>
'gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototy
>
pes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-st
>
ack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -nostdinc -iw
> ithprefix
> include    -DKBUILD_BASENAME=version -DKBUILD_MODNAME=version -c -o
> init/.tmp_version.o init/version.c' > init/.version.o.tmp; rm -f
> init/.version.o.d; mv -f init/.version.o.tmp init/.version.o.cmd
>
>
>
gcc -Wp,-MD,init/.do_mounts.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-protot
>
ypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-s
>
tack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -nostdinc -i
> withprefix
> include    -DKBUILD_BASENAME=do_mounts -DKBUILD_MODNAME=mounts -c -o
> init/.tmp_do_mounts.o init/do_mounts.c
> In file included from init/do_mounts.c:9:
> include/linux/nfs_fs.h: In function `nfs_size_to_loff_t':
> include/linux/nfs_fs.h:411: warning: comparison between signed and
unsigned
> scripts/fixdep init/.do_mounts.o.d init/do_mounts.o
>
'gcc -Wp,-MD,init/.do_mounts.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-proto
>
types -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-
>
stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -nostdinc -
> iwithprefix
> include    -DKBUILD_BASENAME=do_mounts -DKBUILD_MODNAME=mounts -c -o
> init/.tmp_do_mounts.o init/do_mounts.c' > init/.do_mounts.o.tmp; rm -f
> init/.do_mounts.o.d; mv -f init/.do_mounts.o.tmp init/.do_mounts.o.cmd
>   ld -m elf_i386  -r -o init/mounts.o init/do_mounts.o
>
>
>
gcc -Wp,-MD,init/.initramfs.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-protot
>
ypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-s
>
tack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -nostdinc -i
> withprefix
> include    -DKBUILD_BASENAME=initramfs -DKBUILD_MODNAME=initramfs -c -o
> init/.tmp_initramfs.o init/initramfs.c
> init/initramfs.c: In function `flush_buffer':
> init/initramfs.c:325: warning: comparison between signed and unsigned
> In file included from init/initramfs.c:379:
> lib/inflate.c: In function `huft_build':
> lib/inflate.c:401: warning: signed and unsigned type in conditional
> expression
> In file included from init/initramfs.c:379:
> lib/inflate.c: In function `makecrc':
> lib/inflate.c:1034: warning: comparison between signed and unsigned
> lib/inflate.c: In function `gunzip':
> lib/inflate.c:1169: warning: comparison between signed and unsigned
> scripts/fixdep init/.initramfs.o.d init/initramfs.o
>
'gcc -Wp,-MD,init/.initramfs.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-proto
>
types -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-
>
stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -nostdinc -
> iwithprefix
> include    -DKBUILD_BASENAME=initramfs -DKBUILD_MODNAME=initramfs -c -o
> init/.tmp_initramfs.o init/initramfs.c' > init/.initramfs.o.tmp; rm -f
> init/.initramfs.o.d; mv -f init/.initramfs.o.tmp init/.initramfs.o.cmd
>    ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o
> init/mounts.o init/initramfs.o
> make -f scripts/Makefile.build obj=usr
>
>
>
gcc -Wp,-MD,usr/.gen_init_cpio.d -Wall -Wstrict-prototypes -O2 -fomit-frame-
> pointer    -o usr/gen_init_cpio usr/gen_init_cpio.c
>   ./usr/gen_init_cpio > usr/initramfs_data.cpio
>   gzip -f -9 < usr/initramfs_data.cpio > usr/initramfs_data.cpio.gz
>   ld -m elf_i386  --format binary --oformat elf32-i386 -r -T
> usr/initramfs_data.scr usr/initramfs_data.cpio.gz -o usr/initramfs_data.o
>    ld -m elf_i386  -r -o usr/built-in.o usr/initramfs_data.o
> make -f scripts/Makefile.build obj=arch/i386/kernel
>
>
>
gcc -Wp,-MD,arch/i386/kernel/.process.o.d -D__KERNEL__ -Iinclude -Wall -Wstr
>
ict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mp
>
referred-stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -n
> ostdinc -iwithprefix
> include    -DKBUILD_BASENAME=process -DKBUILD_MODNAME=process -c -o
> arch/i386/kernel/.tmp_process.o arch/i386/kernel/process.c
> scripts/fixdep arch/i386/kernel/.process.o.d arch/i386/kernel/process.o
>
'gcc -Wp,-MD,arch/i386/kernel/.process.o.d -D__KERNEL__ -Iinclude -Wall -Wst
>
rict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -m
>
preferred-stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -
> nostdinc -iwithprefix
> include    -DKBUILD_BASENAME=process -DKBUILD_MODNAME=process -c -o
> arch/i386/kernel/.tmp_process.o arch/i386/kernel/process.c' >
> arch/i386/kernel/.process.o.tmp; rm -f arch/i386/kernel/.process.o.d;
mv -f
> arch/i386/kernel/.process.o.tmp arch/i386/kernel/.process.o.cmd
>
>
>
gcc -Wp,-MD,arch/i386/kernel/.semaphore.o.d -D__KERNEL__ -Iinclude -Wall -Ws
>
trict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -
>
mpreferred-stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default
> -nostdinc -iwithprefix
> include    -DKBUILD_BASENAME=semaphore -DKBUILD_MODNAME=semaphore -c -o
> arch/i386/kernel/.tmp_semaphore.o arch/i386/kernel/semaphore.c
> scripts/fixdep arch/i386/kernel/.semaphore.o.d
arch/i386/kernel/semaphore.o
>
'gcc -Wp,-MD,arch/i386/kernel/.semaphore.o.d -D__KERNEL__ -Iinclude -Wall -W
>
strict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
> -mpreferred-stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-defau
lt
>  -nostdinc -iwithprefix
> include    -DKBUILD_BASENAME=semaphore -DKBUILD_MODNAME=semaphore -c -o
> arch/i386/kernel/.tmp_semaphore.o arch/i386/kernel/semaphore.c' >
> arch/i386/kernel/.semaphore.o.tmp; rm -f arch/i386/kernel/.semaphore.o.d;
> mv -f arch/i386/kernel/.semaphore.o.tmp arch/i386/kernel/.semaphore.o.cmd
>
>
>
gcc -Wp,-MD,arch/i386/kernel/.signal.o.d -D__KERNEL__ -Iinclude -Wall -Wstri
>
ct-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpr
>
eferred-stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -no
> stdinc -iwithprefix
> include    -DKBUILD_BASENAME=signal -DKBUILD_MODNAME=signal -c -o
> arch/i386/kernel/.tmp_signal.o arch/i386/kernel/signal.c
> arch/i386/kernel/signal.c: In function `setup_frame':
> arch/i386/kernel/signal.c:351: warning: signed and unsigned type in
> conditional expression
> arch/i386/kernel/signal.c:351: warning: signed and unsigned type in
> conditional expression
> arch/i386/kernel/signal.c:351: warning: signed and unsigned type in
> conditional expression
> arch/i386/kernel/signal.c:351: warning: signed and unsigned type in
> conditional expression
> arch/i386/kernel/signal.c: In function `setup_rt_frame':
> arch/i386/kernel/signal.c:428: warning: signed and unsigned type in
> conditional expression
> arch/i386/kernel/signal.c:428: warning: signed and unsigned type in
> conditional expression
> arch/i386/kernel/signal.c:428: warning: signed and unsigned type in
> conditional expression
> arch/i386/kernel/signal.c:428: warning: signed and unsigned type in
> conditional expression
> scripts/fixdep arch/i386/kernel/.signal.o.d arch/i386/kernel/signal.o
>
'gcc -Wp,-MD,arch/i386/kernel/.signal.o.d -D__KERNEL__ -Iinclude -Wall -Wstr
>
ict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mp
>
referred-stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -n
> ostdinc -iwithprefix
> include    -DKBUILD_BASENAME=signal -DKBUILD_MODNAME=signal -c -o
> arch/i386/kernel/.tmp_signal.o arch/i386/kernel/signal.c' >
> arch/i386/kernel/.signal.o.tmp; rm -f arch/i386/kernel/.signal.o.d; mv -f
> arch/i386/kernel/.signal.o.tmp arch/i386/kernel/.signal.o.cmd
>
>
>
gcc -Wp,-MD,arch/i386/kernel/.entry.o.d -D__ASSEMBLY__ -D__KERNEL__ -Iinclud
> e -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix
> nclude  -traditional  -c -o arch/i386/kernel/entry.o
> arch/i386/kernel/entry.S
>
>
>
gcc -Wp,-MD,arch/i386/kernel/.traps.o.d -D__KERNEL__ -Iinclude -Wall -Wstric
>
t-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpre
>
ferred-stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -nos
> tdinc -iwithprefix
> include    -DKBUILD_BASENAME=traps -DKBUILD_MODNAME=traps -c -o
> arch/i386/kernel/.tmp_traps.o arch/i386/kernel/traps.c
> arch/i386/kernel/traps.c: In function `show_registers':
> arch/i386/kernel/traps.c:198: warning: comparison between signed and
> unsigned
> scripts/fixdep arch/i386/kernel/.traps.o.d arch/i386/kernel/traps.o
>
'gcc -Wp,-MD,arch/i386/kernel/.traps.o.d -D__KERNEL__ -Iinclude -Wall -Wstri
>
ct-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpr
>
eferred-stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -no
> stdinc -iwithprefix
> include    -DKBUILD_BASENAME=traps -DKBUILD_MODNAME=traps -c -o
> arch/i386/kernel/.tmp_traps.o arch/i386/kernel/traps.c' >
> arch/i386/kernel/.traps.o.tmp; rm -f arch/i386/kernel/.traps.o.d; mv -f
> arch/i386/kernel/.traps.o.tmp arch/i386/kernel/.traps.o.cmd
>
>
>
gcc -Wp,-MD,arch/i386/kernel/.irq.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-
>
prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mprefe
>
rred-stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -nostd
> inc -iwithprefix
include    -DKBUILD_BASENAME=irq -DKBUILD_MODNAME=irq -c -o
> arch/i386/kernel/.tmp_irq.o arch/i386/kernel/irq.c
> make[1]: *** [arch/i386/kernel/irq.o] Interrupt
> make: *** [arch/i386/kernel] Interrupt
>
> What can I do to make these warnings disappear?
>
> Please CC me.
> Thanks,
> Grega
>


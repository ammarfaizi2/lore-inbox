Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285630AbSALKkb>; Sat, 12 Jan 2002 05:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285666AbSALKkV>; Sat, 12 Jan 2002 05:40:21 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:261 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S285630AbSALKkL>;
	Sat, 12 Jan 2002 05:40:11 -0500
To: linux-kernel@vger.kernel.org, linux390@de.ibm.com
Subject: S/390: compile errors with 2.4.18-pre3
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-No-Archive: yes
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Saddam Hussein Gaddafi BND BKA Bombe Waffen Terror DES PGP
From: Jochen Hein <jochen@jochen.org>
Date: Sat, 12 Jan 2002 11:40:36 +0100
Message-ID: <871ygvj1i3.fsf@delphi.lan-ks.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Common Lisp,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got the following compile errors with 2.4.18-pre3:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -fno-strength-reduce   -DKBUILD_BASENAME=s390_ksyms  -DEXPORT_SYMTAB -c s390_ksyms.c
s390_ksyms.c:61: `do_call_softirq' undeclared here (not in a function)
s390_ksyms.c:61: initializer element is not constant
s390_ksyms.c:61: (near initialization for `__ksymtab_do_call_softirq.value')
make[1]: *** [s390_ksyms.o] Error 1
make[1]: Leaving directory `/usr/src/linux/arch/s390/kernel'
make: *** [_dir_arch/s390/kernel] Error 2

and:

make[1]: Leaving directory `/usr/src/linux/arch/s390/math-emu'
ld -m elf_s390 -T /usr/src/linux/arch/s390/vmlinux.lds -e start arch/s390/kernel/head.o arch/s390/kernel/init_task.o init/main.o init/version.o \
	--start-group \
	arch/s390/mm/mm.o arch/s390/kernel/kernel.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	 drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/net/tokenring/tr.o drivers/s390/io.o \
	net/network.o \
	/usr/src/linux/arch/s390/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/s390/lib/lib.a \
	--end-group \
	-o vmlinux
drivers/s390/io.o: In function `fs3270_devfs_register':
drivers/s390/io.o(.text+0x20f74): undefined reference to `tty_register_devfs_name'
make: *** [vmlinux] Error 1

This is with CONFIG_DEVFS_FS=y

Jochen

-- 
#include <~/.signature>: permission denied



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263222AbSJCKOc>; Thu, 3 Oct 2002 06:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263223AbSJCKOc>; Thu, 3 Oct 2002 06:14:32 -0400
Received: from uranus.lan-ks.de ([194.45.71.1]:779 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S263222AbSJCKOb> convert rfc822-to-8bit;
	Thu, 3 Oct 2002 06:14:31 -0400
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5.40] more compile errors (IrDA, Token Ring)
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Thu, 03 Oct 2002 12:11:01 +0200
Message-ID: <87y99fq1ca.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got:

Link error, Token Ring related (my employer still uses Token Ring):

make[1]: Entering directory `/usr/src/linux-2.5.40/init'
  Generating /usr/src/linux-2.5.40/include/linux/compile.h (updated)
    gcc -Wp,-MD,./.version.o.d -D__KERNEL__ -I/usr/src/linux-2.5.40/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version   -c -o version.o version.c
       ld -m elf_i386  -r -o built-in.o main.o version.o do_mounts.o
       make[1]: Leaving directory `/usr/src/linux-2.5.40/init'
               ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o kernel/built-in.o mm/built-in.o fs/built-in.o ipc/built-in.o security/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o
	       arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
	       net/built-in.o: In function `p8022_request':
	       net/built-in.o(.text+0xdb69): undefined reference to `llc_build_and_send_ui_pkt'
	       net/built-in.o: In function `register_8022_client':
	       net/built-in.o(.text+0xdbb2): undefined reference to `llc_sap_open'
	       net/built-in.o: In function `unregister_8022_client':
	       net/built-in.o(.text+0xdbde): undefined reference to `llc_sap_close'
	       net/built-in.o: In function `snap_request':
	       net/built-in.o(.text+0xdd10): undefined reference to `llc_build_and_send_ui_pkt'
	       net/built-in.o: In function `snap_init':
	       net/built-in.o(.text.init+0x58b): undefined reference to `llc_sap_open'
	       make: *** [vmlinux] Fehler 1

Compile-Error, IRDA-related:

  gcc -Wp,-MD,./.ircomm_tty_ioctl.o.d -D__KERNEL__ -I/usr/src/linux-2.5.40/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
  -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=ircomm_tty_ioctl   -c -o ircomm_tty_ioctl.o ircomm_tty_ioctl.c
    gcc -Wp,-MD,./.ircomm_param.o.d -D__KERNEL__ -I/usr/src/linux-2.5.40/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=ircomm_param   -c -o ircomm_param.o ircomm_param.c
    net/irda/ircomm/ircomm_param.c: In function `ircomm_param_request':
    net/irda/ircomm/ircomm_param.c:169: warning: implicit declaration of function `queue_task'
    net/irda/ircomm/ircomm_param.c:169: `tq_immediate' undeclared (first use in this function)
    net/irda/ircomm/ircomm_param.c:169: (Each undeclared identifier is reported only once
    net/irda/ircomm/ircomm_param.c:169: for each function it appears in.)
    net/irda/ircomm/ircomm_param.c:170: warning: implicit declaration of function `mark_bh'
    net/irda/ircomm/ircomm_param.c:170: `IMMEDIATE_BH' undeclared (first use in this function)

With both disabled, I get a kernel image and will try that.

Jochen

-- 
Wenn Du nicht weiﬂt was Du tust, tu's mit Eleganz.

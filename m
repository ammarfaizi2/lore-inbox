Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267187AbTBDIol>; Tue, 4 Feb 2003 03:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267183AbTBDIol>; Tue, 4 Feb 2003 03:44:41 -0500
Received: from postoffice2.mail.cornell.edu ([132.236.56.10]:48027 "EHLO
	postoffice2.mail.cornell.edu") by vger.kernel.org with ESMTP
	id <S267184AbTBDIok> convert rfc822-to-8bit; Tue, 4 Feb 2003 03:44:40 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.59: ATI framebuffer compilation error
Date: Tue, 4 Feb 2003 03:55:56 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200302040356.12614.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

2.5.59 bitkeeper (as of 3:50 am Feb. 4 US Eastern time, changeset 1.973)

  Generating include/linux/compile.h (updated)
  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall 
- -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
- -mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default 
- -fomit-frame-pointer -nostdinc -iwithprefix include    
- -DKBUILD_BASENAME=version -DKBUILD_MODNAME=version -c -o init/version.o 
init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o 
init/do_mounts.o init/initramfs.o init/vermagic.o
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o 
- --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  
arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  kernel/built-in.o  
mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  
crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  
sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o 
.tmp_vmlinux1
drivers/built-in.o(.text+0xa441a): In function `atyfb_copyarea':
: undefined reference to `cfb_copyarea'
make: *** [.tmp_vmlinux1] Error 1
[root@cobra linux]# grep ATY ./include/linux/autoconf.h
#undef CONFIG_FB_ATY128
#define CONFIG_FB_ATY 1
#define CONFIG_FB_ATY_CT 1
#undef CONFIG_FB_ATY_GX
[root@cobra linux]# 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+P4ApXQ/AjixQzHcRApN3AJ9RP1QP3BNe5pdEEUu7KqF438ybMwCfcYLA
Y1cvH99glMb+SoiKMme+XIc=
=o4PQ
-----END PGP SIGNATURE-----


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTDKViE (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 17:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbTDKViE (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 17:38:04 -0400
Received: from postoffice2.mail.cornell.edu ([132.236.56.10]:22004 "EHLO
	postoffice2.mail.cornell.edu") by vger.kernel.org with ESMTP
	id S261757AbTDKViC convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 17:38:02 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: I2C, compile error: via686a_attach_adapter()
Date: Fri, 11 Apr 2003 17:51:02 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304111751.07679.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall 
- -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
- -mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default 
- -fomit-frame-pointer -nostdinc -iwithprefix include    
- -DKBUILD_BASENAME=version -DKBUILD_MODNAME=version -c -o init/.tmp_version.o 
init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o 
init/mounts.o init/initramfs.o
        ld -m elf_i386  -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o 
arch/i386/kernel/init_task.o   init/built-in.o --start-group  usr/built-in.o  
arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  
arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o  
fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  
lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  
arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
drivers/built-in.o(.text+0xa641b): In function `via686a_attach_adapter':
: undefined reference to `i2c_detect'



Bitkeeper with relevant config: 
I2C, I2C_CHARDEV, SENSORS_VIA686A  = Y

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+lzjKXQ/AjixQzHcRAv63AKCXgDEl3zKx4q4QE5czQzdAKXf5GgCgj5ak
5dqVlRa+Q87L+VvypgBXLoE=
=vzDE
-----END PGP SIGNATURE-----


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSIEDXg>; Wed, 4 Sep 2002 23:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316684AbSIEDXf>; Wed, 4 Sep 2002 23:23:35 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:52355 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S316675AbSIEDXf>;
	Wed, 4 Sep 2002 23:23:35 -0400
Date: Wed, 4 Sep 2002 22:15:49 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: 2.5.33-bk compile weirdness
Message-ID: <Pine.LNX.4.44.0209042212350.28757-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I pulled the latest bk version, used make oldconfig with a config file 
which worked day before yesterday and got the following during a make 
bzImage:

  gcc -Wp,-MD,./.irq.o.d -D__KERNEL__ 
-I/usr/local/kernel/bitkeeper/linux-2.5-tm/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon  -nostdinc -iwithprefix include    -DKBUILD_BASENAME=irq   
-c -o irq.o irq.c
  gcc -Wp,-MD,./.common.o.d -D__KERNEL__ 
-I/usr/local/kernel/bitkeeper/linux-2.5-tm/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon  -nostdinc -iwithprefix include    -DKBUILD_BASENAME=common   
-c -o common.o common.c
   ld -m elf_i386  -r -o pci.o i386.o pcbios.o direct.o fixup.o acpi.o 
legacy.o irq.o common.o
make[1]: Leaving directory 
`/usr/local/kernel/bitkeeper/linux-2.5-tm/arch/i386/pci'
make: *** No rule to make target `arch/i386/vmlinux.lds.S', needed by 
`arch/i386/vmlinux.lds.s'.  Stop.



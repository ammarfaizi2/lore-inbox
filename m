Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265589AbTALNEC>; Sun, 12 Jan 2003 08:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265633AbTALNEC>; Sun, 12 Jan 2003 08:04:02 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42184 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265589AbTALNEA>; Sun, 12 Jan 2003 08:04:00 -0500
Date: Sun, 12 Jan 2003 14:12:44 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jan Yenya Kasprzak <kas@fi.muni.cz>, linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.56: Two global symbols "io"
Message-ID: <20030112131244.GW21826@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error in 2.5.56:

<--  snip  -->

...
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o 
--start-group  usr/built-in.o  arch/i386/kernel/built-in.o  
arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  
security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  
drivers/built-in.o  sound/built-in.o  arch/i386/math-emu/built-in.o  
arch/i386/pci/built-in.o  arch/i386/oprofile/built-in.o  net/built-in.o 
--end-group  -o .tmp_vmlinux1
sound/built-in.o(.data+0x7b30): multiple definition of `io'
drivers/built-in.o(.data+0x738a0):
...
ld: Warning: size of symbol `io' changed from 68 to 4 in sound/built-in.o
...
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

The offending files are:
  sound/oss/awe_wave.c
  drivers/net/wan/cosa.c


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


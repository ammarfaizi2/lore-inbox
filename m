Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317986AbSGaMT1>; Wed, 31 Jul 2002 08:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317987AbSGaMT1>; Wed, 31 Jul 2002 08:19:27 -0400
Received: from kf-zvb-fp02-135.dial.kabelfoon.nl ([62.45.19.135]:54276 "EHLO
	server.duranium.home") by vger.kernel.org with ESMTP
	id <S317986AbSGaMT0> convert rfc822-to-8bit; Wed, 31 Jul 2002 08:19:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nick Martens <nickm@kabelfoon.nl>
Reply-To: nickm@kabelfoon.nl
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.29 compile error [undefined reference to `register_serial']
Date: Wed, 31 Jul 2002 20:18:26 +0000
User-Agent: KMail/1.4.1
References: <200207311952.30547.nickm@kabelfoon.nl>
In-Reply-To: <200207311952.30547.nickm@kabelfoon.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207312018.26798.nickm@kabelfoon.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think this output is better 

[......]
make[1]: Leaving directory `/usr/src/newkrnls/linux-2.5.29/arch/i386/pci'
  Generating build number
make[1]: Entering directory `/usr/src/newkrnls/linux-2.5.29/init'
  Generating /usr/src/newkrnls/linux-2.5.29/include/linux/compile.h (updated)
  gcc -Wp,-MD,./.version.o.d -D__KERNEL__ 
-I/usr/src/newkrnls/linux-2.5.29/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=version   -c -o version.o version.c
   ld -m elf_i386  -r -o init.o main.o version.o do_mounts.o
make[1]: Leaving directory `/usr/src/newkrnls/linux-2.5.29/init'
  ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o 
arch/i386/kernel/init_task.o init/init.o --start-group 
arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o 
ipc/ipc.o security/built-in.o 
/usr/src/newkrnls/linux-2.5.29/arch/i386/lib/lib.a lib/lib.a 
/usr/src/newkrnls/linux-2.5.29/arch/i386/lib/lib.a drivers/built-in.o 
sound/sound.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
drivers/built-in.o: In function `serial_register':
drivers/built-in.o(.text+0x316af): undefined reference to `register_serial'
drivers/built-in.o: In function `parport_serial_pci_remove':
drivers/built-in.o(.text+0x319a8): undefined reference to `unregister_serial'
make: *** [vmlinux] Error 1



> I am trying to compile 2.5.29 but I am running into some compilation
> problems i have attached my .config
>


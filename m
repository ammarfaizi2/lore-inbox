Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265516AbSK1NgR>; Thu, 28 Nov 2002 08:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbSK1NgR>; Thu, 28 Nov 2002 08:36:17 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:65255 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265516AbSK1NgQ>; Thu, 28 Nov 2002 08:36:16 -0500
Date: Thu, 28 Nov 2002 14:43:32 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>, Francois Romieu <romieu@cogenit.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-rc4-ac1
Message-ID: <20021128134332.GD6981@fs.tum.de>
References: <200211261901.gAQJ13T11036@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211261901.gAQJ13T11036@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2002 at 02:01:03PM -0500, Alan Cox wrote:

>...
> Linux 2.4.20-rc2-ac2
>...
> o	iphase ATM updates				(Francois Romieu)
>...

This broke the compilation if you compile iphase statically into the
kernel (ia_detect was removed but it's called from
drivers/atm/atmdev_init.c):

<--  snip  -->

...
ld -m elf_i386 -T 
/home/bunk/linux/kernel-2.4/linux-2.4.19-full-ac/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o
init/main.o init/version.o init/do_mounts.o \
...
        -o vmlinux
drivers/atm/atm.o(.text.init+0x21): In function `idt77252_exit':
/home/bunk/linux/kernel-2.4/linux-2.4.19-full-ac/drivers/atm/idt77252.c:
undefined reference to `ia_detect'
make: *** [vmlinux] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


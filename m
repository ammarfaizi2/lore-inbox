Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263066AbSJBMSF>; Wed, 2 Oct 2002 08:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263068AbSJBMSF>; Wed, 2 Oct 2002 08:18:05 -0400
Received: from [212.3.242.3] ([212.3.242.3]:30971 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S263066AbSJBMSE>;
	Wed, 2 Oct 2002 08:18:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.4.50 - 8250_cs does NOT work
Date: Wed, 2 Oct 2002 14:23:27 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200210021257.43121.devilkin-lkml@blindguardian.org> <20021002120540.D24770@flint.arm.linux.org.uk> <200210021348.58582.devilkin-lkml@blindguardian.org>
In-Reply-To: <200210021348.58582.devilkin-lkml@blindguardian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210021423.28328.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 October 2002 13:48, DevilKin wrote:
> make[3]: Entering directory `/usr/src/linux-2.5/drivers/serial'
>   gcc -Wp,-MD,./.8250.o.d -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -I/usr/src/linux-2.5/arch/i386/mach-generic -nostdinc
> -iwithprefix include    -DKBUILD_BASENAME=8250 -DEXPORT_SYMTAB  -c -o
> 8250.o 8250.c
> drivers/serial/8250.c: In function `serial8250_set_mctrl':
> drivers/serial/8250.c:1061: `ALPHA_KLUDGE_MCR' undeclared (first use in
> this function)
> drivers/serial/8250.c:1061: (Each undeclared identifier is reported only
> once drivers/serial/8250.c:1061: for each function it appears in.)

Fixed this one by re-introducing 
#include <linux/serialP.h>

> drivers/serial/8250.c: In function `serial8250_isa_init_ports':
> drivers/serial/8250.c:1701: structure has no member named `io_type'
>   gcc -Wp,-MD,./.8250_pci.o.d -D__KERNEL__ -I/usr/src/linux-2.5/include
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -I/usr/src/linux-2.5/arch/i386/mach-generic -nostdinc
> -iwithprefix include    -DKBUILD_BASENAME=8250_pci   -c -o 8250_pci.o
> 8250_pci.c
>    ld -m elf_i386  -r -o built-in.o core.o 8250.o 8250_pci.o

This one was my mistake...

I'm happy to report that my modem now works as it should :-))

Thanks!

DK



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267847AbTB1MqA>; Fri, 28 Feb 2003 07:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267853AbTB1MqA>; Fri, 28 Feb 2003 07:46:00 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:43245 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP
	id <S267847AbTB1Mp7>; Fri, 28 Feb 2003 07:45:59 -0500
Date: Fri, 28 Feb 2003 05:56:11 -0700
From: Matt Porter <porter@cox.net>
To: Nico Schottelius <schottelius@wdt.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ppc cross compiling...
Message-ID: <20030228055611.A18247@home.com>
References: <20030228112429.GD328@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030228112429.GD328@schottelius.org>; from schottelius@wdt.de on Fri, Feb 28, 2003 at 12:24:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 12:24:29PM +0100, Nico Schottelius wrote:
> Hello!
> 
> I am trying to cross compile 2.5.64 and get the following
> compile errors: 
> 
> make -f scripts/Makefile.build obj=arch/ppc/mm
>   powerpc-linux-gcc -Wp,-MD,arch/ppc/mm/.4xx_mmu.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -I/usr/src/linux-2.5.50/arch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -Wa,-m405 -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=4xx_mmu -DKBUILD_MODNAME=4xx_mmu -c -o arch/ppc/mm/4xx_mmu.o arch/ppc/mm/4xx_mmu.c
> arch/ppc/mm/4xx_mmu.c: In function `mmu_mapin_ram':
> arch/ppc/mm/4xx_mmu.c:99: `phys_addr_t' undeclared (first use in this function)

Whoa, wait a minute.  Don't expect to have PPC (especially 4xx stuff) to
even build (much less run) in Linus' tree.  A number of things that are
under heavy development have not been submitted.  You need to grab
the PPC development tree, see http://penguinppc.org/dev/kernel.shtml
for instructions on pulling the linuxppc-2.5 tree.  In this case
the phys_addr_t declaration in mmu.h hasn't found its way up.

Also, these questions are more appropriate for the linuxppc-dev or
linuxppc-embedded lists (http://lists.linuxppc.org/) where all the
PPC developers can be found. 

Regards,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

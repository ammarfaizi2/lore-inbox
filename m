Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315451AbSFORyS>; Sat, 15 Jun 2002 13:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSFORyS>; Sat, 15 Jun 2002 13:54:18 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:53960 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315451AbSFORyR>; Sat, 15 Jun 2002 13:54:17 -0400
Date: Sat, 15 Jun 2002 12:54:16 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: John covici <covici@ccs.covici.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.21 make problem
In-Reply-To: <15627.30793.979635.330468@ccs.covici.com>
Message-ID: <Pine.LNX.4.44.0206151247180.7247-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2002, John covici wrote:

> Cleaning up (boot)
> make[2]: Entering directory `/usr/src/linux-2.5.21/arch/i386/boot/compressed'
> make[2]: Leaving directory `/usr/src/linux-2.5.21/arch/i386/boot/compressed'
> make[1]: Leaving directory `/usr/src/linux-2.5.21/arch/i386/boot'
> Cleaning up
> make[1]: Entering directory `/usr/src/linux-2.5.21/Documentation/DocBook'
> Cleaning up (DocBook)
> make[1]: Leaving directory `/usr/src/linux-2.5.21/Documentation/DocBook'
> make[1]: Entering directory `/usr/src/linux-2.5.21/arch/i386/boot'
> gcc -E  -D__BIG_KERNEL__ -traditional -DSVGA_MODE=NORMAL_VGA -DRAMDISK=512 bootsect.S -o bbootsect.s
> as -o bbootsect.o bbootsect.s
> ld -m elf_i386 -Ttext 0x0 -s --oformat binary bbootsect.o -o bbootsect
> make[1]: *** No rule to make target `/usr/src/linux-2.5.21/include/linux/compile.h', needed by `bsetup.s'.  Stop.
> make[1]: Leaving directory `/usr/src/linux-2.5.21/arch/i386/boot'
> make: *** [bzImage] Error 2

What's the command line you're using? It seems like you have "make clean" 
in there, no big surprise that that breaks.

> on Saturday 06/15/2002 Kai Germaschewski(kai@tp1.ruhr-uni-bochum.de) wrote
>  > On Sat, 15 Jun 2002, John covici wrote:
>  > 
>  > > make[1]: Entering directory `/usr/src/linux-2.5.21/arch/i386/boot'
>  > > gcc -E  -D__BIG_KERNEL__ -traditional -DSVGA_MODE=NORMAL_VGA -DRAMDISK=512 bootsect.S -o bbootsect.s
>  > > as -o bbootsect.o bbootsect.s
>  > > ld -m elf_i386 -Ttext 0x0 -s --oformat binary bbootsect.o -o bbootsect
>  > > make[1]: *** No rule to make target `/usr/src/linux-2.5.21/include/linux/compile.h', needed by `bsetup.s'.  Stop.
>  > 
>  > I suppose that means that compile.h does not exist at that location, for 
>  > whichever reason. If you do "make" (or just "make SUBDIRS=init"), it 
>  > should be generated. Does it output something something like "Generating 
>  > ../include/linux/compile.h"?
>  > 
>  > Is scripts/mkcompile_h executable?

You applied patches which affect the build without mentioning them. You
didn't answer a single question I asked. That makes it hard to help you.

--Kai



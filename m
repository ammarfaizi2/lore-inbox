Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315629AbSFOWjC>; Sat, 15 Jun 2002 18:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315631AbSFOWjB>; Sat, 15 Jun 2002 18:39:01 -0400
Received: from ccs.covici.com ([209.249.181.196]:53396 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S315629AbSFOWjB>;
	Sat, 15 Jun 2002 18:39:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15627.49665.816993.766199@ccs.covici.com>
Date: Sat, 15 Jun 2002 18:38:57 -0400
From: John covici <covici@ccs.covici.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.21 make problem
In-Reply-To: <Pine.LNX.4.44.0206151247180.7247-100000@chaos.physics.uiowa.edu>
X-Mailer: VM 7.05 under Emacs 21.3.50.1
Reply-To: covici@ccs.covici.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the bright idea of taking the clean out of there, so I was left
with
make dep bzImage modules_install 2>&1 |tee foo

but that didn't help -- thought it would.

on Saturday 06/15/2002 Kai Germaschewski(kai@tp1.ruhr-uni-bochum.de) wrote
 > On Sat, 15 Jun 2002, John covici wrote:
 > 
 > > Cleaning up (boot)
 > > make[2]: Entering directory `/usr/src/linux-2.5.21/arch/i386/boot/compressed'
 > > make[2]: Leaving directory `/usr/src/linux-2.5.21/arch/i386/boot/compressed'
 > > make[1]: Leaving directory `/usr/src/linux-2.5.21/arch/i386/boot'
 > > Cleaning up
 > > make[1]: Entering directory `/usr/src/linux-2.5.21/Documentation/DocBook'
 > > Cleaning up (DocBook)
 > > make[1]: Leaving directory `/usr/src/linux-2.5.21/Documentation/DocBook'
 > > make[1]: Entering directory `/usr/src/linux-2.5.21/arch/i386/boot'
 > > gcc -E  -D__BIG_KERNEL__ -traditional -DSVGA_MODE=NORMAL_VGA -DRAMDISK=512 bootsect.S -o bbootsect.s
 > > as -o bbootsect.o bbootsect.s
 > > ld -m elf_i386 -Ttext 0x0 -s --oformat binary bbootsect.o -o bbootsect
 > > make[1]: *** No rule to make target `/usr/src/linux-2.5.21/include/linux/compile.h', needed by `bsetup.s'.  Stop.
 > > make[1]: Leaving directory `/usr/src/linux-2.5.21/arch/i386/boot'
 > > make: *** [bzImage] Error 2
 > 
 > What's the command line you're using? It seems like you have "make clean" 
 > in there, no big surprise that that breaks.
 > 
 > > on Saturday 06/15/2002 Kai Germaschewski(kai@tp1.ruhr-uni-bochum.de) wrote
 > >  > On Sat, 15 Jun 2002, John covici wrote:
 > >  > 
 > >  > > make[1]: Entering directory `/usr/src/linux-2.5.21/arch/i386/boot'
 > >  > > gcc -E  -D__BIG_KERNEL__ -traditional -DSVGA_MODE=NORMAL_VGA -DRAMDISK=512 bootsect.S -o bbootsect.s
 > >  > > as -o bbootsect.o bbootsect.s
 > >  > > ld -m elf_i386 -Ttext 0x0 -s --oformat binary bbootsect.o -o bbootsect
 > >  > > make[1]: *** No rule to make target `/usr/src/linux-2.5.21/include/linux/compile.h', needed by `bsetup.s'.  Stop.
 > >  > 
 > >  > I suppose that means that compile.h does not exist at that location, for 
 > >  > whichever reason. If you do "make" (or just "make SUBDIRS=init"), it 
 > >  > should be generated. Does it output something something like "Generating 
 > >  > ../include/linux/compile.h"?
 > >  > 
 > >  > Is scripts/mkcompile_h executable?
 > 
 > You applied patches which affect the build without mentioning them. You
 > didn't answer a single question I asked. That makes it hard to help you.
 > 
 > --Kai
 > 

-- 
         John Covici
         covici@ccs.covici.com

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315424AbSFOPnp>; Sat, 15 Jun 2002 11:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSFOPno>; Sat, 15 Jun 2002 11:43:44 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:47304 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315424AbSFOPno>; Sat, 15 Jun 2002 11:43:44 -0400
Date: Sat, 15 Jun 2002 10:43:43 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: John covici <covici@ccs.covici.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.21 make problem
In-Reply-To: <15627.4943.678449.561717@ccs.covici.com>
Message-ID: <Pine.LNX.4.44.0206151040290.7155-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2002, John covici wrote:

> make[1]: Entering directory `/usr/src/linux-2.5.21/arch/i386/boot'
> gcc -E  -D__BIG_KERNEL__ -traditional -DSVGA_MODE=NORMAL_VGA -DRAMDISK=512 bootsect.S -o bbootsect.s
> as -o bbootsect.o bbootsect.s
> ld -m elf_i386 -Ttext 0x0 -s --oformat binary bbootsect.o -o bbootsect
> make[1]: *** No rule to make target `/usr/src/linux-2.5.21/include/linux/compile.h', needed by `bsetup.s'.  Stop.

I suppose that means that compile.h does not exist at that location, for 
whichever reason. If you do "make" (or just "make SUBDIRS=init"), it 
should be generated. Does it output something something like "Generating 
../include/linux/compile.h"?

Is scripts/mkcompile_h executable?

--Kai



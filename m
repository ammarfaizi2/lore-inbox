Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261678AbSLJOTT>; Tue, 10 Dec 2002 09:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbSLJOTT>; Tue, 10 Dec 2002 09:19:19 -0500
Received: from ronispc.Chem.McGill.CA ([132.206.205.91]:7559 "EHLO
	ronispc.chem.mcgill.ca") by vger.kernel.org with ESMTP
	id <S261678AbSLJOTR>; Tue, 10 Dec 2002 09:19:17 -0500
From: David Ronis <ronis@ronispc.chem.mcgill.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15861.63731.843221.742384@ronispc.chem.mcgill.ca>
Date: Tue, 10 Dec 2002 09:23:47 -0500
To: Adrian Bunk <bunk@fs.tum.de>
Cc: ronis@onsager.chem.mcgill.ca, linux-kernel@vger.kernel.org
Subject: Re: build failure in 2.4.20
In-Reply-To: <20021210134251.GG17522@fs.tum.de>
References: <15860.46389.654483.692231@ronispc.chem.mcgill.ca>
	<20021210134251.GG17522@fs.tum.de>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: ronis@onsager.chem.mcgill.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Adrian,

Thanks for the reply.  Although Marc-Christian's suggestion seems to
have worked, here's what I did:

I used a clean tarball and applied no patches.  The .config file,
however, was the one I had in the 2.4.19 tree.  I had applied the
2.4.20 patch to that tree, but then deleted everything (except for the
.config file) and started over.  I also have repeated the same
procedure on another machine and in both cases CONFIG_M686FXSR=y, even
though one of them has a PIII while the other is a Celeron, and the
appropriate CPU configuration option was selected in xconfig on each.

Is this cause for concern?  Things seem to be working properly--other
than the fact that the version number (2.4.0) is messed up.

David


Adrian Bunk writes:
 > On Mon, Dec 09, 2002 at 10:22:29AM -0500, David Ronis wrote:
 > Content-Description: message body text
 > > 
 > > I've been trying to upgrade my kernel from 2.4.19 to 2.4.20 on a
 > > linux-i686-gnu box [I use gcc-2.95.3, GNU ld version 2.13, GNU
 > > assembler 2.13].
 > > 
 > > I first tried patching the kernel sources, reran xconfig and then
 > > 
 > > 	 make bzImage && make modules && make modules install
 > > 
 > > The build died in the make modules step, in the ppp driver tree
 > > complaining about not finding zlib.c.  
 > > 
 > > I deleted the source tree and started again with a full 2.4.20
 > > tarball.  After configureing,  I ran
 > > 
 > >  make dep && make clean && make bzImage && make modules && make modules install
 > > 
 > > and get:
 > >...
 > >         -o vmlinux
 > > drivers/net/net.o(.data+0xd4): undefined reference to `local symbols in discarded section .text.exit'
 > > make: *** [vmlinux] Error 1
 > > 
 > > 
 > > It sounds like this is a problem with ld or as, but I'm not sure.  Any
 > > suggestions?
 > >...
 > > Here's my .config file
 > >...
 > > CONFIG_M686FXSR=y
 > >...
 > 
 > This doesn't look right, it should be CONFIG_M686. Did you apply any 
 > patches against the "full 2.4.20 tarball" after you unpackaged it or did 
 > you accidentially send the wrong .config?
 > 
 > cu
 > Adrian
 > 
 > -- 
 > 
 >        "Is there not promise of rain?" Ling Tan asked suddenly out
 >         of the darkness. There had been need of rain for many days.
 >        "Only a promise," Lao Er said.
 >                                        Pearl S. Buck - Dragon Seed
 > 

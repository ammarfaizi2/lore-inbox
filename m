Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbSLJNfO>; Tue, 10 Dec 2002 08:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbSLJNfO>; Tue, 10 Dec 2002 08:35:14 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6643 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261615AbSLJNfN>; Tue, 10 Dec 2002 08:35:13 -0500
Date: Tue, 10 Dec 2002 14:42:51 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: ronis@onsager.chem.mcgill.ca
Cc: linux-kernel@vger.kernel.org
Subject: Re: build failure in 2.4.20
Message-ID: <20021210134251.GG17522@fs.tum.de>
References: <15860.46389.654483.692231@ronispc.chem.mcgill.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15860.46389.654483.692231@ronispc.chem.mcgill.ca>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 10:22:29AM -0500, David Ronis wrote:
Content-Description: message body text
> 
> I've been trying to upgrade my kernel from 2.4.19 to 2.4.20 on a
> linux-i686-gnu box [I use gcc-2.95.3, GNU ld version 2.13, GNU
> assembler 2.13].
> 
> I first tried patching the kernel sources, reran xconfig and then
> 
> 	 make bzImage && make modules && make modules install
> 
> The build died in the make modules step, in the ppp driver tree
> complaining about not finding zlib.c.  
> 
> I deleted the source tree and started again with a full 2.4.20
> tarball.  After configureing,  I ran
> 
>  make dep && make clean && make bzImage && make modules && make modules install
> 
> and get:
>...
>         -o vmlinux
> drivers/net/net.o(.data+0xd4): undefined reference to `local symbols in discarded section .text.exit'
> make: *** [vmlinux] Error 1
> 
> 
> It sounds like this is a problem with ld or as, but I'm not sure.  Any
> suggestions?
>...
> Here's my .config file
>...
> CONFIG_M686FXSR=y
>...

This doesn't look right, it should be CONFIG_M686. Did you apply any 
patches against the "full 2.4.20 tarball" after you unpackaged it or did 
you accidentially send the wrong .config?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266112AbSLOAtE>; Sat, 14 Dec 2002 19:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266115AbSLOAtE>; Sat, 14 Dec 2002 19:49:04 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55039 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266112AbSLOAtD>; Sat, 14 Dec 2002 19:49:03 -0500
Date: Sun, 15 Dec 2002 01:56:55 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: =?iso-8859-1?Q?Jos=E9_Luis_Tall=F3n?= <jltallon@adv-solutions.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.20: bug with radeonfb
Message-ID: <20021215005654.GE27658@fs.tum.de>
References: <5.1.1.6.0.20021203004621.00b5a770@mail.adv-solutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5.1.1.6.0.20021203004621.00b5a770@mail.adv-solutions.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 01:52:09AM +0100, José Luis Tallón wrote:

> Environment:	gcc-2.95.4, latest dev tools from Debian "Sarge"( testing )
> Kernel:	2.4.20 + patch-2.4.20-ac1 from ftp.kernel.org
>...
> "No Go's":
> 	Radeon M7 AGP:
> 	- Framebuffer:	unreadable output ( did work _perfectly_ with 
> 	Linux-2.4.19 ).
> 	Looks like there's a bug somewhere in the rendering code( kernel 
> autodetects and configures a 175x65 framebuffer, as previously):
> output seems to be "misplaced" -- might be a little assumption when 
> calculating line offsets.
> Text lines, although bent to the right( 60º angle or so ), look _extremely 
> long_ (might be a wrong appreciation)
> "Tux" logo is unrecogniceable too :(
> 
> 	- DRM 4.1( v20020828 ) works nicely with XFree 4.2.1
> 	- Xvid extension works
> 
> dmesg gives this ( double-checked with 2.4.19 ): relevant sections are 
> identical to 2.4.19
> ---
> Pentium 4 Mobility - stepping 04
> [...]
> ref_clk=2700, ref_div=12, xclk=16600 from BIOS
> Samsung LTN-1050P1-L02 flatpanel
> DFP 1400x1050 from BIOS
> Radeon M7 LW DDR SGRAM 64MB
> colour framebuffer 175x65
>...

Does it work if you revert the patch against drivers/video/radeonfb.c 
that is in -ac?

Does it work in plain 2.4.20 (without the -ac patch)?

> TIA
> Regards,
> 	J.L.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263532AbTDWTdt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTDWTdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:33:49 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:20228 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id S263532AbTDWTdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:33:42 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200304231946.UAA06070@gw.chygwyn.com>
Subject: Re: 2.5.68: net/decnet/dn_route.c doesn't compile
To: bunk@fs.tum.de (Adrian Bunk)
Date: Wed, 23 Apr 2003 20:46:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20030423193358.GU15833@fs.tum.de> from "Adrian Bunk" at Apr 23, 2003 09:33:58 PM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry about that. The flp should have been oldflp, and the fwmark should have
been nfmark. I'll add that to my next patch (which has a few other fixes too).
Thanks for letting me know,

Steve.

> 
> On Sat, Apr 19, 2003 at 08:11:40PM -0700, Linus Torvalds wrote:
> >...
> > Summary of changes from v2.5.67 to v2.5.68
> > ============================================
> >...
> > Steven Whitehouse:
> >   o [DECNET]: DECnet routing fixes etc
> >...
> 
> This broke the compilation of net/decnet/dn_route.c
> #ifdef CONFIG_DECNET_ROUTE_FWMARK :
> 
> <--  snip  -->
> 
> ...
>   gcc -Wp,-MD,net/decnet/.dn_route.o.d -D__KERNEL__ -Iinclude -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
> -mpreferred-stack-boundary=2 -march=k6 -Iinclude/asm-i386/mach-default -nostdinc 
> -iwithprefix include    -DKBUILD_BASENAME=dn_route -DKBUILD_MODNAME=decnet -c -o 
> net/decnet/dn_route.o net/decnet/dn_route.c
> net/decnet/dn_route.c: In function `dn_route_output_slow':
> net/decnet/dn_route.c:896: warning: deprecated use of label at end of 
> compound statement
> net/decnet/dn_route.c:1057: `flp' undeclared (first use in this function)
> net/decnet/dn_route.c:1057: (Each undeclared identifier is reported only once
> net/decnet/dn_route.c:1057: for each function it appears in.)
> net/decnet/dn_route.c: In function `dn_route_input_slow':
> net/decnet/dn_route.c:1182: structure has no member named `fwmark'
> make[2]: *** [net/decnet/dn_route.o] Error 1
> 
> <--  snip  -->
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


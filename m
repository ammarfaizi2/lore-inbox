Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWCPMZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWCPMZY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 07:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbWCPMZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 07:25:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45835 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750793AbWCPMZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 07:25:24 -0500
Date: Thu, 16 Mar 2006 13:25:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Patrizio Bassi <patrizio.bassi@gmail.com>
Cc: "Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc6-git6 compilation fails (input system)
Message-ID: <20060316122522.GC3914@stusta.de>
References: <441946AA.2070006@gmail.com> <20060316113206.GB3914@stusta.de> <44195429.8070809@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44195429.8070809@gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 01:03:53PM +0100, Patrizio Bassi wrote:
> Adrian Bunk ha scritto:
> > On Thu, Mar 16, 2006 at 12:06:18PM +0100, Patrizio Bassi wrote:
> >   
> >> i've a problem with gcc 4.1.0
> >>
> >>
> >> LD drivers/ide/built-in.o
> >> CC drivers/input/input.o
> >> In file included from drivers/input/input.c:16:
> >> include/linux/input.h:957: warning: ‘struct input_device_id’ declared
> >> inside parameter list
> >> include/linux/input.h:957: warning: its scope is only this definition or
> >> declaration, which is probably not what you want
> >> drivers/input/input.c: In function ‘input_register_device’:
> >> drivers/input/input.c:842: warning: passing argument 3 of
> >> ‘handler->connect’ from incompatible pointer type
> >> drivers/input/input.c: In function ‘input_register_handler’:
> >> drivers/input/input.c:898: warning: passing argument 3 of
> >> ‘handler->connect’ from incompatible pointer type
> >> ...
> >>     
> >
> > Please send your .config .
> >
> > cu
> > Adrian
> >
> >   
> remving joystick interface fixed it, but a nice warning still remains:
> 
> In file included from drivers/input/serio/libps2.c:19:
> include/linux/input.h:957: warning: ‘struct input_device_id’ declared
> inside parameter list
> include/linux/input.h:957: warning: its scope is only this definition or
> declaration, which is probably not what you want

Your .config compiles for me with neither errors nor warnings in the 
input system.

Well, with the exception that "make oldconfig" reveals that you have the 
following options set that aren't present in 2.6.16-rc6-git6:
CONFIG_NO_IDLE_HZ=y
CONFIG_FB_SPLASH=y

> this should be the cause of the problem.

It seems the cause of the problem is that you omitted the information 
that what you call "2.6.16-rc6-git6" is in fact 2.6.16-rc6-git6 plus
tons of patches, and one of these patches is causing your problem.

> Patrizio

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


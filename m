Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131244AbRDMNQl>; Fri, 13 Apr 2001 09:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131254AbRDMNQY>; Fri, 13 Apr 2001 09:16:24 -0400
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:6661 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S131244AbRDMNQJ>;
	Fri, 13 Apr 2001 09:16:09 -0400
Date: Fri, 13 Apr 2001 06:16:30 -0700 (PDT)
From: <nak@apfbioelectronics.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Cyrille Ngalle <Cyrille.Ngalle@smart-fusion.com>,
        linux-kernel@vger.kernel.org, linux-arm@lists.arm.linux.org.uk
Subject: Re: kernel crash
In-Reply-To: <20010412163153.B23165@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10104130604150.27683-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I see this has started to interfere with the bug tracking process so
I'll kill it now (I seriously thought it was already dead).

Yep it was an april fools joke. 
 
for the record: 
  2 offers for help; 
  1 post asking me if I mounted a scratch monkey( heh); 
  1 email begging me to abandon the project for the sake of humanity (and
linux' reputation)

And this adds 1 attempt to use it as corroborating evidence. Who knows, it
might have even been this guy's post I ripped the oops from.
  

On Thu, 12 Apr 2001, Russell King wrote:

> On Thu, Apr 12, 2001 at 05:16:33PM +0200, Cyrille Ngalle wrote:
> > This is just to reinforce the message below.
> 
> And why is it of interest to LKML?  I can think if no one here who'd
> be interested in it.
> 
> > This crash is ver easy to reproduce.
> > 
> > Use bootldr (with the last patch from Nico)  [it also happens with
> > Redboot]
> 
> It is not a function of the bootloader, this is irrelevent.
> 
> Also, I believe that the original posters message was an April Fool's
> joke (was posted on the 1st April to the linux-arm lists).
> 
> However, the problem it describes is not, and I do have a fix in my
> tree, but the delta between my last patch and my current tree is one
> line, which hardly seems worth putting out a new ARM patch.
> 
> --- linux.rel/arch/arm/mm/fault-armv.c	Fri Apr  6 19:09:05 2001
> +++ linux/arch/arm/mm/fault-armv.c	Thu Apr 12 16:30:25 2001
> @@ -490,7 +490,7 @@
>  bad_or_fault:
>  	if (type == TYPE_ERROR)
>  		goto bad;
> -
> +	regs->ARM_pc -= 4;
>  	/*
>  	 * We got a fault - fix it up, or die.
>  	 */
> 
> 
> --
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
> 


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbTABKmV>; Thu, 2 Jan 2003 05:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbTABKmV>; Thu, 2 Jan 2003 05:42:21 -0500
Received: from dp.samba.org ([66.70.73.150]:34025 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261205AbTABKmU>;
	Thu, 2 Jan 2003 05:42:20 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: Linux v2.5.54 
In-reply-to: Your message of "Wed, 01 Jan 2003 20:38:50 -0800."
             <20030102043850.GP9704@holomorphy.com> 
Date: Thu, 02 Jan 2003 21:43:26 +1100
Message-Id: <20030102105049.DE3FC2C252@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030102043850.GP9704@holomorphy.com> you write:
> On Wed, Jan 01, 2003 at 07:43:40PM -0800, Linus Torvalds wrote:
> > Rusty Russell <rusty@rustcorp.com.au>:
> >   o Modules without init functions don't need exit functions
> >   o Embed __this_module in module itself
> >   o Fix MODULE_PARM for arrays of s
> >   o Minor compile fix for some modules
> >   o more module parameter parsing bugs
> >   o MODULE_PARM "c" support
> >   o Modules 1/3: remove common section handling
> >   o Modules 2/3: Use sh_addr instead of sh_offset
> >   o Modules 3/3: Sort sections
> 
> Hmm, I got this oops in 2.5.53-mm3:
> 
> eth2: Adaptec Starfire 6915 at 0xf8a55000, 00:00:d1:ec:cf:9f, IRQ 11.
> eth2: MII PHY found at address 1, status 0x7809 advertising 01e1.    
> eth2: scatter-gather and hardware TCP cksumming disabled.        
> eth3: Adaptec Starfire 6915 at 0xf8ad6000, 00:00:d1:ec:cf:a0, IRQ 7.
> eth3: MII PHY found at address 1, status 0x7809 advertising 01e1.   
> eth3: scatter-gather and hardware TCP cksumming disabled.        
> ERROR: SCSI host `isp1020' has no error handling         
> ERROR: This is not a safe way to run your SCSI host
> ERROR: The error handling must be added to this driver
> Call Trace:                                           
>  [<c02364a9>] <1>Unable to handle kernel NULL pointer dereference at virtual 
address 00000000

Hmm, Andi played with the kallsyms code.  Unless this is in a module,
I don't think it can be me.

Andi?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

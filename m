Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131762AbRBWTUh>; Fri, 23 Feb 2001 14:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131789AbRBWTU2>; Fri, 23 Feb 2001 14:20:28 -0500
Received: from imcs.rutgers.edu ([165.230.57.130]:60837 "EHLO imcs.Rutgers.EDU")
	by vger.kernel.org with ESMTP id <S131762AbRBWTUK>;
	Fri, 23 Feb 2001 14:20:10 -0500
Date: Fri, 23 Feb 2001 14:09:25 -0500 (EST)
From: Rob Cermak <cermak@IMCS.rutgers.edu>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [FAQ] pls add migrate 2.2 -> 2.4 Re: 3c509 + sb16 bug
In-Reply-To: <E14WNYd-0006tS-00@the-village.bc.nu>
Message-ID: <Pine.SOL.4.21.0102231357590.26512-100000@imcs.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

You've mentioned this before.  I emailed Steve directly since I had the
same sort of problem with a trio of ethernet cards.  Hardware detection
goes wacky when mixing isapnp userspace tools with the CONFIG_ISAPNP
support in the kernel.  Steve told me: "I'm running debian sid, with
isapnptools package version: 1.21-2"

This should go into the FAQ at http://www.tux.org/lkml/

Here is Alan's quote: Fri, 16 Feb 2001 12:34:03 +0000 (GMT) 
"Dont mix isapnp tools with a 2.4 kernel unless you disable ISA PnP
support in the kernel. It needs to have one or the other do it, not both"

If you use isapnp tools, make sure your config looks like this:

#
# Plug and Play configuration
#
CONFIG_PNP=y
# CONFIG_ISAPNP is not set

Rob

On Fri, 23 Feb 2001, Alan Cox wrote:

> > Perhaps it's cold comfort, but I found long ago that
> > 3c509 and SB don't mix too well, at least in Linux.
> 
> I've had them mixed ok before
> 
> > ISA devices are somewhat dumb, switching one
> > of the cards for a PCI version does the trick here.
> 
> I think the problem here thought isnt the 3c509 and SB card, its the kernel
> plug and play code. You might want to try building kernels with no PnP support
> at all and see how they behave
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/








Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133109AbRDLPcT>; Thu, 12 Apr 2001 11:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135172AbRDLPcJ>; Thu, 12 Apr 2001 11:32:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8207 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S133109AbRDLPcB>;
	Thu, 12 Apr 2001 11:32:01 -0400
Date: Thu, 12 Apr 2001 16:31:53 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Cyrille Ngalle <Cyrille.Ngalle@smart-fusion.com>
Cc: nak@apfbioelectronics.com, linux-kernel@vger.kernel.org,
        linux-arm@lists.arm.linux.org.uk
Subject: Re: kernel crash
Message-ID: <20010412163153.B23165@flint.arm.linux.org.uk>
In-Reply-To: <C4986887AFD0FE4FAB6D5EB312E9BDD30444E3@ncemx.smart-fusion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <C4986887AFD0FE4FAB6D5EB312E9BDD30444E3@ncemx.smart-fusion.com>; from Cyrille.Ngalle@smart-fusion.com on Thu, Apr 12, 2001 at 05:16:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2001 at 05:16:33PM +0200, Cyrille Ngalle wrote:
> This is just to reinforce the message below.

And why is it of interest to LKML?  I can think if no one here who'd
be interested in it.

> This crash is ver easy to reproduce.
> 
> Use bootldr (with the last patch from Nico)  [it also happens with
> Redboot]

It is not a function of the bootloader, this is irrelevent.

Also, I believe that the original posters message was an April Fool's
joke (was posted on the 1st April to the linux-arm lists).

However, the problem it describes is not, and I do have a fix in my
tree, but the delta between my last patch and my current tree is one
line, which hardly seems worth putting out a new ARM patch.

--- linux.rel/arch/arm/mm/fault-armv.c	Fri Apr  6 19:09:05 2001
+++ linux/arch/arm/mm/fault-armv.c	Thu Apr 12 16:30:25 2001
@@ -490,7 +490,7 @@
 bad_or_fault:
 	if (type == TYPE_ERROR)
 		goto bad;
-
+	regs->ARM_pc -= 4;
 	/*
 	 * We got a fault - fix it up, or die.
 	 */


--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


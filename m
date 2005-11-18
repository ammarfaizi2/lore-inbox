Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbVKRCog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbVKRCog (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 21:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbVKRCog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 21:44:36 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32518 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751422AbVKRCof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 21:44:35 -0500
Date: Fri, 18 Nov 2005 03:44:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20051118024433.GN11494@stusta.de>
References: <20051118014055.GK11494@stusta.de> <20051117175015.6aa99fcf.akpm@osdl.org> <20051118020640.GM11494@stusta.de> <20051117182047.5fe1a5eb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117182047.5fe1a5eb.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 06:20:47PM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > On Thu, Nov 17, 2005 at 05:50:15PM -0800, Andrew Morton wrote:
> > > Adrian Bunk <bunk@stusta.de> wrote:
> > > >
> > > > virt_to_bus/bus_to_virt are long deprecated, mark them as __deprecated 
> > > > on i386.
> > > > 
> > > 
> > > Problem is, nobody's fixing these things.  There's no point in adding spam
> > > to the kernel build unless it actually gets us some action, and I haven't
> > > seen any evidence that it does.
> > > 
> > > Stick it under CONFIG_I_AM_A_DEVELOPER_WHO_HAS_TIME_TO_FIX_STUFF.
> > 
> > I'm used to the fact that every single BROKEN_ON_SMP driver generates 
> > tons of such warnings that I don't see why these warnings should be any 
> > bad...
> 
> I frequently (daily) get patches which spit new warnings.  Sometimes
> (~weekly) those warnings indicate real bugs in the patch.
> 
> I believe that the main reason for this is that the developers simply don't
> notice the new warning amongst all the noise.

There are few areas in the kernel that spit that many warnings that you 
might not see new ones .

The developers not noticing the warnings might often be the same 
developers who send patches that don't compile...

> > If you dislike the warnings, you could move the whole __deprecated und a 
> > config option.
> > 
> > In the case of virt_to_bus/bus_to_virt I had the hope that e.g. the ATM 
> > drivers that seem to have an active maintainer might get fixed.
> 
> That would be good - but perhaps a better approach would be to send pointed
> emails to the maintainer.  Or to merge lameo patches to remove
> virt_to_bus() so he has to fix it for real ;)

In the case of virt_to_bus/bus_to_virt there are stil many places in the 
kernel using it, and several of them are well maintained.

IMHO the warnings are the best solution for getting a vast amount fixed, 
and then it's time to think about the rest.

> > But I'm not religious regarding this issue as long as you accept my 
> > -Werror-implicit-function-declaration patch...
> 
> Problem is, I'm the sucker who takes the brunt of that change.  It'd be
> best to fix up the warnings _before_ adding the make-it-break patch.

-Werror-implicit-function-declaration doesn't add new warnings, it turns 
a specific kind of warnings that can indicate nasty runtime errors into 
compile errors.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


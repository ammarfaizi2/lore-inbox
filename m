Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVCLRHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVCLRHR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 12:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVCLRHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 12:07:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38672 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261971AbVCLRHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 12:07:08 -0500
Date: Sat, 12 Mar 2005 18:07:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Adam Belay <abelay@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/pnp/: possible cleanups
Message-ID: <20050312170706.GF3814@stusta.de>
References: <20050311181606.GC3723@stusta.de> <1110585763.12485.223.camel@localhost.localdomain> <20050311162320.15007aa3.akpm@osdl.org> <1110588297.12485.251.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110588297.12485.251.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 07:44:56PM -0500, Adam Belay wrote:
> On Fri, 2005-03-11 at 16:23 -0800, Andrew Morton wrote:
> > Adam Belay <abelay@novell.com> wrote:
> > >
> > > This patch essential makes it impossible for PnP protocols to be
> > > modules.  Currently, they are all in-kernel.  If that is acceptable...,
> > > then this patch looks fine to me.  Any comments?
> > 
> > You're the maintainer...
> 
> I've been holding off on making many changes to PnP at the moment,
> because I have been considering replacing it with a new (more modern and
> ACPI capable) ISA/LPC bridge driver.  This work would likely begin after
> my PCI bridge driver rewrite is finished and merged (as the PCI work is
> in some ways a prerequisite).
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111023821617705&w=2
> 
> Still, if there are changes to fix actual bugs, then I'm all for them.
> 
> Also a few features could be added.  Specifically PnPBIOS
> hotplug/docking station support.  If anyone's interested, I may
> implement it (and it would use some functions that were removed by this
> patch).  Furthermore, ISAPnP could be made a module.  PnPBIOS probably
> couldn't.
>...

Note that my patch #if 0's exactly one functions and removes no 
functions. Most it does is the removal of EXPORT_SYMBOL's, so if any 
modular code will use any of them, re-adding will be trivial.

Modular ISAPnP might be interesting in some cases, but this is more 
legacy code. If someone would work on it to sort all the issues out 
(starting with the point that most users of __ISAPNP__ will have to be 
fixed) re-adding the required EXPORT_SYMBOL's won't be hard for him.

> Thanks,
> Adam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVFBUvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVFBUvw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVFBUtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:49:23 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42760 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261231AbVFBUsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:48:19 -0400
Date: Thu, 2 Jun 2005 22:48:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mark.langsdorf@amd.com
Subject: Re: [2.6 patch] unexport phys_proc_id and cpu_core_id
Message-ID: <20050602204814.GJ4992@stusta.de>
References: <20050506211913.GO3590@stusta.de> <20050507134507.GB30158@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050507134507.GB30158@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 03:45:07PM +0200, Andi Kleen wrote:
> On Fri, May 06, 2005 at 11:19:14PM +0200, Adrian Bunk wrote:
> > Back in January, Andi Kleen added EXPORT_SYMBOL(phys_proc_id), stating:
> >   This is needed for the powernow k8 driver to manage AMD dual core 
> >   systems.
> > 
> > This EXPORT_SYMBOL was never used.
> > 
> > I asked him on 13 Mar 2005 whether it's really required, but he didn't 
> > answer to my email.
> 
> It is superceeded now with cpu_core_map[]/cpu_core_id[]
> > 
> > 2.6.12-rc3 adds cpu_core_id with a similarly unused 
> > EXPORT_SYMBOL(cpu_core_id).
> > 
> > It's OK to export symbols when these exports are required, but unless 
> > someone can explain why they are required now, they should be removed 
> > before 2.6.12 and then re-added when they are actually used.
> 
> The dual powernowk8 driver really uses them, although the merging 
> process seems to be a bit slow.
> 
> Andrew, please don't apply the patch.

Is there any time when you expect to submit the dual powernowk8 driver 
you've added the EXPORT_SYMBOL for five months ago?

I'd prefer if we'd not add EXPORT_SYMBOL's before the potential users 
are available...

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


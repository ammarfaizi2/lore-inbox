Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263099AbVGIDLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263099AbVGIDLW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 23:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbVGIDJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 23:09:31 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35335 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263099AbVGIDH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 23:07:28 -0400
Date: Sat, 9 Jul 2005 05:07:25 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mark.langsdorf@amd.com
Subject: Re: [2.6 patch] unexport phys_proc_id and cpu_core_id
Message-ID: <20050709030725.GB28243@stusta.de>
References: <20050506211913.GO3590@stusta.de> <20050507134507.GB30158@wotan.suse.de> <20050602204814.GJ4992@stusta.de> <20050602211249.GB23826@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050602211249.GB23826@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 05:12:50PM -0400, Dave Jones wrote:
> On Thu, Jun 02, 2005 at 10:48:14PM +0200, Adrian Bunk wrote:
>  > On Sat, May 07, 2005 at 03:45:07PM +0200, Andi Kleen wrote:
>  > > On Fri, May 06, 2005 at 11:19:14PM +0200, Adrian Bunk wrote:
>  > > > Back in January, Andi Kleen added EXPORT_SYMBOL(phys_proc_id), stating:
>  > > >   This is needed for the powernow k8 driver to manage AMD dual core 
>  > > >   systems.
>  > > > 
>  > > > This EXPORT_SYMBOL was never used.
>  > > > 
>  > > > I asked him on 13 Mar 2005 whether it's really required, but he didn't 
>  > > > answer to my email.
>  > > 
>  > > It is superceeded now with cpu_core_map[]/cpu_core_id[]
>  > > > 
>  > > > 2.6.12-rc3 adds cpu_core_id with a similarly unused 
>  > > > EXPORT_SYMBOL(cpu_core_id).
>  > > > 
>  > > > It's OK to export symbols when these exports are required, but unless 
>  > > > someone can explain why they are required now, they should be removed 
>  > > > before 2.6.12 and then re-added when they are actually used.
>  > > 
>  > > The dual powernowk8 driver really uses them, although the merging 
>  > > process seems to be a bit slow.
>  > > 
>  > > Andrew, please don't apply the patch.
>  > 
>  > Is there any time when you expect to submit the dual powernowk8 driver 
>  > you've added the EXPORT_SYMBOL for five months ago?
>  > 
>  > I'd prefer if we'd not add EXPORT_SYMBOL's before the potential users 
>  > are available...
>  
> powernow-k8 dual-core support got merged a few days ago.

My patch to unexport these two variables wouldn't break it today...

> 		Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


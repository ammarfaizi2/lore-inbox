Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbVLPVuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVLPVuy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 16:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVLPVuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 16:50:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42502 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932488AbVLPVux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 16:50:53 -0500
Date: Fri, 16 Dec 2005 22:50:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mike Snitzer <snitzer@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051216215054.GJ23349@stusta.de>
References: <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <dnv0d3$4jl$1@sea.gmane.org> <1134758219.2992.52.camel@laptopd505.fenrus.org> <170fa0d20512161132g34c62593p39b109f07cf30b7d@mail.gmail.com> <1134762379.2992.69.camel@laptopd505.fenrus.org> <170fa0d20512161328n7e879b5ao29a4227e9c87491e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170fa0d20512161328n7e879b5ao29a4227e9c87491e@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 04:28:15PM -0500, Mike Snitzer wrote:
>...
> Given Neil Brown's fix for the block layer these stack-heavy workloads
> that included DM in the call chain need to be revisited.  However, the
> savings associated with those particular fixes still may not leave
> sufficient breathing room.  The logic that all users must NOW provide
> workloads which undermine 4K stack viability otherwise the 8K option
> will be completely removed _seems_ quite irrational (even though we
> are _supposedly_ just talking about doing so in -mm).
> 
> All of us appreciate the desire to have Linux be more efficient and 4K
> stacks will get us that.  If it comes with the cost of instability
> under more exotic workloads then the bad outweighs the perceived good
> of imposed 4K stacks.  With RHEL4 it would seem we're past the point
> of no-return for supported 8K stacks.  I'm merely advocating upstream
> give users the 8K+IRQ stack _options_ and set the default to 4K.

My count of bug reports for problems with in-kernel code with 4k stacks 
after Neil's patch went into -mm is still at 0. That's amazing 
considering how many people have claimed in this thread how unstable
4k stacks were...

Enabling 4k stacks unconditionally for all -mm users will give us a 
wider testing coverage and will tell us whether we have really fixed all 
bugs that become visible with 4k stacks or whether there are still bugs 
left.

-mm kernels contain many experimental features, and "completely removed" 
isn't really true because we can expect that people running the 
experimental -mm kernels to know how to un-apply a patch.

> Mike

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


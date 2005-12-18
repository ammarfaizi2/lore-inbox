Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965196AbVLRP5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbVLRP5f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 10:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbVLRP5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 10:57:35 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46354 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965196AbVLRP5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 10:57:35 -0500
Date: Sun, 18 Dec 2005 16:57:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Andi Kleen <ak@suse.de>, Kyle Moffett <mrmacman_g4@mac.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051218155737.GG23349@stusta.de>
References: <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <p73slsrehzs.fsf@verdi.suse.de> <20051217205238.GR23349@stusta.de> <61D4A300-4967-4DC1-AD2C-765A3D2D9743@comcast.net> <20051218120900.GA23349@stusta.de> <2C3FD086-5582-4697-AB9F-578C80BA5811@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2C3FD086-5582-4697-AB9F-578C80BA5811@comcast.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2005 at 10:49:31AM -0500, Parag Warudkar wrote:
> 
> On Dec 18, 2005, at 7:09 AM, Adrian Bunk wrote:
> 
> >There is no workload where 8kB suits better.
> 
> People have pointed out that there is currently at least one  
> incompatibility introduced by 4K stacks and there may be many others  

That's wrong.

My count of bug reports for problems with 4k stacks with in-kernel code 
after Neil's patch went into -mm is still at 0.

> which are corner cases, that only occur under high load in obscure  
> exceptional circumstances with large configurations and suitable  
> nesting.

And this is not that much of an issue since most of these cases can and 
have already been analyzed by static analysis to be below 3 kB stack 
usage.

> Moreover for 64 bit architectures there is no proven point that 4Kb  
> stacks are solving a specific problem there (Like the lowmem  
> fragmentation on i386 for e.g.). Nor can we predict for sure that in  
> future no type of functionality will require more stack. So taking  
> away 8Kb stack size on such arches solves no known problems and  
> introduces artificial limitations on code complexity.
>...

That's complete bullshit considering that we are talking about an
i386-only patch.

> Parag

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


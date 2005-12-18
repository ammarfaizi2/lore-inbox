Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932695AbVLRMI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbVLRMI7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 07:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbVLRMI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 07:08:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12305 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932695AbVLRMI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 07:08:59 -0500
Date: Sun, 18 Dec 2005 13:09:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Andi Kleen <ak@suse.de>, Kyle Moffett <mrmacman_g4@mac.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051218120900.GA23349@stusta.de>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <p73slsrehzs.fsf@verdi.suse.de> <20051217205238.GR23349@stusta.de> <61D4A300-4967-4DC1-AD2C-765A3D2D9743@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61D4A300-4967-4DC1-AD2C-765A3D2D9743@comcast.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2005 at 12:03:39AM -0500, Parag Warudkar wrote:
> 
> On Dec 17, 2005, at 3:52 PM, Adrian Bunk wrote:
> 
> >And in my experience, many stack problems don't come from code getting
> >more complex but from people allocating 1kB structs or arrays of
> 
> And we catch this type of problems fairly easily in the patch review  
> itself, even before accepting the code in mainline. Plus there is  
> make checkstack to help find and fix any such issues, isn't it? So  
> it's not like forcing the stack to 4Kb and making the offending code  
> to crash is the best solution to force people to write code which  
> plays nice with the stack.

4kB stacks are already an option for some time. There were some problems 
in the beginning, but as far as we know we have have fixed all of them.

There are so many possible bugs people writing kernel code could 
introduce bugs that cause crashes. The solution is not to add 
workarounds for programming bugs at every possible place, but as the
code review and "make checkstack" before accepting code.

As a data point, my count of bug reports for problems with in-kernel 
code with 4k stacks after Neil's patch went into -mm is still at 0.

> I think on i386 most people do fine with the 8Kb stack - whoever  
> benefits from 4Kb stack, can always choose the 4Kb stack config  
> option and recompile.
> 
> Alternatively, default to 4Kb and let people choose 8Kb and recompile  
> if that's what suits their workloads.
>...

There is no workload where 8kB suits better.

> My 2 cents.
> 
> Parag

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


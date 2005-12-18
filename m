Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965182AbVLRPvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182AbVLRPvI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 10:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbVLRPvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 10:51:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39954 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965182AbVLRPvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 10:51:06 -0500
Date: Sun, 18 Dec 2005 16:51:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Andi Kleen <ak@suse.de>, Kyle Moffett <mrmacman_g4@mac.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051218155108.GF23349@stusta.de>
References: <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <p73slsrehzs.fsf@verdi.suse.de> <20051217205238.GR23349@stusta.de> <61D4A300-4967-4DC1-AD2C-765A3D2D9743@comcast.net> <20051218054323.GF23384@wotan.suse.de> <5DB2F520-5666-4C7F-9065-51117A0F54B9@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DB2F520-5666-4C7F-9065-51117A0F54B9@comcast.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2005 at 01:05:52AM -0500, Parag Warudkar wrote:
> 
> On Dec 18, 2005, at 12:43 AM, Andi Kleen wrote:
> 
> >You can catch the obvious ones, but the really hard ones
> >that only occur under high load in obscure exceptional
> >circumstances with large configurations and suitable nesting you  
> >won't.
> >These would be only found at real world users.
> 
> Yep, as it all depends on code complexity, some of these cases might  
> not be "errors" at all - instead for that kind of functionality they  
> might _require_ bigger stacks.

Is this just FUD or can you give an example where this is a real 
problem that can't be solved by using kmalloc()?

> If you have 64 bit machines common place and memory a lot cheaper I  
> don't see how it is beneficial to force smaller stack sizes without  
> giving consideration to the code complexity, architecture and  
> requirements.
>...

Note that we are talking about reducing the stack size _by one third_.

Therefore, your point it would make code much more complex sounds 
strange.

> Parag

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


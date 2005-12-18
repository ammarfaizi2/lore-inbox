Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965136AbVLRPoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbVLRPoF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 10:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbVLRPoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 10:44:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36370 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965136AbVLRPoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 10:44:03 -0500
Date: Sun, 18 Dec 2005 16:44:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Parag Warudkar <kernel-stuff@comcast.net>,
       Kyle Moffett <mrmacman_g4@mac.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051218154405.GE23349@stusta.de>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <p73slsrehzs.fsf@verdi.suse.de> <20051217205238.GR23349@stusta.de> <61D4A300-4967-4DC1-AD2C-765A3D2D9743@comcast.net> <20051218054323.GF23384@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051218054323.GF23384@wotan.suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2005 at 06:43:23AM +0100, Andi Kleen wrote:
> On Sun, Dec 18, 2005 at 12:03:39AM -0500, Parag Warudkar wrote:
> > 
> > On Dec 17, 2005, at 3:52 PM, Adrian Bunk wrote:
> > 
> > >And in my experience, many stack problems don't come from code getting
> > >more complex but from people allocating 1kB structs or arrays of
> > 
> > And we catch this type of problems fairly easily in the patch review  
> > itself, even before accepting the code in mainline. Plus there is  
> 
> You can catch the obvious ones, but the really hard ones
> that only occur under high load in obscure exceptional
> circumstances with large configurations and suitable nesting you won't. 
> These would be only found at real world users.

You miss the fact that many of these problems can be detected by static 
analysis.

We know that we don't have any non-recursive paths with > 3 kB stack 
usage anymore since the beginning of this year, and the known recursive 
problems should be attacked by Neil's patch.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


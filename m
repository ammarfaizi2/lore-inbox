Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVLPPtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVLPPtY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 10:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbVLPPtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 10:49:24 -0500
Received: from smtpout.mac.com ([17.250.248.72]:53210 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932278AbVLPPtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 10:49:23 -0500
In-Reply-To: <20051216163503.289d491e.diegocg@gmail.com>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com>
Cc: Adrian Bunk <bunk@stusta.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Fri, 16 Dec 2005 10:49:10 -0500
To: Diego Calleja <diegocg@gmail.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 16, 2005, at 10:35, Diego Calleja wrote:
> I know, but there's too much resistance to the "pure" 4kb patch.

I have yet to see any resistance to the 4Kb patch this time around  
that was not "*whine* don't break my ndiswrapper plz".   There are  
extremely few remaining 4kb stack bugs, and 4k stacks have a sizeable  
list of technical advantages.


> The 8 KB patch does the same thing (enables 4kb stacks)

The point is to force it in -mm so most people can't just disable it  
because it fixes their problem.  We want 8k stacks to go away, and  
the only way to get out the last issues before sending to mainline is  
by forcing it in -mm.


> and at the same time the 8kb groupies can't flamewar you for it

This matter how?


> it covers akpm's concerns

I get the impression that they are already sufficiently addressed,  
although Andrew should feel free to correct me if I'm wrong :-D.


> it puts some pressure on the ndiswrapper guys

And removing 8kb all-together doesn't do this?


> and leaves time for the broadcom driver developers to finish, merge  
> and push to the distributions their driver

It's working partially now.  This is the time when we should really  
try to force ndiswrapper junkies over to the driver to get it tested  
and bugfixed for inclusion.


> The 8kb config option can be removed in the future when we're sure  
> that it's 100% safe (neil brown's patch isn''t a good sign). It  
> makes every happy IMO ;)

We're not trying to get it removed from mainline (yet), just from - 
mm, which has never been anywhere close to 100% safe _anyways_.  If  
it breaks lots of things horribly, it will get reverted and  
development will continue as normal, but that's probably not going to  
be the case.

Cheers,
Kyle Moffett

--
Debugging is twice as hard as writing the code in the first place.   
Therefore, if you write the code as cleverly as possible, you are, by  
definition, not smart enough to debug it.
   -- Brian Kernighan



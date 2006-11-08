Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161169AbWKHQWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161169AbWKHQWB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 11:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161179AbWKHQWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 11:22:01 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16652 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161177AbWKHQWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 11:22:00 -0500
Date: Wed, 8 Nov 2006 17:22:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: 2.6.19-rc5: known regressions
Message-ID: <20061108162202.GA4729@stusta.de>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <20061108085235.GT4729@stusta.de> <m1y7qm425l.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0611080745150.3667@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611080745150.3667@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 07:47:07AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 8 Nov 2006, Eric W. Biederman wrote:
> > 
> > I haven't seen anyone reproduce this but Tim Chen, and Tim wasn't
> > able to root cause the problem so I believe we are going to have
> > this regression :(
> 
> Note that you really shouldn't look too closely at lmbench scheduling 
> fluctuations. They can fluctuate a _lot_, especially under SMP, and it can 
> depend on things like cache layout that has nothing to do with the 
> scheduler (ie just code movement can make the lmbench numbers change).
> 
> So there are "regressions" and there are "shit happens". It can sometimes 
> be hard to tell the two apart, of course ;)

There's perhaps one thing that might help us to see whether it's just a 
benchmark effekt or a real problem:

With Tim's CONFIG_NR_CPUS=8, NR_IRQS only increases from 224 in 2.6.18 
to 512 in 2.6.19-rc.

With CONFIG_NR_CPUS=255, NR_IRQS increases from 224 in 2.6.18
to 8416 in 2.6.19-rc.

@Tim:
Can you try CONFIG_NR_CPUS=255 with both 2.6.18 and 2.6.19-rc5?

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


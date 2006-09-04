Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWIDSmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWIDSmA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 14:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWIDSmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 14:42:00 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53517 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751448AbWIDSl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 14:41:59 -0400
Date: Mon, 4 Sep 2006 20:41:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@osdl.org>,
       Sukadev Bhattiprolu <sukadev@us.ibm.com>, linux-kernel@vger.kernel.org,
       parisc-linux@parisc-linux.org
Subject: Re: [PATCH] Fix conflict with the is_init identifier on parisc
Message-ID: <20060904184156.GY4416@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org> <20060904114130.GN4416@stusta.de> <20060904134826.GF2558@parisc-linux.org> <m164g37an8.fsf_-_@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m164g37an8.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 12:24:27PM -0600, Eric W. Biederman wrote:
> Matthew Wilcox <matthew@wil.cx> writes:
> 
> > On Mon, Sep 04, 2006 at 01:41:30PM +0200, Adrian Bunk wrote:
> >> pidspace-is_init.patch causes the following compile error on parisc:
> >> 
> >> <--  snip  -->
> >> 
> >> ...
> >>   CC      arch/parisc/kernel/module.o
> >>
> > /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/arch/parisc/kernel/module.c:76:
> > error: conflicting types for 'is_init'
> >> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/include/linux/sched.h:1090:
> > error: previous definition of 'is_init' was here
> >> make[2]: *** [arch/parisc/kernel/module.o] Error 1
> >> 
> >> <--  snip  -->
> >
> > Looks like ia64 calls the same function in_init().  I'm tempted to
> > change parisc to have the same name.
> 
> How does the following patch look?
> Since I don't have a parisc compiler so I haven't compile tested it.
> But it is a simple substitute and replace and I can't see any problems
> by inspection so it should work.
>...

Thanks, I can confirm it fixes the compilation.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


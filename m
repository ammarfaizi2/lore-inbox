Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269181AbUJKS3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269181AbUJKS3w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 14:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269169AbUJKS0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 14:26:51 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1033 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269196AbUJKSZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 14:25:52 -0400
Date: Mon, 11 Oct 2004 20:25:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: joshk@triplehelix.org, linux-kernel@vger.kernel.org
Subject: Re: Weirdness with suspending jobs in 2.6.9-rc3
Message-ID: <20041011182518.GA1892@stusta.de>
References: <20041005063324.GA7445@darjeeling.triplehelix.org> <20041009101552.GA3727@stusta.de> <20041009140551.58fce532.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041009140551.58fce532.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2004 at 02:05:51PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> > On Mon, Oct 04, 2004 at 11:33:24PM -0700, Joshua Kwan wrote:
>...
> >  > darjeeling:~{1}% bg
> >  > [1]  + continued  make
> >  > make: *** wait: No child processes.  Stop.
> >  > make: *** Waiting for unfinished jobs....
>...
> >  I'm also observing this problem.
> 
> Neither I not Roland could reproduce this.
> 
> >  It doesn't depend on which version I'm compiling, it depends on which 
> >  kernel I'm actually running.
> > 
> >  (2.6.9-rc1 is OK, 2.6.8-rc3-mm3 is not OK.)
> 
> What about current -linus?
> 
> Is there any way in which you can do a bit of bisecting, identify the
> offending patch?

The problem seems to be surprisingly old.

In -mm, I was able to reproduce it in 2.6.8.1-mm1 (several older -mm 
kernels don't boot on my machine due to the floppy issues already 
discussed).

In Linus' tree, 2.6.9-rc1 is OK, but both 2.6.9-rc2 and 2.6.9-rc4 show 
this problem.

What else might matter? Userspace? I'm using a Debian unstable.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


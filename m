Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266669AbUJIKQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266669AbUJIKQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 06:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUJIKQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 06:16:28 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44558 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S266669AbUJIKQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 06:16:25 -0400
Date: Sat, 9 Oct 2004 12:15:52 +0200
From: Adrian Bunk <bunk@stusta.de>
To: joshk@triplehelix.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Weirdness with suspending jobs in 2.6.9-rc3
Message-ID: <20041009101552.GA3727@stusta.de>
References: <20041005063324.GA7445@darjeeling.triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041005063324.GA7445@darjeeling.triplehelix.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 11:33:24PM -0700, Joshua Kwan wrote:

> Hello,
> 
> It seems that make (possibly among other things) has been affected by
> some change in 2.6.9-rcX that prevents it from resuming some jobs.
> 
> I created this Makefile as a testcase:
> 
> all:
> 	sleep 5
> 	echo Hi
> 	sleep 5
> 
> The result:
> 
> darjeeling:~{0}% make
> sleep 5
> 
> zsh: suspended  make
> darjeeling:~{1}% bg
> [1]  + continued  make
> make: *** wait: No child processes.  Stop.
> make: *** Waiting for unfinished jobs....
> darjeeling:~{1}% echo Hi
> Hi
> make: *** Waiting for unfinished jobs....
> sleep 5
> make: *** Waiting for unfinished jobs....
> 
> [1]  + exit 2     make
> 
> This happens with bash also. I'm pretty sure it didn't use to happen
> with older kernels. Any ideas?


I'm also observing this problem.

It doesn't depend on which version I'm compiling, it depends on which 
kernel I'm actually running.

(2.6.9-rc1 is OK, 2.6.8-rc3-mm3 is not OK.)


> Thanks
> Joshua Kwan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


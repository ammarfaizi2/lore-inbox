Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267421AbUJIVIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267421AbUJIVIE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 17:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267424AbUJIVIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 17:08:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:26244 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267421AbUJIVH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 17:07:59 -0400
Date: Sat, 9 Oct 2004 14:05:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: joshk@triplehelix.org, linux-kernel@vger.kernel.org
Subject: Re: Weirdness with suspending jobs in 2.6.9-rc3
Message-Id: <20041009140551.58fce532.akpm@osdl.org>
In-Reply-To: <20041009101552.GA3727@stusta.de>
References: <20041005063324.GA7445@darjeeling.triplehelix.org>
	<20041009101552.GA3727@stusta.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> On Mon, Oct 04, 2004 at 11:33:24PM -0700, Joshua Kwan wrote:
> 
>  > Hello,
>  > 
>  > It seems that make (possibly among other things) has been affected by
>  > some change in 2.6.9-rcX that prevents it from resuming some jobs.
>  > 
>  > I created this Makefile as a testcase:
>  > 
>  > all:
>  > 	sleep 5
>  > 	echo Hi
>  > 	sleep 5
>  > 
>  > The result:
>  > 
>  > darjeeling:~{0}% make
>  > sleep 5
>  > 
>  > zsh: suspended  make
>  > darjeeling:~{1}% bg
>  > [1]  + continued  make
>  > make: *** wait: No child processes.  Stop.
>  > make: *** Waiting for unfinished jobs....
>  > darjeeling:~{1}% echo Hi
>  > Hi
>  > make: *** Waiting for unfinished jobs....
>  > sleep 5
>  > make: *** Waiting for unfinished jobs....
>  > 
>  > [1]  + exit 2     make
>  > 
>  > This happens with bash also. I'm pretty sure it didn't use to happen
>  > with older kernels. Any ideas?
> 
> 
>  I'm also observing this problem.

Neither I not Roland could reproduce this.

>  It doesn't depend on which version I'm compiling, it depends on which 
>  kernel I'm actually running.
> 
>  (2.6.9-rc1 is OK, 2.6.8-rc3-mm3 is not OK.)

What about current -linus?

Is there any way in which you can do a bit of bisecting, identify the
offending patch?


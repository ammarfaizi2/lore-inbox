Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWEJUX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWEJUX7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 16:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWEJUX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 16:23:59 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:31250 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932460AbWEJUX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 16:23:58 -0400
Date: Wed, 10 May 2006 22:24:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Walker <dwalker@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
Message-ID: <20060510202401.GS3570@stusta.de>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com> <1147257266.17886.3.camel@localhost.localdomain> <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net> <1147273787.17886.46.camel@localhost.localdomain> <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net> <Pine.LNX.4.58.0605101116590.5532@gandalf.stny.rr.com> <20060510162404.GR3570@stusta.de> <Pine.LNX.4.58.0605101240190.20305@gandalf.stny.rr.com> <Pine.LNX.4.58.0605101327380.20305@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605101327380.20305@gandalf.stny.rr.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 01:45:58PM -0400, Steven Rostedt wrote:
> 
> Oh fsck! gcc is hosed. I just tried out this BS module:
>...
> And this is what I got!
> 
>   CC [M]  /home/rostedt/c/modules/warning.o
> /home/rostedt/c/modules/warning.c: In function 'warn_here':
> /home/rostedt/c/modules/warning.c:14: warning: 'x' is used uninitialized in this function
>   Building modules, stage 2.
> 
> 
> Why the fsck isn't the func but_not_here not getting a warning for the
> first use of printk??  If I remove the if statement it gives me the
> warning.  Hell, that if statement isn't even entered (g = 0).
>...

I can't reproduce this, gcc 4.1 gives me:

  CC [M]  init/test.o
init/test.c: In function 'warn_here':
init/test.c:14: warning: 'x' is used uninitialized in this function
init/test.c: In function 'but_not_here':
init/test.c:23: warning: 'y' is used uninitialized in this function

> -- Steve

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


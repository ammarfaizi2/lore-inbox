Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316598AbSFGKgd>; Fri, 7 Jun 2002 06:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317263AbSFGKgc>; Fri, 7 Jun 2002 06:36:32 -0400
Received: from slip-202-135-75-200.ca.au.prserv.net ([202.135.75.200]:9089
	"EHLO wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S316598AbSFGKgb>; Fri, 7 Jun 2002 06:36:31 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: andersen@codepoet.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [PATCH] initcall dependency solution. 
In-Reply-To: Your message of "Fri, 07 Jun 2002 01:26:37 CST."
             <20020607072636.GA20454@codepoet.org> 
Date: Fri, 07 Jun 2002 20:15:01 +1000
Message-Id: <E17GGlp-0000cd-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020607072636.GA20454@codepoet.org> you write:
> On Fri Jun 07, 2002 at 12:02:11PM +1000, Rusty Russell wrote:
> > This patch allows you to name initcall dependencies and subsystems.
> > It is backward compatible with the current initcall levels, but
> > doesn't respect link order: a couple of changes to make it boot, but
> > more will be needed I expect.
> 
> Interesting.  So in theory this mechanism could also be used 
> to speed booting by parallelizing execution of each independent
> initcall dependancy tree...

In theory.  But the right solution is to move userspace as soon as
possible, for spinning up non-root disks, etc.

More importantly we can use the same mechanism to say "do this after
all cpus are up" or "do this once we have a userspace" etc, and move
more things to initcalls (ie. neaten the boot code).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

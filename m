Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279754AbRKIJaq>; Fri, 9 Nov 2001 04:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279768AbRKIJa1>; Fri, 9 Nov 2001 04:30:27 -0500
Received: from [194.213.32.133] ([194.213.32.133]:31873 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S279739AbRKIJaU>;
	Fri, 9 Nov 2001 04:30:20 -0500
Date: Thu, 8 Nov 2001 12:39:38 +0000
From: Pavel Machek <pavel@suse.cz>
To: Kevin Easton <s3159795@student.anu.edu.au>
Cc: linux-kernel@vger.kernel.org, riel@conectiva.com.br
Subject: Re: Scheduling of low-priority background processes
Message-ID: <20011108123938.A45@toy.ucw.cz>
In-Reply-To: <20011106190757.A28090@beernut.flames.org.au> <20011106202212.A28518@beernut.flames.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011106202212.A28518@beernut.flames.org.au>; from s3159795@student.anu.edu.au on Tue, Nov 06, 2001 at 08:22:12PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> I foolishly muttered:
> 
> > What if the SCHED_IDLE behaviour only applies when the process 
> > is in userspace? Couldn't scheduler compare the process's 
> > instruction pointer against the kernel/user break point, and 
> > if the process is in the kernel, then just treat it like a 
> > normal process? 
> 
> ...eek.   I clearly wasn't thinking straight with that one.  There
> isn't a (non-disgusting) way of determining in the scheduler if a
> process is executing a syscall apart from sys_sched_yield, is there.

Actually, something similar was implemented. New process flag was added,
and when process did syscall, it lost SCHED_IDLE flag, and it was returned
to it when it went back to userland.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.


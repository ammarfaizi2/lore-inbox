Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280006AbRKIRml>; Fri, 9 Nov 2001 12:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280016AbRKIRmc>; Fri, 9 Nov 2001 12:42:32 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:4225 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S280012AbRKIRmU>; Fri, 9 Nov 2001 12:42:20 -0500
Date: Fri, 9 Nov 2001 10:39:59 -0700
Message-Id: <200111091739.fA9Hdx107488@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Pavel Machek <pavel@suse.cz>
Cc: Kevin Easton <s3159795@student.anu.edu.au>, linux-kernel@vger.kernel.org,
        riel@conectiva.com.br
Subject: Re: Scheduling of low-priority background processes
In-Reply-To: <20011108123938.A45@toy.ucw.cz>
In-Reply-To: <20011106190757.A28090@beernut.flames.org.au>
	<20011106202212.A28518@beernut.flames.org.au>
	<20011108123938.A45@toy.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:
> Hi!
> > I foolishly muttered:
> > 
> > > What if the SCHED_IDLE behaviour only applies when the process 
> > > is in userspace? Couldn't scheduler compare the process's 
> > > instruction pointer against the kernel/user break point, and 
> > > if the process is in the kernel, then just treat it like a 
> > > normal process? 
> > 
> > ...eek.   I clearly wasn't thinking straight with that one.  There
> > isn't a (non-disgusting) way of determining in the scheduler if a
> > process is executing a syscall apart from sys_sched_yield, is there.
> 
> Actually, something similar was implemented. New process flag was
> added, and when process did syscall, it lost SCHED_IDLE flag, and it
> was returned to it when it went back to userland.

That's the sensible approach. Is anyone maintaining that patch and
sending it to Linus for inclusion?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

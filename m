Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272587AbTHEJEw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 05:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272588AbTHEJEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 05:04:52 -0400
Received: from pop.gmx.net ([213.165.64.20]:748 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272587AbTHEJEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 05:04:51 -0400
Message-Id: <5.2.1.1.2.20030805104620.01974e28@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 05 Aug 2003 11:09:02 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O13int for interactivity
Cc: Oliver Neukum <oliver@neukum.org>, Andrew Morton <akpm@osdl.org>,
       piggin@cyberone.com.au, linux-kernel@vger.kernel.org, mingo@elte.hu,
       felipe_alfaro@linuxmail.org
In-Reply-To: <200308051843.54357.kernel@kolivas.org>
References: <5.2.1.1.2.20030805102719.01a06d48@pop.gmx.net>
 <200308051012.12951.oliver@neukum.org>
 <5.2.1.1.2.20030805102719.01a06d48@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:43 PM 8/5/2003 +1000, Con Kolivas wrote:
>On Tue, 5 Aug 2003 18:27, Mike Galbraith wrote:
> > At 06:20 PM 8/5/2003 +1000, Con Kolivas wrote:
> > >Every experiment I've tried at putting tasks at the start of the queue
> > >instead
> > >of the end has resulted in some form of starvation so should not be
> > > possible for any user task and I've abandoned it.
> >
> > (ditto:)
>
>Superuser access real time tasks may be worth reconsidering though...

If they were guaranteed ultra-light, maybe, but userland is just not 
trustworthy.

Better imho would be something like Davide's SOFT_RR with an additional 
automatic priority adjust per cpu usage or something (cpu usage being a 
[very] little bit of a latency hint, and a great 'hurt me' hint).  Best 
would be an API that allowed userland applications to describe their 
latency requirements explicitly, with the scheduler watching users of this 
API like a hawk, ever ready to sanction abusers.  Anything I think about in 
this area gets uncomfortably close to hard rt though, and all of the wisdom 
I've heard on LKLM over the years wrt separation of problem spaces comes 
flooding back.

         -Mike 


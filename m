Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272605AbTHEJOc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 05:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272608AbTHEJOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 05:14:31 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:36509
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272605AbTHEJOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 05:14:24 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O13int for interactivity
Date: Tue, 5 Aug 2003 19:19:28 +1000
User-Agent: KMail/1.5.3
Cc: Oliver Neukum <oliver@neukum.org>, Andrew Morton <akpm@osdl.org>,
       piggin@cyberone.com.au, linux-kernel@vger.kernel.org, mingo@elte.hu,
       felipe_alfaro@linuxmail.org
References: <5.2.1.1.2.20030805102719.01a06d48@pop.gmx.net> <5.2.1.1.2.20030805104620.01974e28@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030805104620.01974e28@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308051919.28681.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 19:09, Mike Galbraith wrote:
> At 06:43 PM 8/5/2003 +1000, Con Kolivas wrote:
> >On Tue, 5 Aug 2003 18:27, Mike Galbraith wrote:
> > > At 06:20 PM 8/5/2003 +1000, Con Kolivas wrote:
> > > >Every experiment I've tried at putting tasks at the start of the queue
> > > >instead
> > > >of the end has resulted in some form of starvation so should not be
> > > > possible for any user task and I've abandoned it.
> > >
> > > (ditto:)
> >
> >Superuser access real time tasks may be worth reconsidering though...
>
> If they were guaranteed ultra-light, maybe, but userland is just not
> trustworthy.

Agreed 

> Better imho would be something like Davide's SOFT_RR with an additional
> automatic priority adjust per cpu usage or something (cpu usage being a
> [very] little bit of a latency hint, and a great 'hurt me' hint).  Best
> would be an API that allowed userland applications to describe their
> latency requirements explicitly, with the scheduler watching users of this
> API like a hawk, ever ready to sanction abusers.  Anything I think about in
> this area gets uncomfortably close to hard rt though, and all of the wisdom
> I've heard on LKLM over the years wrt separation of problem spaces comes
> flooding back.

I'll pass. There's enough on my plate already. Soft_rr in some form is a 
decent idea but best tackled separately.

Con


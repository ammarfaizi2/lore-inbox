Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267776AbTBRMRo>; Tue, 18 Feb 2003 07:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267777AbTBRMRo>; Tue, 18 Feb 2003 07:17:44 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:37138 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267776AbTBRMRm>; Tue, 18 Feb 2003 07:17:42 -0500
Date: Tue, 18 Feb 2003 13:26:56 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Werner Almesberger <wa@almesberger.net>, <kuznet@ms2.inr.ac.ru>,
       <davem@redhat.com>, <kronos@kronoz.cjb.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Migrating net/sched to new module interface 
In-Reply-To: <20030218024852.9557D2C17F@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0302181306430.1336-100000@serv>
References: <20030218024852.9557D2C17F@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 18 Feb 2003, Rusty Russell wrote:

> > Maybe you could share a bit of your wisdom?
> > 1. Doing the linking in userspace requires two steps, but I still don't 
> > know what's so bad about it.
> > 2. This still doesn't explain, why everything has to be moved into kernel, 
> > why can't we move more into userspace?
> > 3. You simply moved part of the query syscall functionality to 
> > /proc/modules (which btw is still not enough to fix ksymoops).
> 
> I think you'd do far better to implement it yourself for half a dozen
> architectures.  It's not my job to teach you things which can be
> gained by reading the code and thinking a little.

As usual you explain nothing, so I still don't know why a complete rewrite 
was necessary. The old implementation did work fine within limits and 
already has support for all architectures, so why should I just throw it 
away? Why was it not possible to first fix the problems of the old system?

> > Well, I'm not against optimizing the module locking (*), as we won't get 
> > rid of it in the near feature, but it still has problems.
> > 
> > 1. It's adding complexity (however you implement it), I explained it in 
> > detail and you still haven't told me, where I'm wrong.
> 
> No, it's exactly the same as before.  You can't see that, and I've
> given up explaining it.

So far you explained nothing and if you would just read and try to 
understand that damned mail(*), you would know, that I already said that 
the complexity is "exactly the same as before". I'm comparing it to other 
solutions, which you obviously haven't understood.

(*) http://marc.theaimsgroup.com/?l=linux-kernel&m=104284223130775&w=2

> > 2. The module interface is incompatible with other kernel interfaces, I 
> > tried to explain that in the mail from saturday, if you think I'm wrong, 
> > your input is very welcome, but _please_ answer to that mail.
> 
> This problem is in your mind Roman.

Thanks for another detailed explaination. :(

> > It's too much fun to quote Al here:
> 
> Quoting Al's rant isn't an argument.  It wasn't very coherent when he
> wrote it, and it doesn't gain with repetition.

Well, if you don't even try to understand, what Al is trying to tell you, 
I'm afraid I can't help you either.

> The code exists.  It's simple to use.
> 
> I give up.  You're killfiled again 8(

I seriously consider to take over modules maintainership, but I have 
neither the energy nor the time to do this alone, so I can only wish 
everyone much fun with modules during 2.6.

bye, Roman


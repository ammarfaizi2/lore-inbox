Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311939AbSCOFtO>; Fri, 15 Mar 2002 00:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311940AbSCOFsx>; Fri, 15 Mar 2002 00:48:53 -0500
Received: from [202.135.142.196] ([202.135.142.196]:45831 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S311939AbSCOFst>; Fri, 15 Mar 2002 00:48:49 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: davidm@hpl.hp.com
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, rth@twiddle.net
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas 
In-Reply-To: Your message of "Thu, 14 Mar 2002 20:19:21 -0800."
             <15505.30281.414005.400815@napali.hpl.hp.com> 
Date: Fri, 15 Mar 2002 16:52:01 +1100
Message-Id: <E16lkdG-0001kx-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <15505.30281.414005.400815@napali.hpl.hp.com> you write:
> >>>>> On Fri, 15 Mar 2002 15:07:27 +1100, Rusty Russell <rusty@rustcorp.com.a
u> said:
> 
>   Rusty> Sorry, after thought, I've reverted to my original position.  the
>   Rusty> original SMP per_cpu()/this_cpu() implementations were broken.
> 
>   Rusty> They must return an lvalue, otherwise they're useless for 50% of cas
es
>   Rusty> (ie. assignment).  x86_64 can still use its own mechanism for
>   Rusty> arch-specific per-cpu data, of course.
> 
> What's your position about someone taking the address of this_cpu(foo)
> and passing it to another CPU?  IMO, the effect of this should be
> allowed to be implementation-dependent.  If you agree, perhaps it
> would be good to add a comment to this effect?

Well, if you want to do TLB tricks, sure.  I don't know if that's a
good idea (Linus seems opposed to it).  But I'll add the comment.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

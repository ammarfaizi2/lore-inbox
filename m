Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314413AbSE2Emp>; Wed, 29 May 2002 00:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314433AbSE2Emo>; Wed, 29 May 2002 00:42:44 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:34013 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S314413AbSE2Emo>; Wed, 29 May 2002 00:42:44 -0400
Date: Wed, 29 May 2002 14:44:56 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: davem@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        paul.mckenney@us.ibm.com, andrea@suse.de
Subject: Re: 8-CPU (SMP) #s for lockfree rtcache
Message-Id: <20020529144456.52c1bc1d.rusty@rustcorp.com.au>
In-Reply-To: <m3bsb06zt7.fsf@averell.firstfloor.org>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 May 2002 17:45:56 +0200
Andi Kleen <ak@muc.de> wrote:

> "David S. Miller" <davem@redhat.com> writes:
> 
> >    From: Dipankar Sarma <dipankar@in.ibm.com>
> >    Date: Tue, 28 May 2002 18:28:06 +0530
> >    
> >    Well, the last time RCU was discussed, Linus said that he would
> >    like to see someplace where RCU clearly helps.
> > 
> > Alexey and I are in firm agreement that the routing cache
> > clearly benefits from RCU.
> 
> The next obvious benefitor IMHO is module unloading.

There is a much bigger question here, which is "are modules first class
citizens"?  Doing it properly turns us into a poor-man's microkernel.
We would standardize our registration interfaces (similar to the standard
notifier.h), and have them all do the inc and decs.

OTOH, if you treat module removal as a CONFIG_DEBUG_KERNEL thing, life
becomes much much simpler.

I have the code, I'll be serious about it in ~2 months.
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy

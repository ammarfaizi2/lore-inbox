Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbUCMKKf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 05:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbUCMKKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 05:10:35 -0500
Received: from pop.gmx.net ([213.165.64.20]:61327 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263077AbUCMKK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 05:10:26 -0500
X-Authenticated: #1226656
Date: Sat, 13 Mar 2004 11:10:21 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4 on Alpha uninterruptible sleep of processes
Message-Id: <20040313111021.4af73b9e@hdg.gigerstyle.ch>
In-Reply-To: <20040313020141.B4021@den.park.msu.ru>
References: <20040312154613.7567adab@hdg.gigerstyle.ch>
	<20040312182754.A680@jurassic.park.msu.ru>
	<20040312184115.B680@jurassic.park.msu.ru>
	<20040312165907.626d4a08@hdg.gigerstyle.ch>
	<20040312224649.A750@den.park.msu.ru>
	<20040312215215.1041889a@hdg.gigerstyle.ch>
	<20040313020141.B4021@den.park.msu.ru>
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

On Sat, 13 Mar 2004 02:01:41 +0300
Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:

> On Fri, Mar 12, 2004 at 09:52:15PM +0100, Marc Giger wrote:
> > Right now I'm recompiling the kernel. So you say this patch isn't a
> > fix but a test? 
> 
> Yes. That patch just reverts new alpha semaphore stuff which went
> into 2.6.4.
> 
> > This time I have additionally "semaphore debugging" enabled,
> > perhaps it's useful for you.
> 
> Thanks, this might be helpful.

Hmm, I couldn't boot the kernel with enabled "semaphore debugging". It
hangs directly after aboot. No messages, nothing. Do I something wrong?
Now I've booted 2.6.4 without debugging.

> 
> > > The answer is here:
> > > http://bugzilla.kernel.org/show_bug.cgi?id=397
> > 
> > That's no answer, that's a statement:-) Do know the exactly reason
> > why it should be a bad idea? Is it mostly a bad idea on alpha?
> 
> Hmm, I haven't discussed that with Richard, so I can't speak for him
> :-) IMHO, the benefits of the kernel preempt support in general are
> more than doubtful, the level of complexity that it adds to the kernel
> code is just unacceptable.

Ok, but I read somewhere exactly the opposite (lkml?).
The statement was something like the following: "Preempt doesn't need
much more infrastrucure in kernel code, because the needed locking
mechanism is already there (SMP)."

So I'm confused now:-) But I understand that every little more
complexity is not for free. More task switches etc...

Thank you for the infos.

greets

Marc

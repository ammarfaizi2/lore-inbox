Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265886AbSLSRkZ>; Thu, 19 Dec 2002 12:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265890AbSLSRkZ>; Thu, 19 Dec 2002 12:40:25 -0500
Received: from zeke.inet.com ([199.171.211.198]:50573 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S265886AbSLSRkV>;
	Thu, 19 Dec 2002 12:40:21 -0500
Message-ID: <3E020660.9020507@inet.com>
Date: Thu, 19 Dec 2002 11:48:16 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
       alan@lxorguk.ukuu.org.uk, lm@bitmover.com, lm@work.bitmover.com,
       torvalds@transmeta.com, vonbrand@inf.utfsm.cl, akpm@digeo.com
Subject: Re: Dedicated kernel bug database
References: <200212191335.gBJDZRDL000704@darkstar.example.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> Following on from yesterday's discussion about there not being much
> interaction between the kernel Bugzilla and the developers, I began
> wondering whether Bugzilla might be a bit too generic to be suited to
> kernel development, and that maybe a system written from the ground up
> for reporting kernel bugs would be better?

Can you perhaps improve bugzilla instead of starting over?  (I have not 
looked at bugzilla code... I'm just hoping we can build from where we 
are instead of starting over.)

> I.E. I am prepared to write it myself, if people think it's
> worthwhile.
> 
> For example, we get a lot of posts on LKML like this:
> 
> "Hi, foobar doesn't work in 2.4.19"
> 
> Now, does that mean:
> 
> * The bug first appeared in 2.4.19, and is still in 2.4.20
> * The bug reporter hasn't tested 2.4.20
> * The bug reporter can't test 2.4.20 because something else is broken
> * The bug actually first appeared in 2.4.10, but it didn't irritate
>   them enough to complain until now.

This case is not specific to the kernel:
"feature X doesn't work in program Y version Z"
it may appear in Z-3 through Z+1, but fixed in Z+2, etc.
So I hope it is something that could be done in/added to bugzilla.

> A bug database designed from scratch could allow such information to
> be indexed in a way that could be processed and searched usefully.  A
> list of tick-boxes for worked/didn't work/didn't test/couldn't test
> for several kernel versions could be presented.
> 
> Also, we could have a non-web interface, (telnet or gopher to the bug
> DB, or control it by E-Mail).

Can you interface with bugzilla's database backend maybe?  It seems like 
refactoring bugzilla might be better?

> It could warn the user if they attach an un-decoded oops that their
> bug report isn't as useful as it could be, and if they mention a
> distribution kernel version, that it's not a tree that the developers
> will necessarily be familiar with.

Perhaps a more generalized hook into bugzilla for 'validating' a bug 
report, then code specific validators for kernel work?

> I'm not criticising the fact that we've got Bugzilla up and running,
> but just pointing out that we could do better, (and I'm prepared to
> put in the time and effort).  I just need ideas, really.

I certainly do not want to stand in your way!  I just hope you can stand 
on the shoulders of giants.

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------


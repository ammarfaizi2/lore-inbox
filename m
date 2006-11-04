Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965230AbWKDKZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbWKDKZT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 05:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965242AbWKDKZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 05:25:19 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:36752 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S965230AbWKDKZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 05:25:16 -0500
Date: Sat, 4 Nov 2006 13:24:23 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Oleg Verych <olecom@flower.upol.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061104102423.GA4780@2ka.mipt.ru>
References: <1154985aa0591036@2ka.mipt.ru> <1162380963981@2ka.mipt.ru> <20061101130614.GB7195@atrey.karlin.mff.cuni.cz> <20061101132506.GA6433@2ka.mipt.ru> <20061101160551.GA2598@elf.ucw.cz> <20061101162403.GA29783@2ka.mipt.ru> <slrnekhpbr.2j1.olecom@flower.upol.cz> <20061101185745.GA12440@2ka.mipt.ru> <20061103184916.GA17142@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061103184916.GA17142@flower.upol.cz>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 04 Nov 2006 13:24:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2006 at 07:49:16PM +0100, Oleg Verych (olecom@flower.upol.cz) wrote:
> > applications can be found on project's homepage.
> > There is a link to archive there, where you can find plenty of sources.
> 
> But no single makefile. Or what CC and options do not mater really?
> You can easily find in your server's apache logs, my visit of that
> archive in the day of my message (today i just confirmed my assertions):
> browser lynx, host flower.upol.cz.

If you can not compile that sources, than you should not use kevent for
a while. Definitely.
Options are pretty simple: -W -Wall -I$(path_to_kernel_tree)/include

> > You likely do not know, but it is a bit risky business to patch all
> > existing applications to show that approach is correct, if
> > implementation is not completed.
> 
> Fortunately to me, `lighthttpd' is real-life *and* in the benchmark
> area also. Just see that site how much there was measured: different OSes,
> special tunning. *That* is i'm talking about. Epoll _wrapper_ there,
> is 3461 byte long, your answer to _me_ 2580. People are bringing you a
> test bed, with all set up ready to use; need less code, go on, comment
> needless out!

So what?
People bring me tons of various stuff, and I prefer to use my own for
tests. If _you_ need it, _you_ can always patch any sources you like.

> > You likely do not know, but after I first time announced kevents in
> > February I changed interfaces 4 times - and it is just interfaces, not
> > including numerous features added/removed by developer's requests.
> 
> I think that called open source, linux kernel case.

You missed the point - I'm not going to patch tons of existing
applications when I'm asked to change an interface once per month.

When all requested features are implemented I definitely with patch some
popular web-server to show how kevent is used.

> > > There were some comments about laking much of such programs, answers were
> > > "was in prev. e-mail", "need to update them", something like that.
> > > "Trivial web server" sources url, mentioned in benchmark isn't pointed
> > > in patch advertisement. If it was, should i actually try that new
> > > *trivial* wheel?
> > 
> > Answer is trivial - there is archive where one can find a source code
> > (filenames are posted regulary). Should I create a rpm? For what glibc
> > version?
> 
> Hmm. Let me answer on that "dup" with stuff from LKML archive. That
> will reveal, that my guesses were told by The Big Jury to you already:
> 
> [^0] Message-ID: 44CA66D8.3010404@oracle.com
> [^1] Message-ID: 20060818104120.GA20816@infradead.org,
>      Message-ID: 20060816133014.GB32499@infradead.org
> 
> more than 10 takes ago.

And? Please provide a link to archive.

> > > Saying that, i want to give you some short examples, i know.
> > > *Linux kernel <-> userspace*:
> > > o Alexey Kuznetsov  networking     <-> (excellent) iproute set of utilities;
> > 
> > iproute documentation was way too bad when Alexey presented it first 
> > time :)
> 
> As example, after have read some books on TCP/IP and Ethernet, internal
> help of `ip' was all i needed to know.

:)) i.e. it is ok for you to 'read some books on TCP/IP and Ethernet' to
understand how utility works, and it is not ok to determine how to
compile my sources? Do not compile my sources.

> > Btw, show me splice() 'shiny' application? Does lighttpd use it?
> > Or move_pages().
> 
> You know who proposed that, and you know how many (few) releases ago.

And why lighttpd still do not use it?
You should start to blame authors of the splice() for that.
You will not? Then I can not consider your words in my direction as
serious.

> > > To make a little hint to you, Evgeniy, why don't you find a little
> > > animal in the open source zoo to implement little interface to
> > > proposed kernel subsystem and then show it to The Big Jury (not me),
> > > we have here? And i can not see, how you've managed to implement
> > > something like that having almost nothing on the test basket.
> > > Very *suspicious* ch.
> > 
> > There are always people who do not like something, what can I do with
> 
> I didn't think, that my message was offensive. Also i didn't even say,
> that you have not bothered feed your code to "scripts/Lindent".

You do not use kevent, why do you care about indent of the userspace
tools?

> []
> > I created trivial web servers, which send single static page and use
> > various event handling schemes, and I test new subsystem with new tools,
> > when tests are completed and all requested features are implemented it
> > is time to work on different more complex users.
> 
> Please, see [^0],
> 
> > So let's at least complete what we have right now, so no developer's
> > efforts could be wasted writing empty chars in various places.
> 
> and [^1].
> 
> [ Please do not answer just to answer, cc list is big, no one from       ]
> [ The Big Jury seems to care. (well, Jonathan does, but he wasn't in cc) ]

This thread is just to answer for the sake of answers - there is
completely no sense in it.
You blame me that I did not create some benchmarks you like, but I do not
care about it. I created usefull patch and test is in the way I like,
because it is much more productive, than spending a lot of time
detemining how different sources work with appropriate loads.
When there will be strong requirement to perform additional tests, I
will do them.

> Friendly, Oleg.
> ____

-- 
	Evgeniy Polyakov

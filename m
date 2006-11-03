Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753444AbWKCSop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444AbWKCSop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 13:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450AbWKCSop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 13:44:45 -0500
Received: from raven.upol.cz ([158.194.120.4]:46236 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1753454AbWKCSon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 13:44:43 -0500
Date: Fri, 3 Nov 2006 19:49:16 +0100
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061103184916.GA17142@flower.upol.cz>
References: <1154985aa0591036@2ka.mipt.ru> <1162380963981@2ka.mipt.ru> <20061101130614.GB7195@atrey.karlin.mff.cuni.cz> <20061101132506.GA6433@2ka.mipt.ru> <20061101160551.GA2598@elf.ucw.cz> <20061101162403.GA29783@2ka.mipt.ru> <slrnekhpbr.2j1.olecom@flower.upol.cz> <20061101185745.GA12440@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101185745.GA12440@2ka.mipt.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 09:57:46PM +0300, Evgeniy Polyakov wrote:
> On Wed, Nov 01, 2006 at 06:20:43PM +0000, Oleg Verych (olecom@flower.upol.cz) wrote:
[] 
> > Where's real-life application to do configure && make && make install?
> 
> Your real life or mine as developer?
> I fortunately do not know anything about your real life, but my real life

To do not further shift conversation in no technical way, think of my
sentence as question *and* as definition.

> applications can be found on project's homepage.
> There is a link to archive there, where you can find plenty of sources.

But no single makefile. Or what CC and options do not mater really?
You can easily find in your server's apache logs, my visit of that
archive in the day of my message (today i just confirmed my assertions):
browser lynx, host flower.upol.cz.

> You likely do not know, but it is a bit risky business to patch all
> existing applications to show that approach is correct, if
> implementation is not completed.

Fortunately to me, `lighthttpd' is real-life *and* in the benchmark
area also. Just see that site how much there was measured: different OSes,
special tunning. *That* is i'm talking about. Epoll _wrapper_ there,
is 3461 byte long, your answer to _me_ 2580. People are bringing you a
test bed, with all set up ready to use; need less code, go on, comment
needless out!

> You likely do not know, but after I first time announced kevents in
> February I changed interfaces 4 times - and it is just interfaces, not
> including numerous features added/removed by developer's requests.

I think that called open source, linux kernel case.

> > There were some comments about laking much of such programs, answers were
> > "was in prev. e-mail", "need to update them", something like that.
> > "Trivial web server" sources url, mentioned in benchmark isn't pointed
> > in patch advertisement. If it was, should i actually try that new
> > *trivial* wheel?
> 
> Answer is trivial - there is archive where one can find a source code
> (filenames are posted regulary). Should I create a rpm? For what glibc
> version?

Hmm. Let me answer on that "dup" with stuff from LKML archive. That
will reveal, that my guesses were told by The Big Jury to you already:

[^0] Message-ID: 44CA66D8.3010404@oracle.com
[^1] Message-ID: 20060818104120.GA20816@infradead.org,
     Message-ID: 20060816133014.GB32499@infradead.org

more than 10 takes ago.

> > Saying that, i want to give you some short examples, i know.
> > *Linux kernel <-> userspace*:
> > o Alexey Kuznetsov  networking     <-> (excellent) iproute set of utilities;
> 
> iproute documentation was way too bad when Alexey presented it first 
> time :)

As example, after have read some books on TCP/IP and Ethernet, internal
help of `ip' was all i needed to know.

> Btw, show me splice() 'shiny' application? Does lighttpd use it?
> Or move_pages().

You know who proposed that, and you know how many (few) releases ago.
 
> > To make a little hint to you, Evgeniy, why don't you find a little
> > animal in the open source zoo to implement little interface to
> > proposed kernel subsystem and then show it to The Big Jury (not me),
> > we have here? And i can not see, how you've managed to implement
> > something like that having almost nothing on the test basket.
> > Very *suspicious* ch.
> 
> There are always people who do not like something, what can I do with

I didn't think, that my message was offensive. Also i didn't even say,
that you have not bothered feed your code to "scripts/Lindent".

[]
> I created trivial web servers, which send single static page and use
> various event handling schemes, and I test new subsystem with new tools,
> when tests are completed and all requested features are implemented it
> is time to work on different more complex users.

Please, see [^0],

> So let's at least complete what we have right now, so no developer's
> efforts could be wasted writing empty chars in various places.

and [^1].

[ Please do not answer just to answer, cc list is big, no one from       ]
[ The Big Jury seems to care. (well, Jonathan does, but he wasn't in cc) ]

Friendly, Oleg.
____

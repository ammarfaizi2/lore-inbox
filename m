Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265786AbTAXXjH>; Fri, 24 Jan 2003 18:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265863AbTAXXjH>; Fri, 24 Jan 2003 18:39:07 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:17339 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S265786AbTAXXjG>; Fri, 24 Jan 2003 18:39:06 -0500
Message-ID: <3E31D637.1030306@kegel.com>
Date: Fri, 24 Jan 2003 16:11:35 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Matti Aarnio <matti.aarnio@zmailer.org>, Corey Minyard <minyard@acm.org>,
       Mark Mielke <mark@mark.mielke.cc>, Mark Hahn <hahn@physics.mcmaster.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: debate on 700 threads vs asynchronous code
References: <Pine.LNX.4.33L2.0301241528100.9816-100000@dragon.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33L2.0301241528100.9816-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Sat, 25 Jan 2003, Matti Aarnio wrote:
> 
> | On Fri, Jan 24, 2003 at 04:53:46PM -0600, Corey Minyard wrote:
> | ...
> | > I would disagree.  One thread per connection is easier to conceptually
> | > understand.  In my experience, an event-driven model (which is what you
> | > end up with if you use one or a few threads) is actually easier to
> | > correctly implement and it tends to make your code more modular and
> | > portable.
> |
> |   An old thing from early annals of computer science (I browsed Knuth's
> | "The Art" again..) is called   Coroutine.
> |
> | Gives you "one thread per connection" programming model, but without
> | actual multiple scheduling threads in the kernel side.  ...
> | Doing coroutine library all in portable C (by means of setjmp()/longjmp())
> | is possible, but not very efficient.  A bit of assembly helps a lot.

There's also an elegant implementation that uses switch statements
or computed gotos; see http://www.chiark.greenend.org.uk/~sgtatham/coroutines.html
I'm using it.  It's a bit limited, but hey, it works for me.

> Davide Libenzi (epoll) likes and discusses coroutines on one of his
> web pages:  http://www.xmailserver.org/linux-patches/nio-improve.html
> (search for /coroutine/)

IMHO coroutines are harder to use than either threads or nonblocking I/O.
Then again, I don't like Scheme; many things in this world are a matter of taste.
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


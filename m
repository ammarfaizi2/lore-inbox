Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265865AbTAXXaD>; Fri, 24 Jan 2003 18:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265872AbTAXXaD>; Fri, 24 Jan 2003 18:30:03 -0500
Received: from air-2.osdl.org ([65.172.181.6]:27373 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265865AbTAXXaC>;
	Fri, 24 Jan 2003 18:30:02 -0500
Date: Fri, 24 Jan 2003 15:29:40 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: Corey Minyard <minyard@acm.org>, Mark Mielke <mark@mark.mielke.cc>,
       Dan Kegel <dank@kegel.com>, Mark Hahn <hahn@physics.mcmaster.ca>,
       <linux-kernel@vger.kernel.org>
Subject: Re: debate on 700 threads vs asynchronous code
In-Reply-To: <20030124232110.GN787@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.33L2.0301241528100.9816-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jan 2003, Matti Aarnio wrote:

| On Fri, Jan 24, 2003 at 04:53:46PM -0600, Corey Minyard wrote:
| ...
| > I would disagree.  One thread per connection is easier to conceptually
| > understand.  In my experience, an event-driven model (which is what you
| > end up with if you use one or a few threads) is actually easier to
| > correctly implement and it tends to make your code more modular and
| > portable.
|
|   An old thing from early annals of computer science (I browsed Knuth's
| "The Art" again..) is called   Coroutine.
|
| Gives you "one thread per connection" programming model, but without
| actual multiple scheduling threads in the kernel side.
|
| Simplest coroutine implementations are truly simple.. Pagefull of C.
| Knuth shows it with very few MIX (assembly) instructions.
|
| Throwing in non-blocking socket/filedescriptor access, and in event
| of "EAGAIN", coroutine-yielding to some other coroutine, does complicate
| things, naturally.
|
| Good coder finds balance in between various methods, possibly uses
| both coroutine "userspace threads", and actual kernel threads.
|
| Doing coroutine library all in portable C (by means of setjmp()/longjmp())
| is possible, but not very efficient.  A bit of assembly helps a lot.
|
| > -Corey
|
| /Matti Aarnio
| -

Davide Libenzi (epoll) likes and discusses coroutines on one of his
web pages:  http://www.xmailserver.org/linux-patches/nio-improve.html
(search for /coroutine/)

-- 
~Randy


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284143AbRLPAOY>; Sat, 15 Dec 2001 19:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284140AbRLPAOP>; Sat, 15 Dec 2001 19:14:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284143AbRLPAN5>; Sat, 15 Dec 2001 19:13:57 -0500
Date: Sat, 15 Dec 2001 16:13:12 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Just a second ...
In-Reply-To: <Pine.LNX.4.40.0112151552070.1560-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0112151603180.4493-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Dec 2001, Davide Libenzi wrote:
>
> when you find 10 secs free in your spare time i really would like to know
> the reason ( if any ) of your abstention from any schdeuler discussion.
> No hurry, just a few lines out of lkml.

I just don't find it very interesting. The scheduler is about 100 lines
out of however-many-million (3.8 at least count), and doesn't even impact
most normal performace very much.

We'll clearly do per-CPU runqueues or something some day. And that worries
me not one whit, compared to thigns like VM and block device layer ;)

I know a lot of people think schedulers are important, and the operating
system theory about them is overflowing - it's one of those things that
people can argue about forever, yet is conceptually simple enough that
people aren't afraid of it. I just personally never found it to be a major
issue.

Let's face it - the current scheduler has the same old basic structure
that it did almost 10 years ago, and yes, it's not optimal, but there
really aren't that many real-world loads where people really care. I'm
sorry, but it's true.

And you have to realize that there are not very many things that have
aged as well as the scheduler. Which is just another proof that scheduling
is easy.

We've rewritten the VM several times in the last ten years, and I expect
it will be changed several more times in the next few years. Withing five
years we'll almost certainly have to make the current three-level page
tables be four levels etc.

In comparison to those kinds of issues, I suspect that making the
scheduler use per-CPU queues together with some inter-CPU load balancing
logic is probably _trivial_. Patches already exist, and I don't feel that
people can screw up the few hundred lines too badly.

		Linus


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbSLHXbX>; Sun, 8 Dec 2002 18:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSLHXbX>; Sun, 8 Dec 2002 18:31:23 -0500
Received: from smtpout.mac.com ([17.250.248.86]:41209 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S261861AbSLHXbX>;
	Sun, 8 Dec 2002 18:31:23 -0500
Subject: Re: POSIX message queues, 2.5.50
From: Peter Waechtler <pwaechtler@mac.com>
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
Cc: linux-kernel@vger.kernel.org, wrona@mat.uni.torun.pl
In-Reply-To: <Pine.GSO.4.40.0212081826390.4105-100000@anna>
References: <Pine.GSO.4.40.0212081826390.4105-100000@anna>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Dec 2002 00:33:04 +0100
Message-Id: <1039390666.19736.1.camel@picklock>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-08 at 18:38, Krzysztof Benedyczak wrote:
> On Fri, 6 Dec 2002, Peter Waechtler wrote:
> >
> > >  - our implementation does support priority scheduling which is omitted in
> > > Peter's version (meaning that if many processes wait e.g. for a message
> > > _random_ one will get it). It is important because developers could rely
> > > on this feature - and it is as I think the most difficult part of
> > > implementation
> >
> > Well, can you give an realistic and sensible example where an app design
> > really takes advantage on this?
> >
> > If I've got a thread pool listening on the queue, I _expect_ non
> > predictability on which thread gets which message:
> 
> But someone could. When you implement POSIX message queues you have to
> follow the standard and not write something similar to it.
> Even if you mention in docs that your mqueues aren't strictly POSIX,
> someone can miss it and end up with hard to explain "bug" in his program.
> BTW as your implementation will act randomly I can't see how you will
> handle multiple readers (maybe except some trivial cases).
> 

Just iterating over and over again does not produce the truth.
It's not "random" - it's highly deterministic: the longest waiter
will be woken up.
EOT



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbSLHRbI>; Sun, 8 Dec 2002 12:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261524AbSLHRbI>; Sun, 8 Dec 2002 12:31:08 -0500
Received: from leon-2.mat.uni.torun.pl ([158.75.2.64]:32739 "EHLO
	leon-2.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id <S261426AbSLHRbH>; Sun, 8 Dec 2002 12:31:07 -0500
Date: Sun, 8 Dec 2002 18:38:23 +0100 (CET)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@anna
To: Peter Waechtler <pwaechtler@mac.com>
cc: linux-kernel@vger.kernel.org, <wrona@mat.uni.torun.pl>
Subject: Re: POSIX message queues, 2.5.50
In-Reply-To: <200212061232.28578.pwaechtler@mac.com>
Message-ID: <Pine.GSO.4.40.0212081826390.4105-100000@anna>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Dec 2002, Peter Waechtler wrote:
>
> >  - our implementation does support priority scheduling which is omitted in
> > Peter's version (meaning that if many processes wait e.g. for a message
> > _random_ one will get it). It is important because developers could rely
> > on this feature - and it is as I think the most difficult part of
> > implementation
>
> Well, can you give an realistic and sensible example where an app design
> really takes advantage on this?
>
> If I've got a thread pool listening on the queue, I _expect_ non
> predictability on which thread gets which message:

But someone could. When you implement POSIX message queues you have to
follow the standard and not write something similar to it.
Even if you mention in docs that your mqueues aren't strictly POSIX,
someone can miss it and end up with hard to explain "bug" in his program.
BTW as your implementation will act randomly I can't see how you will
handle multiple readers (maybe except some trivial cases).

Regards,

Krzysiek


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268473AbTBNXpJ>; Fri, 14 Feb 2003 18:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268488AbTBNXpJ>; Fri, 14 Feb 2003 18:45:09 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:24709 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S268473AbTBNXnD>; Fri, 14 Feb 2003 18:43:03 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 14 Feb 2003 16:00:03 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
In-Reply-To: <Pine.LNX.4.44.0302131452450.4232-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.50.0302141553020.988-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0302131452450.4232-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2003, Linus Torvalds wrote:

> > > One of the reasons for the "flags" field (which is not unused) was because
> > > I thought it might have extensions for things like alarms etc.
> >
> > I was thinking more like :
> >
> > int timerfd(int timeout, int oneshot);
>
> It could be a separate system call, ...

I would personally like it a lot to have timer events available on
pollable fds. Am I alone in this ?



> but since the infrastructure is hopefully identical (most of the sigfd()
> code is actually creating the fs infrastructure to get an inode with the
> information), it should share a lot of the paths.

About that, I think we should make an utility function to be shared among
all the code that need to create "fake" inodes to expose fds. Right now
many component ( pipes, futexes, epoll, ... ) uses the basic code, sharing
the same needs, and duplicating basically the same code.




- Davide


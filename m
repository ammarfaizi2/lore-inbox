Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265177AbSJaEsk>; Wed, 30 Oct 2002 23:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265179AbSJaEsk>; Wed, 30 Oct 2002 23:48:40 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:12160 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265177AbSJaEsi>; Wed, 30 Oct 2002 23:48:38 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 30 Oct 2002 21:04:31 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Martin Waitz <tali@admingilde.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-Reply-To: <20021030193810.GD2300@admingilde.org>
Message-ID: <Pine.LNX.4.44.0210302057120.1452-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, Martin Waitz wrote:

> On Tue, Oct 29, 2002 at 06:24:27PM -0800, Davide Libenzi wrote:
> > You have two ways to know if "something" changed. You call everyone each
> > time and you ask him if his changed, or you call everyone one time by
> > saying "call me when you're changed".
> well, you don't say 'call me when you're changed' but
> 'i'm interested in your status, please be prepared to report if you
> have changed' when calling epoll_ctl.

Yes, I just don't like to write much :)



> > It's behind the "call me when you're changed" phrase that lays the
> > concept of edge triggered APIs.
> in most situations, you are not really interested in 'has it changed?'
> but in 'what has it changed to?'.
> this is the difference between edge- or level-triggered notification.
>
> e.g. the application wants to know
> 'from which fds can i read without blocking' and not which fds
> happend to change their block-state
> (perhaps there is still data available after the last read, in
> which case the application would like to be notified about this
> situation)

The state of I/O can change only in two way. From I/O space available ( 1 )
to I/O space empty ( 0 ) and reverse. You generate 1->0 transactions and I
guess that ones are not very interesting. You're very much interested in
0->1 transaction indeed, that the kernel generates.



> is it possible that www.xmailserver.org is down atm?
> i couldn't get as much docu about epoll as i wanted to,
> so please correct me if my above view about epoll is incorrect
>
> and yes, i haven't looked at any code yet,
> i just like the kevent docu better then the epoll docu... ;)
> and yes, i would like to port kevent to linux,
> but i don't have any time to do this in the next months... :(

It has always been up for what it may concern. It's a T1 but during these
days it had quite a few hits because of epoll.



- Davide




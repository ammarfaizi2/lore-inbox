Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265518AbSJSF0R>; Sat, 19 Oct 2002 01:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265524AbSJSF0R>; Sat, 19 Oct 2002 01:26:17 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:21888 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265518AbSJSF0Q>; Sat, 19 Oct 2002 01:26:16 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 18 Oct 2002 22:40:37 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Myers <jgmyers@netscape.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <3DB0AD79.30401@netscape.com>
Message-ID: <Pine.LNX.4.44.0210182236180.11331-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002, John Myers wrote:

> >It's a very simple concept. That means that after a
> >connect()/accept() you have to start using the fd because I/O space might
> >be available for read()/write(). Dropping an event is an attempt of using
> >the API like poll() & Co., where after an fd born, it is put inside the
> >set to be later wake up. You're basically saying "the kernel should drop an
> >event at creation time" and I'm saying that, to keep the API usage
> >consistent to "use the fd until EAGAIN", you have to use the fd as soon as
> >it'll become available.
> >
> Here's where your argument is inconsistent with the Linux philosophy.
>
> Linux has a strong philosophy of practicality.  The goal of Linux is to
> do useful things, including provide applications with the semantics they
> need to do useful things.  The criteria for deciding what goes into
> Linux is heavily weighted towards what works best in practice.
>
> Whether or not some API matches someone's Platonic ideal of of an OS
> interface is not a criterion.  In Linux, APIs are judged by their
> practical merits.  This is why Linux does not have such things as
> message passing and separate address spaces for drivers.
>
> So whether or not a proposed set of epoll semantics is consistent with
> your Platonic ideal of "use the fd until EAGAIN" is simply not an issue.
>  What matters is what works best in practice.

Luckily enough, being the only one that wasted my time in those couple of
days arguing against the API semantic, you pretty much down in the list of
people that are able to decide what "works best in practice".



- Davide



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264978AbSKRXE1>; Mon, 18 Nov 2002 18:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264940AbSKRXCa>; Mon, 18 Nov 2002 18:02:30 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:21129 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264950AbSKRXCL>; Mon, 18 Nov 2002 18:02:11 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 15:09:36 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dan Kegel <dank@kegel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <3DD96803.7080407@kegel.com>
Message-ID: <Pine.LNX.4.44.0211181507510.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Dan Kegel wrote:

> Ulrich wrote:
> >> epoll does hook f_op->poll() and hence uses the asm/poll.h bits.
> >
> > It does today.  We are talking about "you promise that this will be the
> > case ever after or we'll cut your head off".  I have no idea why you're
> > so reluctant since you don't have to maintain any of the user-level
> > bits.  And it is not you who has to deal with the fallout of a change
> > when it happens.
> >
> > If epoll is so different from poll (and this is what I've been told frmo
> > Davide) then there should be a clear separation of the interfaces and
> > all those arguing to unify the data types and constants better should
> > rethink there understanding.
>
> epoll is not really that different from poll, is it?
> It delivers edge-triggered versions of the same events poll uses.
> Or is there something epoll does I'm not aware of?

The interface ( edge-triggered ) is quite different and we saw in the
previous experience how this might lead to confusion for the user. Putting
epoll bits inside poll.h will IMHO increase this.



- Davide



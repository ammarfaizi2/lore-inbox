Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263279AbSKTXLu>; Wed, 20 Nov 2002 18:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263313AbSKTXLu>; Wed, 20 Nov 2002 18:11:50 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:30084 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S263279AbSKTXLs>; Wed, 20 Nov 2002 18:11:48 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 20 Nov 2002 15:19:30 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mark Mielke <mark@mark.mielke.cc>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <20021120080153.GB26018@mark.mielke.cc>
Message-ID: <Pine.LNX.4.44.0211201518490.974-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002, Mark Mielke wrote:

> On Tue, Nov 19, 2002 at 08:04:33PM -0800, Davide Libenzi wrote:
> > On Wed, 20 Nov 2002, Jamie Lokier wrote:
> > > The `fd' field, on the other hand, is not guaranteed to correspond
> > > with the correct file descriptor number.  So.... perhaps the structure
> > > should contain an `obj' field and _no_ `fd' field?
> > > ...
> > It's OK. I agree. We can remove the fd from inside the structure and have :
> >     struct epoll_event {
> >         unsigned short events;
> >         unsigned short revents;
> >         __uint64_t obj;
> >     };
>
> Forget any argument I had against removing 'fd'. This sounds good.
>
> Perhaps 'obj' should be named 'userdata'?
>
>      struct epoll_event {
>          unsigned short   events;
>          unsigned short   revents;
>          __uint64_t       userdata;
>      };

Do we want to have a union instead of a direct 64bit int ?




- Davide



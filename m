Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbSKTXhm>; Wed, 20 Nov 2002 18:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263105AbSKTXhm>; Wed, 20 Nov 2002 18:37:42 -0500
Received: from findaloan-online.cc ([216.209.85.42]:16906 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S264628AbSKTXgu>;
	Wed, 20 Nov 2002 18:36:50 -0500
Date: Wed, 20 Nov 2002 18:51:35 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021120235135.GA32715@mark.mielke.cc>
References: <20021120080153.GB26018@mark.mielke.cc> <Pine.LNX.4.44.0211201518490.974-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211201518490.974-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 03:19:30PM -0800, Davide Libenzi wrote:
> On Wed, 20 Nov 2002, Mark Mielke wrote:
> > >     struct epoll_event {
> > >         unsigned short events;
> > >         unsigned short revents;
> > >         __uint64_t obj;
> > >     };
> > Forget any argument I had against removing 'fd'. This sounds good.
> > Perhaps 'obj' should be named 'userdata'?
> >      struct epoll_event {
> >          unsigned short   events;
> >          unsigned short   revents;
> >          __uint64_t       userdata;
> >      };
> Do we want to have a union instead of a direct 64bit int ?

I was going to suggest this, except I couldn't figure out what to
suggest that it look like... I finally figured that the value could be
cast, or wrapped in a union by userspace (although theoretically, this
might mean more words than absolutely necessary to initialize on a
32-bit CPU...)

What were you thinking? 1X64 bit or 2X32 bit?

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/


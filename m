Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267495AbSKTHrU>; Wed, 20 Nov 2002 02:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267553AbSKTHrU>; Wed, 20 Nov 2002 02:47:20 -0500
Received: from adedition.com ([216.209.85.42]:59140 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S267495AbSKTHrS>;
	Wed, 20 Nov 2002 02:47:18 -0500
Date: Wed, 20 Nov 2002 03:01:53 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021120080153.GB26018@mark.mielke.cc>
References: <20021120030919.GA9007@bjl1.asuk.net> <Pine.LNX.4.44.0211191957370.1107-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211191957370.1107-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 08:04:33PM -0800, Davide Libenzi wrote:
> On Wed, 20 Nov 2002, Jamie Lokier wrote:
> > The `fd' field, on the other hand, is not guaranteed to correspond
> > with the correct file descriptor number.  So.... perhaps the structure
> > should contain an `obj' field and _no_ `fd' field?
> > ...
> It's OK. I agree. We can remove the fd from inside the structure and have :
>     struct epoll_event {
>         unsigned short events;
>         unsigned short revents;
>         __uint64_t obj;
>     };

Forget any argument I had against removing 'fd'. This sounds good.

Perhaps 'obj' should be named 'userdata'?

     struct epoll_event {
         unsigned short   events;
         unsigned short   revents;
         __uint64_t       userdata;
     };

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265588AbSKAEVY>; Thu, 31 Oct 2002 23:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265589AbSKAEVY>; Thu, 31 Oct 2002 23:21:24 -0500
Received: from netrealtor.ca ([216.209.85.42]:61703 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265588AbSKAEVX>;
	Thu, 31 Oct 2002 23:21:23 -0500
Date: Thu, 31 Oct 2002 23:29:42 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
Message-ID: <20021101042942.GB12999@mark.mielke.cc>
References: <20021031154112.GB27801@bjl1.asuk.net> <Pine.LNX.4.44.0210311211160.1562-100000@blue1.dev.mcafeelabs.com> <20021031230215.GA29671@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031230215.GA29671@bjl1.asuk.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 11:02:15PM +0000, Jamie Lokier wrote:
> The semantics for this are a bit confusing and inconsistent with
> poll().  User gets POLL_RDNORM event which means something in the
> directory has changed, not that the directory is now readable or that
> poll() would return POLL_RDNORM.  It really should be a different
> flag, made for the purpose.

Don't be encouraging any of us to expect the ability to poll() for changes
to regular files (log file parsers that sit on EOF periodically polling for
further data...). Just get *something* decent out so that we can play with
it in a production environment. I would put off extensions such as this until
the API is well established.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/


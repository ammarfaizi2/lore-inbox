Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265616AbSKAExS>; Thu, 31 Oct 2002 23:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265617AbSKAExR>; Thu, 31 Oct 2002 23:53:17 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:9140 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265616AbSKAExR>;
	Thu, 31 Oct 2002 23:53:17 -0500
Date: Fri, 1 Nov 2002 04:59:22 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
Message-ID: <20021101045922.GA32021@bjl1.asuk.net>
References: <20021031154112.GB27801@bjl1.asuk.net> <Pine.LNX.4.44.0210311211160.1562-100000@blue1.dev.mcafeelabs.com> <20021031230215.GA29671@bjl1.asuk.net> <20021101042942.GB12999@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101042942.GB12999@mark.mielke.cc>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:
> On Thu, Oct 31, 2002 at 11:02:15PM +0000, Jamie Lokier wrote:
> > The semantics for this are a bit confusing and inconsistent with
> > poll().  User gets POLL_RDNORM event which means something in the
> > directory has changed, not that the directory is now readable or that
> > poll() would return POLL_RDNORM.  It really should be a different
> > flag, made for the purpose.
> 
> Don't be encouraging any of us to expect the ability to poll() for changes
> to regular files (log file parsers that sit on EOF periodically polling for
> further data...).

Actually you can already do something similar, if a little coarse
grained, in 2.4 kernels using dnotify on the parent directory.

> Just get *something* decent out so that we can play with it in a
> production environment. I would put off extensions such as this
> until the API is well established.

"something decent" is already out - epoll is quite useful in its
present form.  (Take that with a grain of salt - I haven't tried it,
and it only just went into 2.4.45, and I have the impression Davide is
cleaning up the code for 2.4.46 - but it looks basically ok).

-- Jamie

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261446AbSJ2Bsb>; Mon, 28 Oct 2002 20:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbSJ2Bsb>; Mon, 28 Oct 2002 20:48:31 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:57255 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S261446AbSJ2Bsb>;
	Mon, 28 Oct 2002 20:48:31 -0500
Date: Tue, 29 Oct 2002 01:53:38 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: bert hubert <ahu@ds9a.nl>, Davide Libenzi <davidel@xmailserver.org>,
       Hanna Linder <hannal@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] epoll more scalable than poll
Message-ID: <20021029015338.GC18727@bjl1.asuk.net>
References: <20021028220809.GB27798@outpost.ds9a.nl> <Pine.LNX.4.44.0210281420540.966-100000@blue1.dev.mcafeelabs.com> <20021028234434.GB18415@bjl1.asuk.net> <20021029000339.GA31212@outpost.ds9a.nl> <20021029004805.GA18727@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021029004805.GA18727@bjl1.asuk.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> bert hubert wrote:
> > > :( I was hoping sys_epoll would be scalable without increasing the
> > > number of system calls per event.
> > 
> > I see only one call per event? sys_epoll_wait. Perhaps sys_epoll_ctl to
> > register a new interest.
> 
> As David pointed out, you need a second call before the sys_epoll_wait
> if you're waiting for fds that epoll doesn't support (such as a tty).
           ^
       insert "also"

-- Jamie

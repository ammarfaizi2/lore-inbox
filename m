Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbSJ2B7h>; Mon, 28 Oct 2002 20:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261501AbSJ2B7g>; Mon, 28 Oct 2002 20:59:36 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:60327 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S261495AbSJ2B7g>;
	Mon, 28 Oct 2002 20:59:36 -0500
Date: Tue, 29 Oct 2002 02:05:45 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: bert hubert <ahu@ds9a.nl>, Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
Message-ID: <20021029020545.GD18727@bjl1.asuk.net>
References: <20021029004034.GA32118@outpost.ds9a.nl> <Pine.LNX.4.44.0210281652270.966-100000@blue1.dev.mcafeelabs.com> <20021029005332.GA32426@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021029005332.GA32426@outpost.ds9a.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:
> 	1) epoll only works on pipes and sockets
>               (not on tty, not on files)

fifos come to mind as the other things which are a bit like pipes/sockets.

>
>         2) epoll must be used on non-blocking sockets only
>               (and describe the race that happens otherwise)

That much is implied simply by epoll being a queue of not_ready->ready
edge transitions.  It would be good for the manual to explain this,
but it is clearly implied by the API if you think about it.

-- Jamie

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261208AbSJ2ArN>; Mon, 28 Oct 2002 19:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbSJ2ArN>; Mon, 28 Oct 2002 19:47:13 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:41128 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261208AbSJ2ArL>;
	Mon, 28 Oct 2002 19:47:11 -0500
Date: Tue, 29 Oct 2002 01:53:32 +0100
From: bert hubert <ahu@ds9a.nl>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
Message-ID: <20021029005332.GA32426@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Davide Libenzi <davidel@xmailserver.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	lse-tech@lists.sourceforge.net
References: <20021029004034.GA32118@outpost.ds9a.nl> <Pine.LNX.4.44.0210281652270.966-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210281652270.966-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 04:57:12PM -0800, Davide Libenzi wrote:

> > If that code dares to read immediatly from the fd without having an explicit
> > POLLIN event, which also means that epoll can only be used in this fashion
> > with nonblocking sockets.
> 
> The epoll interface has to be used with non-blocking fds. The EAGAIN

Ok, so that is two things that need to be in the manpage and probably in
bold:

	1) epoll only works on pipes and sockets
              (not on tty, not on files)

        2) epoll must be used on non-blocking sockets only
              (and describe the race that happens otherwise)

If you send me the source of your manpages I'll work it in if you want.

I still vote for checking at insert time however unless that is too
expensive. Yes, we want people to read the manpages and heed them, but we
also not want to create interfaces that are needlessly errorprone.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266735AbSLJLC5>; Tue, 10 Dec 2002 06:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266750AbSLJLC4>; Tue, 10 Dec 2002 06:02:56 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:3785 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S266735AbSLJLC4>;
	Tue, 10 Dec 2002 06:02:56 -0500
Date: Tue, 10 Dec 2002 11:08:41 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: george anzinger <george@mvista.com>, Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
Message-ID: <20021210110841.GA15418@bjl1.asuk.net>
References: <3DEEB37A.233DD280@mvista.com> <Pine.LNX.4.44.0212041830100.3100-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212041830100.3100-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> So what we do is to introduce a _new_ system call 
> (system call number NNN), which takes a different form of timeout, namely 
> "absolute value of end time".

An "absolute value of end time" variant of
select/poll/epoll/io_getevents would be good anyway from userspace, to
avoid the gettimeofday+poll race condition.

So, perhaps the solution here is to simply provide absolute time
variants of the system calls which currently take time delays, and
have the relative-time variants rewrite themselves into absolute form?

That's architecture neutral _and_ fixes a long-standing race
condition..

-- Jamie

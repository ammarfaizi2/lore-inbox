Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261587AbSJ1WXi>; Mon, 28 Oct 2002 17:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261585AbSJ1WX1>; Mon, 28 Oct 2002 17:23:27 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:23957 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261584AbSJ1WVx>; Mon, 28 Oct 2002 17:21:53 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 14:37:37 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Shailabh Nagar <nagar@watson.ibm.com>
cc: bert hubert <ahu@ds9a.nl>, Hanna Linder <hannal@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@vger.kernel.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [PATCH] epoll more scalable than poll
In-Reply-To: <3DBDB664.7050808@watson.ibm.com>
Message-ID: <Pine.LNX.4.44.0210281435350.966-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Shailabh Nagar wrote:

> > Furthermore, there is some const weirdness going on, the ephttpd server has
> > a different second argument to sys_epoll_wait.
>
> You're right. The ephttpd server on Davide's page needs to add a cast
> (struct pollfd const **) to the second arg passed to sys_epoll_wait.
> The version of dphttpd used to generate the results had that fix in it.

It's true, I gave IBM the ephttpd that was using the first draft of the
interface that had a 'struct pollfd **' parameter. Later I changed the
implementation to 'struct pollfd const **' because I also changed the way
the mmap prot are used ( now mmap()ed PROT_READ only ).



- Davide



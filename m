Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261382AbSJ1XwU>; Mon, 28 Oct 2002 18:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbSJ1XwU>; Mon, 28 Oct 2002 18:52:20 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:11418 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261382AbSJ1XwS>; Mon, 28 Oct 2002 18:52:18 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 16:08:04 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Gardiner Myers <jgmyers@netscape.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-Reply-To: <3DBDCC02.6060100@netscape.com>
Message-ID: <Pine.LNX.4.44.0210281606390.966-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, John Gardiner Myers wrote:

> bert hubert wrote:
>
> >The interface is also lovely:
> >
> >
> The code you wrote has the standard epoll race condition.  If the file
> descriptor 's' becomes readable before the call to sys_epoll_ctl,
> sys_epoll_wait() will never return the socket.  The connection will hang
> and the file descriptor will effectively leak.
>
> As you have amply demonstrated, the current epoll API is error prone.
>  The API should be fixed to test the poll condition and, if necessary,
> drop an event upon insertion to the set.

So, please don't use :

	free((void *) rand());

free() is flawed !! Be warned !!



- Davide



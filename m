Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSKBUBn>; Sat, 2 Nov 2002 15:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261369AbSKBUBn>; Sat, 2 Nov 2002 15:01:43 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:388 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261356AbSKBUBT>; Sat, 2 Nov 2002 15:01:19 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 2 Nov 2002 12:17:31 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] total-epoll r2 ...
In-Reply-To: <Pine.LNX.4.44.0211021126110.951-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.44.0211021215100.951-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002, Davide Libenzi wrote:

>
> The new epoll approach to event delivery seems stable on my machine an
> result about performance look pretty good. The changes that the new design
> introduce are :
>
> *) Full support for all devices that support ->f_op->poll()
>
> *) Multi-threaded support ( if you really like them )
>
> *) The function epoll_ctl(EP_CTL_ADD) drops an event if conditions are met
>
> *) Less intrusive design by hooking directly the poll support
>
> *) The patch is smaller, and this is a good news
>
> *) Looks even faster to me
>
> *) The function epoll_create(int size) has been changed. Not the "size"
> 	parameter is just an hint to the kernel about how to dimension its
> 	own internal data structures. In theory you can call
> 	epoll_create(200) and stock 10000 fds inside epoll


*) The old /dev/epoll access has been dropped with this release.



- Davide



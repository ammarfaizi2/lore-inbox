Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSKXTEQ>; Sun, 24 Nov 2002 14:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261587AbSKXTEQ>; Sun, 24 Nov 2002 14:04:16 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:10632 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261582AbSKXTEQ>; Sun, 24 Nov 2002 14:04:16 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 24 Nov 2002 11:12:16 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Felix von Leitner <felix-kerel@fefe.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll_wait conflicts with man page
In-Reply-To: <Pine.LNX.4.50.0211240956500.7401-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.50.0211241106450.7401-100000@blue1.dev.mcafeelabs.com>
References: <20021124174635.GB16255@codeblau.de>
 <Pine.LNX.4.50.0211240956500.7401-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Nov 2002, Davide Libenzi wrote:

> On Sun, 24 Nov 2002, Felix von Leitner wrote:
>
> > I just implemented epoll_create, epoll_ctl and epoll_wait for the diet
> > libc and found that epoll_wait in 2.5.59 does not expect struct
> > epoll_event* as second argument but actually struct pollfd*.
>
> Man pages are currently under review/editing and the definitive ones
> should be ready for the next week.

Since I received many emails about the kernel not exposing the final
interface that is currently documented, and since Linus did not merge my
latest bits, I prepared a patch that will align the kernel to the latest
API :

http://www.xmailserver.org/linux-patches/sys_epoll-2.5.49-0.58.diff

The latest API is documented here :

http://www.xmailserver.org/linux-patches/epoll.txt
http://www.xmailserver.org/linux-patches/epoll.4
http://www.xmailserver.org/linux-patches/epoll_create.txt
http://www.xmailserver.org/linux-patches/epoll_create.2
http://www.xmailserver.org/linux-patches/epoll_ctl.txt
http://www.xmailserver.org/linux-patches/epoll_ctl.2
http://www.xmailserver.org/linux-patches/epoll_wait.txt
http://www.xmailserver.org/linux-patches/epoll_wait.2

A few bits inside the man pages might change ( epoll.4 maybe heavily ) but
the API should be pretty much fixed right now. An access library is
available here :

http://www.xmailserver.org/linux-patches/epoll-lib-0.3.tar.gz




- Davide


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265982AbUAEW2q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265976AbUAEW12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:27:28 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:45511 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265958AbUAEWYu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:24:50 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 5 Jan 2004 14:24:17 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Ingo Oeser <ioe-lkml@rameria.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
In-Reply-To: <200401052205.12344.ioe-lkml@rameria.de>
Message-ID: <Pine.LNX.4.44.0401051423120.4154-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jan 2004, Ingo Oeser wrote:

> On Sunday 04 January 2004 20:20, you wrote:
> > The problem with poll/select is not the Linux implementation. It is the
> > API that is flawed when applied to large fd sets. Every call pass to the
> > system the whole fd set, and this makes the API O(N) by definition. While
> > poll/select are perfectly ok for small fd sets, epoll LT might enable the
> > application to migrate from poll/select to epoll pretty quickly (if the
> > application architecture is fairly sane). For example, it took about 15
> > minutes to me to make an epoll'd thttpd.
> 
> Yes, I've read your analysis several years ago already and I'm the first
> one lobbying for epoll, but look at the posting stating, that INN sucks
> under Linux currently, but doesn't suck that hard under FreeBSD and
> Solaris.
> 
> There are already enough things you cannot do properly under Linux
> (which are mostly not Linux' fault, but still), so I don't want to add
> another one. Especially in the server market, where the M$ lobbyists are
> growing their market share.
> 
> 
> But if there is some minimal funding available (50 EUR?), I would do it
> myself and push the patches upstream ;-)

IIRC INN was not using multiplexing multiple client with a single task. 
Wasn't it a fork-and-handle kinda server?



- Davide



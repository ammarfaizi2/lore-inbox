Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTETQmX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 12:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbTETQmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 12:42:23 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:24459 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262577AbTETQmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 12:42:23 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 20 May 2003 09:54:27 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] futex API cleanups, futex-api-cleanup-2.5.69-A2
In-Reply-To: <20030520014403.GA14851@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0305200947460.3636@bigblue.dev.mcafeelabs.com>
References: <20030520010913.3300F2C05E@lists.samba.org>
 <Pine.LNX.4.55.0305191813240.6565@bigblue.dev.mcafeelabs.com>
 <20030520014403.GA14851@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 May 2003, Jamie Lokier wrote:

> Yes, they do and it should work (I haven't tried, though).
>
> There is a practical problem when waiting on a futex in multiple
> threads using epoll: you need a separate fd per waiter, rather than an
> fd per waited-on futex.  This is because some uses of futexes depend
> on waiters being woken in the exact order that they were queued.

Not really Jamie. See a Futex event is not much different from a network
one. When the event shows up, one thread will pick it up (epoll_wait) and
will handle it. A futex event will very likely be a green light for some
sort of resource usage that whatever thread can pick up and handle.



- Davide


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbTETBDu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 21:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbTETBDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 21:03:49 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:56999 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263429AbTETBDp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 21:03:45 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 19 May 2003 18:14:38 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Jamie Lokier <jamie@shareable.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] futex API cleanups, futex-api-cleanup-2.5.69-A2 
In-Reply-To: <20030520010913.3300F2C05E@lists.samba.org>
Message-ID: <Pine.LNX.4.55.0305191813240.6565@bigblue.dev.mcafeelabs.com>
References: <20030520010913.3300F2C05E@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 May 2003, Rusty Russell wrote:

> In message <20030519233353.GD13706@mail.jlokier.co.uk> you write:
> > Ingo Molnar wrote:
> > > FUTEX_FD is an instant DoS, it allows the pinning of one page per file
> > > descriptor, per thread. With a default limit of 1024 open files per
> > > thread, and 256 threads (on a sane/conservative setup), this means 1 GB of
> > > RAM can be pinned down by a normal unprivileged user.
> >
> > The correct solution [;)] is EP_FUTEX - allow a futex to be specified
> > as the source of an epoll event.

Futexes do support f_op->poll(), isn't it Rusty ? If so, they're supported
by epoll ...



- Davide


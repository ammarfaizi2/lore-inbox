Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030410AbWJDG2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbWJDG2H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 02:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbWJDG2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 02:28:06 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:55515 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1030410AbWJDG2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 02:28:03 -0400
Date: Wed, 4 Oct 2006 10:27:33 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take19 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061004062733.GB10965@2ka.mipt.ru>
References: <115a6230591036@2ka.mipt.ru> <11587449471424@2ka.mipt.ru> <20060922122207.3b716028.akpm@osdl.org> <20060923042350.GA24099@2ka.mipt.ru> <a36005b50610032309u2a8b5797x43e5cce2fbd1d18e@mail.gmail.com> <a36005b50610032310o13b9340cp8dc3fd2240e77c58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <a36005b50610032310o13b9340cp8dc3fd2240e77c58@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 04 Oct 2006 10:27:33 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 11:10:51PM -0700, Ulrich Drepper (drepper@gmail.com) wrote:
> [Bah, sent too eaqrly]
> 
> On 9/22/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >The only two things missed in patchset after his suggestions are
> >new POSIX-like interface, which I personally consider as very unconvenient,
> 
> This means you really do not know at all what this is about.  We
> already have these interfaces.  Several of them and there will likely
> be more.  These are interfaces for functionality which needs the new
> event notification.  There is *NO* reason whatsoever to not make add
> this extension and instead invent new interfaces to have notification
> sent to the event queue.

As I described in previous e-mail, there are completely _no_ limitations
on iterfaces - it is possible to queue events from any place, not matter
if it is new interface (which I prefer to use) or any old one, which is
more convenient for someone. There is special herlper function for that.
One can check network AIO implementation to see how it was done in
practice - network AIO has own syscalls (aio_send(), aio_recv() and
aio_sendfile(), which create kevent queue and put there own events,
it is completely transparent for userspace which does not even know that
network AIO is based on kevent).

-- 
	Evgeniy Polyakov

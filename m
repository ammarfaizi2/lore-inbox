Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935796AbWK1KOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935796AbWK1KOu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 05:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935801AbWK1KOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 05:14:50 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:30376 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S935796AbWK1KOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 05:14:45 -0500
Date: Tue, 28 Nov 2006 13:13:27 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061128101327.GE15083@2ka.mipt.ru>
References: <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <4563FD53.7030307@redhat.com> <20061122120933.GA32681@2ka.mipt.ru> <20061122121516.GA7229@2ka.mipt.ru> <4564CE00.9030904@redhat.com> <20061123122225.GD20294@2ka.mipt.ru> <456605EA.5060601@redhat.com> <20061124105856.GE13600@2ka.mipt.ru> <456B2D2B.9080502@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <456B2D2B.9080502@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 28 Nov 2006 13:13:28 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 10:23:39AM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >
> >With provided patch it is possible to wakeup 'for-free' - just call
> >kevent_ctl(ready) with zero number of ready events, so thread will be
> >awakened if it was in poll(kevent_fd), kevent_wait() or
> >kevent_get_events().
> 
> Yes, I realize that.  But I wrote something else:
> 
> >> Rather than mark an existing entry as ready, how about a call to
> >> inject a new ready event?
> >>
> >> This would be useful to implement functionality at userlevel and
> >> still use an event queue to announce the availability.  Without this
> >> type of functionality we'd need to use indirect notification via
> >> signal or pipe or something like that.
> 
> This is still something which is wanted.

Why do we want to inject _ready_ event, when it is possible to mark
event as ready and wakeup thread parked in syscall?

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov

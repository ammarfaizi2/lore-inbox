Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266166AbSKFW0S>; Wed, 6 Nov 2002 17:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266168AbSKFW0S>; Wed, 6 Nov 2002 17:26:18 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:33167 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S266166AbSKFW0R>; Wed, 6 Nov 2002 17:26:17 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 6 Nov 2002 14:42:47 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jay Vosburgh <fubar@us.ibm.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.46: epoll_wait can return too many events 
In-Reply-To: <OF1DE2DE38.9228F1D8-ON88256C69.0076552C@boulder.ibm.com>
Message-ID: <Pine.LNX.4.44.0211061442060.953-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2002, Jay Vosburgh wrote:

>
>       The logic in fs/eventpoll.c:ep_events_transfer() to bundle events can
> return more than the requested number of events (because the event count is
> only incremented for each bundle); this will scribble on memory beyond the
> end of the user's buffer.  The fix is to test against the bundle size
> (ebufcnt) plus the event count (eventcnt).
>
>       Also, passing maxevents <= 0 to epoll_wait() causes the system to
> lock up; the fix is to return EINVAL if maxevents is <= 0.

Thanks Jay. Got it.
Linus please drop 0.32, I'll make 0.33 right now ...



- Davide



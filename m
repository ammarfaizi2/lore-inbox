Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266633AbSKGXIB>; Thu, 7 Nov 2002 18:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266636AbSKGXIB>; Thu, 7 Nov 2002 18:08:01 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:58505 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S266633AbSKGXIA>; Thu, 7 Nov 2002 18:08:00 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 7 Nov 2002 15:24:36 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jay Vosburgh <fubar@us.ibm.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Janet Morgan <janetinc@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.46: epoll ep_insert doesn't wake waiters if events
 exist 
In-Reply-To: <OF0E49851E.BBF9BCB0-ON88256C6A.007C9078@boulder.ibm.com>
Message-ID: <Pine.LNX.4.44.0211071521070.1751-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2002, Jay Vosburgh wrote:

>
>       The logic in fs/eventpoll.c:ep_insert()  checks to see if events are
> already present when processing an EP_CTL_ADD operation, and, if any are,
> adds them to the list.  It does not wake up any waiters, so, e.g., another
> thread waiting in epoll_wait() will not be awakened for these events.  The
> fix is to have ep_insert() do wakeups, just as ep_poll_callback() does when
> it adds events.

Matthew Kirk already made me notice this yesterday and it's in my code ( 0.37 ).
I was ashame to make another post to Linus :) so I delayed the post.
Linus, I have a few bits. Let me know if you want them now or we will
delay to 2.5.47 ...



- Davide



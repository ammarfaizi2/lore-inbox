Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265629AbSJSRFb>; Sat, 19 Oct 2002 13:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265630AbSJSRFb>; Sat, 19 Oct 2002 13:05:31 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:57475 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265629AbSJSRFb>; Sat, 19 Oct 2002 13:05:31 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 19 Oct 2002 10:19:56 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mark Mielke <mark@mark.mielke.cc>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <20021019065624.GA17553@mark.mielke.cc>
Message-ID: <Pine.LNX.4.44.0210191011330.1434-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Oct 2002, Mark Mielke wrote:

> On Fri, Oct 18, 2002 at 12:16:48PM -0700, Davide Libenzi wrote:
> > These functions are taken from the really simple example http server used
> > to test/compare /dev/epoll with poll()/select()/rt-sig//dev/poll :
>
> They still represent an excessive complicated model that attempts to
> implement /dev/epoll the same way that one would implement poll()/select().
>
> Sometimes the answer isn't emulation, or comparability.
>
> Sometimes the answer is innovation.

Hem ... they're about 100 lines of code and they rapresent a complete I/O
dispatching engine. And yes, like you could guess from the source code,
the same skeleton was used, with different event retrieval methods, to
test poll() , rt-sig , /dev/poll and /dev/epoll. And, as I said in the
previous email, you could have implemented an I/O driven state machine. I
personally like a little bit more coroutines, that the reason of such
implementation.



- Davide



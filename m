Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286309AbRLTSC5>; Thu, 20 Dec 2001 13:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286310AbRLTSCr>; Thu, 20 Dec 2001 13:02:47 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:40466 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286309AbRLTSCb>; Thu, 20 Dec 2001 13:02:31 -0500
Date: Thu, 20 Dec 2001 10:05:25 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dan Kegel <dank@kegel.com>
cc: mingo@elte.hu, "David S. Miller" <davem@redhat.com>,
        bcrl <bcrl@redhat.com>, billh <billh@tierra.ucsd.edu>,
        torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>
Subject: Re: aio
In-Reply-To: <3C22129C.4A4E2269@kegel.com>
Message-ID: <Pine.LNX.4.40.0112201004580.1622-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2001, Dan Kegel wrote:

> Ingo Molnar wrote:
>
> > it's not a fair comparison. The system was set up to not exhibit any async
> > IO load. So a pure, atomic sendfile() outperformed TUX slightly, where TUX
> > did something slightly more complex (and more RFC-conform as well - see
> > Date: caching in X12 for example). Not something i'd call a proof - this
> > simply works around the async IO interface. (which RT-signal driven,
> > fasync-helped async IO interface, as phttpd has proven, is not only hard
> > to program and is unrobust, it also performs *very badly*.)
>
> Proper wrapper code can make them (almost) easy to program with.
> See http://www.kegel.com/dkftpbench/doc/Poller_sigio.html for an example
> of a wrapper that automatically handles the fallback to poll() on overflow.
> Using this wrapper I wrote ftp clients and servers which use a thin wrapper
> api that lets the user choose from select, poll, /dev/poll, kqueue/kevent, and RT signals
> at runtime.

Hey, you forgot /dev/epoll, the fastest one :)




- Davide



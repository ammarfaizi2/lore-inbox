Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbTA1WA2>; Tue, 28 Jan 2003 17:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbTA1WA2>; Tue, 28 Jan 2003 17:00:28 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:57746 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261486AbTA1WA1>; Tue, 28 Jan 2003 17:00:27 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 28 Jan 2003 14:15:33 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Mark Mielke <mark@mark.mielke.cc>,
       Lennert Buytenhek <buytenh@math.leidenuniv.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bug in select() (was Re: {sys_,/dev/}epoll waiting timeout)
In-Reply-To: <20030128094500.GA26202@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.50.0301281411260.2085-100000@blue1.dev.mcafeelabs.com>
References: <20030122065502.GA23790@math.leidenuniv.nl> <20030122080322.GB3466@bjl1.asuk.net>
 <Pine.LNX.4.50.0301230544320.820-100000@blue1.dev.mcafeelabs.com>
 <20030123154304.GA7665@bjl1.asuk.net> <20030123172734.GA2490@mark.mielke.cc>
 <20030123182831.GA8184@bjl1.asuk.net> <20030123204056.GC2490@mark.mielke.cc>
 <20030123221858.GA8581@bjl1.asuk.net> <20030127162717.A1283@ti19>
 <Pine.LNX.4.50.0301271427320.1930-100000@blue1.dev.mcafeelabs.com>
 <20030128094500.GA26202@bjl1.asuk.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2003, Jamie Lokier wrote:

> Davide Libenzi wrote:
> > ( if Tms > 0 )
>
> Which is unfortunate, because that doesn't allow for a value of Tms ==
> 0 which is needed when you want to sleep and wake up on every jiffie
> on systems where HZ >= 1000.  Tms == 0 is taken already, to mean do
> not wait at all.

Waking up every jiffie does not make a lot of sense in most applications
since they probably prefer to deal with seconds and its derivates, to have
a predictable behavior on different systems. Functions like
poll/select/epoll are simply not the right solution if you want to cut the
microsecond on sleep times.



- Davide


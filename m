Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbTA1Jf7>; Tue, 28 Jan 2003 04:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264962AbTA1Jf7>; Tue, 28 Jan 2003 04:35:59 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:18913 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S264915AbTA1Jf6>;
	Tue, 28 Jan 2003 04:35:58 -0500
Date: Tue, 28 Jan 2003 09:45:00 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Mark Mielke <mark@mark.mielke.cc>,
       Lennert Buytenhek <buytenh@math.leidenuniv.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bug in select() (was Re: {sys_,/dev/}epoll waiting timeout)
Message-ID: <20030128094500.GA26202@bjl1.asuk.net>
References: <20030122065502.GA23790@math.leidenuniv.nl> <20030122080322.GB3466@bjl1.asuk.net> <Pine.LNX.4.50.0301230544320.820-100000@blue1.dev.mcafeelabs.com> <20030123154304.GA7665@bjl1.asuk.net> <20030123172734.GA2490@mark.mielke.cc> <20030123182831.GA8184@bjl1.asuk.net> <20030123204056.GC2490@mark.mielke.cc> <20030123221858.GA8581@bjl1.asuk.net> <20030127162717.A1283@ti19> <Pine.LNX.4.50.0301271427320.1930-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0301271427320.1930-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> ( if Tms > 0 )

Which is unfortunate, because that doesn't allow for a value of Tms ==
0 which is needed when you want to sleep and wake up on every jiffie
on systems where HZ >= 1000.  Tms == 0 is taken already, to mean do
not wait at all.

-- Jamie

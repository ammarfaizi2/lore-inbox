Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265092AbTA1Keg>; Tue, 28 Jan 2003 05:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbTA1Keg>; Tue, 28 Jan 2003 05:34:36 -0500
Received: from mark.mielke.cc ([216.209.85.42]:11012 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265092AbTA1Kee>;
	Tue, 28 Jan 2003 05:34:34 -0500
Date: Tue, 28 Jan 2003 05:52:01 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Jamie Lokier <jamie@shareable.org>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Lennert Buytenhek <buytenh@math.leidenuniv.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bug in select() (was Re: {sys_,/dev/}epoll waiting timeout)
Message-ID: <20030128105201.GA1243@mark.mielke.cc>
References: <20030122080322.GB3466@bjl1.asuk.net> <Pine.LNX.4.50.0301230544320.820-100000@blue1.dev.mcafeelabs.com> <20030123154304.GA7665@bjl1.asuk.net> <20030123172734.GA2490@mark.mielke.cc> <20030123182831.GA8184@bjl1.asuk.net> <20030123204056.GC2490@mark.mielke.cc> <20030123221858.GA8581@bjl1.asuk.net> <20030127162717.A1283@ti19> <Pine.LNX.4.50.0301271427320.1930-100000@blue1.dev.mcafeelabs.com> <20030128094500.GA26202@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030128094500.GA26202@bjl1.asuk.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 09:45:00AM +0000, Jamie Lokier wrote:
> Davide Libenzi wrote:
> > ( if Tms > 0 )
> Which is unfortunate, because that doesn't allow for a value of Tms ==
> 0 which is needed when you want to sleep and wake up on every jiffie
> on systems where HZ >= 1000.  Tms == 0 is taken already, to mean do
> not wait at all.

To some degree, isn't this the equivalent of yield()?

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/


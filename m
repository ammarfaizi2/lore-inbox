Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313685AbSDPOHd>; Tue, 16 Apr 2002 10:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313686AbSDPOHc>; Tue, 16 Apr 2002 10:07:32 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:38920 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313685AbSDPOHc>; Tue, 16 Apr 2002 10:07:32 -0400
Date: Tue, 16 Apr 2002 10:04:38 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Olaf Fraczyk <olaf@navi.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <20020416074748.GA16657@venus.local.navi.pl>
Message-ID: <Pine.LNX.3.96.1020416100047.26684B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, Olaf Fraczyk wrote:

> Hi,
> I would like to know why exactly this value was choosen.
> Is it safe to change it to eg. 1024? Will it break anything?
> What else should I change to get it working:
> CLOCKS_PER_SEC?
> Please CC me.

I think you just want to change HZ, and can do that safely. Do note that
some software may be using 100 instead of HZ, so you might get some
problems there.

Think of HZ as "how often do we want to thrash the cache of CPU-bound
processes." More is not necessarily better.

If you want low latency there are low latency and preempt patches. They
will do more the make the system responsive than increasing HZ.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265982AbTAYAxi>; Fri, 24 Jan 2003 19:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265998AbTAYAxi>; Fri, 24 Jan 2003 19:53:38 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:21906 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265982AbTAYAxh>; Fri, 24 Jan 2003 19:53:37 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 24 Jan 2003 17:08:28 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Mark Mielke <mark@mark.mielke.cc>,
       Lennert Buytenhek <buytenh@math.leidenuniv.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: {sys_,/dev/}epoll waiting timeout
In-Reply-To: <20030123221858.GA8581@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.50.0301241706350.2858-100000@blue1.dev.mcafeelabs.com>
References: <20030122065502.GA23790@math.leidenuniv.nl> <20030122080322.GB3466@bjl1.asuk.net>
 <Pine.LNX.4.50.0301230544320.820-100000@blue1.dev.mcafeelabs.com>
 <20030123154304.GA7665@bjl1.asuk.net> <20030123172734.GA2490@mark.mielke.cc>
 <20030123182831.GA8184@bjl1.asuk.net> <20030123204056.GC2490@mark.mielke.cc>
 <20030123221858.GA8581@bjl1.asuk.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2003, Jamie Lokier wrote:

> (Davide), IMHO epoll should decide whether it means "at minimum" (in
> which case the +1 is a requirement), or it means "at maximum" (in
> which case rounding up is wrong).
>
> The current method of rounding up and then effectively down means that
> you get an unpredictable mixture of both.

I think I'll go with :

Tj = (Tms * HZ + 999) / 1000

Somehow I feel it more correct :)



- Davide


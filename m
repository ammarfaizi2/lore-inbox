Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318487AbSGaUNM>; Wed, 31 Jul 2002 16:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318488AbSGaUNM>; Wed, 31 Jul 2002 16:13:12 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:11278 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318487AbSGaUNM>; Wed, 31 Jul 2002 16:13:12 -0400
Date: Wed, 31 Jul 2002 16:10:48 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Ray Lee <ray-lk@madrabbit.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, cort@fsmlabs.com,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Guarantee APM power status change notifications
In-Reply-To: <1028140392.1771.66.camel@orca>
Message-ID: <Pine.LNX.3.96.1020731160429.10522B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jul 2002, Ray Lee wrote:

> There are three cases. First, the BIOS doesn't send any notifications;
> this is fixed. Second, the BIOS sends notifications. In this case, the
> code notes that, and disables the workaround. Third, the BIOS sends
> notifications, but somehow we managed to notice the power change before
> the BIOS could tell us. This seems highly unlikely, but what the heck,
> it could theoretically happen. In that case, we disable the workaround,
> and drop the notification that the BIOS generated, as we already sent it
> onward up the call chain.

Actually there is one more case, where the BIOS unreliably tells you
something has changed. I have an old Toshiba which I bought with Windows
installed, and it always noticed pulling the plug and going line=>battery,
but only sometimes noticed battery=>line. Of course this might be an o/s
bug. Can't test that any more, the battery failed and the transition is
now line=>dead.

Anyway, if you are paranoid you could just ignore the "I knew that" cases
and leave the workaround in place, unless that would generate other
issues.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


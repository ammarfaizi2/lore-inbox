Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbTHYWjP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 18:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbTHYWjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 18:39:15 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:785 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262371AbTHYWjO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 18:39:14 -0400
Date: Mon, 25 Aug 2003 18:30:23 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy
In-Reply-To: <1061735355.1034.2.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.3.96.1030825182819.12992C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Aug 2003, Felipe Alfaro Solana wrote:

> On Sun, 2003-08-24 at 14:35, Nick Piggin wrote:
> > Hi,
> > Patch against 2.6.0-test4. It fixes a lot of problems here vs
> > previous versions. There aren't really any open issues for me, so
> > testers would be welcome.
> > 
> > The big change is more dynamic timeslices, which allows "interactive"
> > tasks to get very small timeslices while more compute intensive loads
> > can be given bigger timeslices than usual. This works properly with
> > nice (niced processes will tend to get bigger timeslices).
> > 
> > I think I have cured test-starve too.
> 
> I haven't still found any starvation cases, but forking time when the
> system is under heavy load has increased considerable with respect to
> vanilla or Con's O18.1int:

Not having starvation cases may be worth a little overhead. I am more
concerned about avoiding "jackpot cases" than throughput, at least on a
desktop.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


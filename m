Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTE1Wde (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTE1Wde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:33:34 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:61444 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261294AbTE1Wdc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:33:32 -0400
Date: Wed, 28 May 2003 18:40:50 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ricky Beam <jfbeam@bluetronic.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.70
In-Reply-To: <Pine.LNX.4.44.0305280909550.8790-100000@home.transmeta.com>
Message-ID: <Pine.LNX.3.96.1030528181428.21414C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003, Linus Torvalds wrote:

> 
> On Wed, 28 May 2003, Bill Davidsen wrote:
> > 
> > Just the other day you posted strong opposition to breaking existing
> > binaries, how does that map with breaking existing hardware?
> 
> One fundamental difference is that I cannot fix it without people who
> _have_ the hardware caring. So if they don't care, I don't care. It's that
> easy. If you want to have your hardware supported, you need to help
> support it.

That's the case now, isn't it? unless the person with the non-working
hardware is willing and able to become the maintainer a lot of drivers
don't seem to get fixed. Unfortunately that the people with the old
hardware usually aren't developers.
> 
> Another difference is that it's better to not work at all, than to work
> incorrectly. So if your kernel doesn't boot or can't use your random piece
> of hardware, you just use an old kernel. But if everything looks normal,
> but some binary breaks in strange ways, that's _bad_.

Totally agree.
> 
> The latter reason is, btw, why we don't paper over the build failures like 
> some people suggested. If it hasn't been updated to the new interfaces, it 
> should preferably not even build: which is a big reason why we try to 
> rename interfaces when they change, exactly so that you don't get a subtly 
> broken build.

I don't think anyone suggested that, but there are a fair number of
drivers which could be fixed in minutes by someone who understands the new
interface. Replacing cli is easy, knowing what you replace it with is
something else again. There are new locks, per-cpu stuff added, lockless
methods... to do this right you have to do it often, and few users can do
more than give an error report which allows the problem to be reproduced.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


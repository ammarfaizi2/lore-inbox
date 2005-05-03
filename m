Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVECBcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVECBcu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 21:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVECBcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 21:32:10 -0400
Received: from 70-57-132-14.albq.qwest.net ([70.57.132.14]:28302 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261287AbVECBbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 21:31:47 -0400
Date: Mon, 2 May 2005 19:33:42 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Juergen Kreileder <jk@blackdown.de>, Andrew Morton <akpm@osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com
Subject: Re: [PATCH] fix __mod_timer vs __run_timers deadlock.
In-Reply-To: <1115083453.27658.6.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0505021933110.12903@montezuma.fsmlabs.com>
References: <42748B75.D6CBF829@tv-sign.ru>  <20050501023149.6908c573.akpm@osdl.org>
  <87vf61kztb.fsf@blackdown.de>  <1115079230.6155.35.camel@gaston>
 <1115083453.27658.6.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2005, Lee Revell wrote:

> On Tue, 2005-05-03 at 10:13 +1000, Benjamin Herrenschmidt wrote:
> > Well, there may be other issues brought by this new timer code though.
> > I'm running G5s regulary without a lockup or anything for weeks, so it
> > would be interesting if you could try to find out what's involved in
> > that other lockup you had.
> 
> It seems like it would not be to hard to create a timer test suite that
> just hammers the timer subsystem, creating and deleting and modifying
> zillions of timers, changing the system time, etc.  Combined with
> running with HZ=10000 or something it seems like you could shake out
> bugs a lot faster than just running & waiting for a race to show up.
> 
> I've seen timer related issues (the set_rtc_mmss issue that George
> Anzinger fixed) while testing the RT patchset that I could only ever
> reproduce once.

Heavy networking load should do it, something like volanomark actually 
does quite a decent job of stressing timers.

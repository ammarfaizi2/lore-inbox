Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVECBYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVECBYU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 21:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVECBYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 21:24:19 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:5085 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261278AbVECBYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 21:24:15 -0400
Subject: Re: [PATCH] fix __mod_timer vs __run_timers deadlock.
From: Lee Revell <rlrevell@joe-job.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Juergen Kreileder <jk@blackdown.de>, Andrew Morton <akpm@osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com
In-Reply-To: <1115079230.6155.35.camel@gaston>
References: <42748B75.D6CBF829@tv-sign.ru>
	 <20050501023149.6908c573.akpm@osdl.org>  <87vf61kztb.fsf@blackdown.de>
	 <1115079230.6155.35.camel@gaston>
Content-Type: text/plain
Date: Mon, 02 May 2005 21:24:13 -0400
Message-Id: <1115083453.27658.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-03 at 10:13 +1000, Benjamin Herrenschmidt wrote:
> Well, there may be other issues brought by this new timer code though.
> I'm running G5s regulary without a lockup or anything for weeks, so it
> would be interesting if you could try to find out what's involved in
> that other lockup you had.

It seems like it would not be to hard to create a timer test suite that
just hammers the timer subsystem, creating and deleting and modifying
zillions of timers, changing the system time, etc.  Combined with
running with HZ=10000 or something it seems like you could shake out
bugs a lot faster than just running & waiting for a race to show up.

I've seen timer related issues (the set_rtc_mmss issue that George
Anzinger fixed) while testing the RT patchset that I could only ever
reproduce once.

Lee



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTDPWwO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 18:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTDPWwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 18:52:14 -0400
Received: from [12.47.58.203] ([12.47.58.203]:29011 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261840AbTDPWwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 18:52:11 -0400
Date: Wed, 16 Apr 2003 16:02:57 -0700
From: Andrew Morton <akpm@digeo.com>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, george@mvista.com,
       James.Bottomley@SteelEye.com, shemminger@osdl.org, alex@ssi.bg
Subject: Re: [PATCH] linux-2.5.67_lost-tick-fix_A2
Message-Id: <20030416160257.1c7143c4.akpm@digeo.com>
In-Reply-To: <1050533210.1081.164.camel@w-jstultz2.beaverton.ibm.com>
References: <1050530545.1077.120.camel@w-jstultz2.beaverton.ibm.com>
	<20030416153259.6f99bb4e.akpm@digeo.com>
	<1050533210.1081.164.camel@w-jstultz2.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Apr 2003 23:03:58.0602 (UTC) FILETIME=[76681EA0:01C3046C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> wrote:
>
> On Wed, 2003-04-16 at 15:32, Andrew Morton wrote:
> > john stultz <johnstul@us.ibm.com> wrote:
> > >
> > > 	This patch fixes a race in the timer_interrupt code caused by
> > > detect_lost_tick().
> > 
> > Does this also fix the problem which Alex identified?
> 
> Nope. It just handles the detect_lost_tick() race and related problems
> w/ the PIT causing seq_lock reader starvation. 
> 
> I'm still looking over the preempt locking issue he pointed out.
> 
> I'll likely send a more cautious version of the patch he already posted
> to you. 

OK, thanks.

I'm rather buried in timer patches at present.  It would be best if you could
test new work in the context of those patches.

They are at http://www.zip.com.au/~akpm/linux/patches/timers/

The applying order is

	posix_timers-CLOCK_MONOTONIC-fix.patch
	jiffies_to_timespec-fix.patch
	do_timer_overflow-locking-fix.patch
	lost-tick-fix.patch


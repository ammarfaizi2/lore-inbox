Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWGKTRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWGKTRI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWGKTRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:17:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15052 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932098AbWGKTRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:17:06 -0400
Date: Tue, 11 Jul 2006 15:16:58 -0400
From: Dave Jones <davej@redhat.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 18rc1 soft lockup
Message-ID: <20060711191658.GM5362@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	john stultz <johnstul@us.ibm.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060711190346.GK5362@redhat.com> <1152645227.760.9.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152645227.760.9.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 12:13:47PM -0700, john stultz wrote:
 > On Tue, 2006-07-11 at 15:03 -0400, Dave Jones wrote:
 > > Just saw this during boot of a HT P4 box.
 > > 
 > > BUG: soft lockup detected on CPU#0!
 > >  [<c04051af>] show_trace_log_lvl+0x54/0xfd
 > >  [<c0405766>] show_trace+0xd/0x10
 > >  [<c0405885>] dump_stack+0x19/0x1b
 > >  [<c0450ec7>] softlockup_tick+0xa5/0xb9
 > >  [<c042d496>] run_local_timers+0x12/0x14
 > >  [<c042d81b>] update_process_times+0x3c/0x61
 > >  [<c04179e0>] smp_apic_timer_interrupt+0x6d/0x75
 > >  [<c0404ada>] apic_timer_interrupt+0x2a/0x30
 > 
 > That's clocksource_adjust/lost tick bug. Roman's fix landed in Linus'
 > -git yesterday.

Ah, that was actually a .18rc1-git3 tree. I notice a git4 just appeared,
I'll try and reproduce with that.

		Dave

-- 
http://www.codemonkey.org.uk

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWGKTNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWGKTNv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWGKTNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:13:51 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:37565 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932105AbWGKTNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:13:50 -0400
Subject: Re: 18rc1 soft lockup
From: john stultz <johnstul@us.ibm.com>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060711190346.GK5362@redhat.com>
References: <20060711190346.GK5362@redhat.com>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 12:13:47 -0700
Message-Id: <1152645227.760.9.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 15:03 -0400, Dave Jones wrote:
> Just saw this during boot of a HT P4 box.
> 
> BUG: soft lockup detected on CPU#0!
>  [<c04051af>] show_trace_log_lvl+0x54/0xfd
>  [<c0405766>] show_trace+0xd/0x10
>  [<c0405885>] dump_stack+0x19/0x1b
>  [<c0450ec7>] softlockup_tick+0xa5/0xb9
>  [<c042d496>] run_local_timers+0x12/0x14
>  [<c042d81b>] update_process_times+0x3c/0x61
>  [<c04179e0>] smp_apic_timer_interrupt+0x6d/0x75
>  [<c0404ada>] apic_timer_interrupt+0x2a/0x30

That's clocksource_adjust/lost tick bug. Roman's fix landed in Linus'
-git yesterday.

thanks
-john


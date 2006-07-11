Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWGKTDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWGKTDy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWGKTDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:03:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16068 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751182AbWGKTDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:03:53 -0400
Date: Tue, 11 Jul 2006 15:03:46 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 18rc1 soft lockup
Message-ID: <20060711190346.GK5362@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just saw this during boot of a HT P4 box.

BUG: soft lockup detected on CPU#0!
 [<c04051af>] show_trace_log_lvl+0x54/0xfd
 [<c0405766>] show_trace+0xd/0x10
 [<c0405885>] dump_stack+0x19/0x1b
 [<c0450ec7>] softlockup_tick+0xa5/0xb9
 [<c042d496>] run_local_timers+0x12/0x14
 [<c042d81b>] update_process_times+0x3c/0x61
 [<c04179e0>] smp_apic_timer_interrupt+0x6d/0x75
 [<c0404ada>] apic_timer_interrupt+0x2a/0x30
BUG: soft lockup detected on CPU#1!
 [<c04051af>] show_trace_log_lvl+0x54/0xfd
 [<c0405766>] show_trace+0xd/0x10
 [<c0405885>] dump_stack+0x19/0x1b
 [<c0450ec7>] softlockup_tick+0xa5/0xb9
 [<c042d496>] run_local_timers+0x12/0x14
 [<c042d81b>] update_process_times+0x3c/0x61
 [<c04179e0>] smp_apic_timer_interrupt+0x6d/0x75
 [<c0404ada>] apic_timer_interrupt+0x2a/0x30
BUG: soft lockup detected on CPU#0!
 [<c04051af>] show_trace_log_lvl+0x54/0xfd
 [<c0405766>] show_trace+0xd/0x10
 [<c0405885>] dump_stack+0x19/0x1b
 [<c0450ec7>] softlockup_tick+0xa5/0xb9
 [<c042d496>] run_local_timers+0x12/0x14
 [<c042d81b>] update_process_times+0x3c/0x61
 [<c04179e0>] smp_apic_timer_interrupt+0x6d/0x75
 [<c0404ada>] apic_timer_interrupt+0x2a/0x30

It then continued booting just fine..

		Dave

-- 
http://www.codemonkey.org.uk

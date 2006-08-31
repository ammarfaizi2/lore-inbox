Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWHaSII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWHaSII (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 14:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWHaSII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 14:08:08 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:16578 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932428AbWHaSIE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 14:08:04 -0400
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
From: Badari Pulavarty <pbadari@gmail.com>
To: Andi Kleen <ak@suse.de>
Cc: Jan Beulich <jbeulich@novell.com>, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200608311716.08786.ak@suse.de>
References: <20060820013121.GA18401@fieldses.org>
	 <200608310941.40076.ak@suse.de>
	 <1157036578.22667.6.camel@dyn9047017100.beaverton.ibm.com>
	 <200608311716.08786.ak@suse.de>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 11:11:17 -0700
Message-Id: <1157047877.22667.11.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One more case ..

Thanks,
Badari

BUG: soft lockup detected on CPU#2!

Call Trace:
 [<ffffffff8020b395>] show_trace+0xb5/0x370
 [<ffffffff8020b665>] dump_stack+0x15/0x20
 [<ffffffff802555b9>] softlockup_tick+0xe9/0x110
 [<ffffffff8023a2c3>] run_local_timers+0x13/0x20
 [<ffffffff8023a5b7>] update_process_times+0x57/0x90
 [<ffffffff802164fb>] smp_local_timer_interrupt+0x2b/0x60
 [<ffffffff80216aa9>] smp_apic_timer_interrupt+0x49/0x60
 [<ffffffff8020a8ce>] apic_timer_interrupt+0x66/0x6c
 [<ffffffff804cd64e>] .text.lock.spinlock+0x0/0x92
DWARF2 unwinder stuck at .text.lock.spinlock+0x0/0x92
Leftover inexact backtrace:
 [<ffffffff80265be9>] unmap_vmas+0x799/0x7e0
 [<ffffffff8026981b>] exit_mmap+0x7b/0x100
 [<ffffffff8022d807>] mmput+0x37/0xb0
 [<ffffffff80231d04>] exit_mm+0x104/0x120
 [<ffffffff80233676>] do_exit+0x246/0x960
 [<ffffffff804cd4ec>] _spin_unlock_irqrestore+0xc/0x10
 [<ffffffff8020b9b4>] die+0x54/0x60
 [<ffffffff8020bb4e>] do_trap+0xee/0x110
 [<ffffffff8020c397>] do_invalid_op+0xa7/0xc0
 [<ffffffff802850fe>] __set_page_dirty_buffers+0x3e/0xe0
 [<ffffffff8025f7b6>] activate_page+0x26/0xc0
 [<ffffffff8025fec3>] mark_page_accessed+0x23/0x50
 [<ffffffff8025addc>] filemap_nopage+0x19c/0x350
 [<ffffffff8020aa29>] error_exit+0x0/0x84
 [<ffffffff802850fe>] __set_page_dirty_buffers+0x3e/0xe0
 [<ffffffff802850d8>] __set_page_dirty_buffers+0x18/0xe0
 [<ffffffff8025de8b>] set_page_dirty+0x3b/0x60
 [<ffffffff8026d34b>] msync_interval+0x2cb/0x420
 [<ffffffff8026d5ab>] sys_msync+0x10b/0x2b0
 [<ffffffff80209d5a>] system_call+0x7e/0x83




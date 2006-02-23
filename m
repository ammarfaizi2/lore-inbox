Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWBWMrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWBWMrH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 07:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWBWMrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 07:47:07 -0500
Received: from odin2.bull.net ([192.90.70.84]:43397 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S1751159AbWBWMrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 07:47:06 -0500
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: RT : 2.6.15-rt17 and possible softlockup detected on CPU#1!
Date: Thu, 23 Feb 2006 13:54:32 +0100
User-Agent: KMail/1.7.1
Cc: Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602231354.32259.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I get the following messages :

BUG: tsc:6796, possible softlockup detected on CPU#1!
 [<c01047ec>] dump_stack+0x1c/0x20 (20)
 [<c014b3a7>] softlockup_detected+0x37/0x50 (24)
 [<c014b493>] softlockup_tick+0xd3/0xf0 (24)
 [<c012b013>] update_process_times+0x83/0x90 (16)
 [<c013da2d>] handle_update+0x1d/0x20 (12)
 [<c013dada>] handle_nextevent_update+0x1a/0x20 (12)
 [<c01137b3>] smp_apic_timer_interrupt+0x73/0x80 (16)
 [<c0104361>] apic_timer_interrupt+0x21/0x30 (-868712892)
---------------------------
| preempt count: 00010000 ]
| 0-level deep critical section nesting:
----------------------------------------

BUG: tsc:6796, possible softlockup detected on CPU#1!
 [<c01047ec>] dump_stack+0x1c/0x20 (20)
 [<c014b3a7>] softlockup_detected+0x37/0x50 (24)
 [<c014b493>] softlockup_tick+0xd3/0xf0 (24)
 [<c012b013>] update_process_times+0x83/0x90 (16)
 [<c013da2d>] handle_update+0x1d/0x20 (12)
 [<c013dada>] handle_nextevent_update+0x1a/0x20 (12)
 [<c01137b3>] smp_apic_timer_interrupt+0x73/0x80 (16)
 [<c0104361>] apic_timer_interrupt+0x21/0x30 (-868712892)
---------------------------
| preempt count: 00010000 ]
| 0-level deep critical section nesting:
----------------------------------------

BUG: tsc:6821, possible softlockup detected on CPU#1!
 [<c01047ec>] dump_stack+0x1c/0x20 (20)
 [<c014b3a7>] softlockup_detected+0x37/0x50 (24)
 [<c014b493>] softlockup_tick+0xd3/0xf0 (24)
 [<c012b013>] update_process_times+0x83/0x90 (16)
 [<c013da2d>] handle_update+0x1d/0x20 (12)
 [<c013dada>] handle_nextevent_update+0x1a/0x20 (12)
 [<c01137b3>] smp_apic_timer_interrupt+0x73/0x80 (16)
 [<c0104361>] apic_timer_interrupt+0x21/0x30 (-870324188)
---------------------------
| preempt count: 00010000 ]
| 0-level deep critical section nesting:
----------------------------------------

These messages occurs while my RT program loops.

-- 
Serge Noiraud

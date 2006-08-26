Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbWHZLfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWHZLfn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 07:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWHZLfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 07:35:43 -0400
Received: from web52906.mail.yahoo.com ([206.190.49.16]:9831 "HELO
	web52906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964939AbWHZLfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 07:35:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=HTNpUwZDscgzMNXfKwQXufXvOVojkjg6yIeNVkQYi4gUptPVzSu2kXU3J1cU6QfFeCQYv0t3sBH6AhTW5Ifdcw4V3WHXv4xdAYK1SJnkKh1sJ6aXwGtQ1BkKNk+Y+mv7p4EDn/jXy3a91At+Bj4DLQqWj2ED8YlQLCTLB6p6vQQ=  ;
Message-ID: <20060826113541.35969.qmail@web52906.mail.yahoo.com>
Date: Sat, 26 Aug 2006 12:35:41 +0100 (BST)
From: Chris Rankin <rankincj@yahoo.com>
Subject: Soft lockup with 2.6.17.7
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Linux 2.6.17.7-SMP, dual P4 Xeon (hyperthreaded), 2 GB RAM]

Hi,

My 2.6.17.7 workstation locked up the other night, and wrote these messages to the serial console:

The system is going down for reboot NOW!
[root@volcano chris]# BUG: soft lockup detected on CPU#2!
 <c0130b5f> softlockup_tick+0x9c/0xb1  <c011fae8> update_process_times+0x3d/0x60
 <c010d5ea> smp_apic_timer_interrupt+0x52/0x58  <c0103320> apic_timer_interrupt+0x1c/0x24
 <c010c192> flush_tlb_others+0x7e/0xab  <c010c364> flush_tlb_page+0x85/0xa6
 <c013b7f7> do_wp_page+0x223/0x283  <c013ca3f> __handle_mm_fault+0x6aa/0x70d
 <c0110f99> do_page_fault+0x20f/0x532  <c0110d8a> do_page_fault+0x0/0x532
 <c01033eb> error_code+0x4f/0x54 
BUG: soft lockup detected on CPU#2!
 <c0130b5f> softlockup_tick+0x9c/0xb1  <c011fae8> update_process_times+0x3d/0x60
 <c010d5ea> smp_apic_timer_interrupt+0x52/0x58  <c0103320> apic_timer_interrupt+0x1c/0x24
 <c010c192> flush_tlb_others+0x7e/0xab  <c010c364> flush_tlb_page+0x85/0xa6
 <c013b7f7> do_wp_page+0x223/0x283  <c013ca3f> __handle_mm_fault+0x6aa/0x70d
 <c0110f99> do_page_fault+0x20f/0x532  <c0110d8a> do_page_fault+0x0/0x532
 <c01033eb> error_code+0x4f/0x54 
BUG: soft lockup detected on CPU#2!
 <c0130b5f> softlockup_tick+0x9c/0xb1  <c011fae8> update_process_times+0x3d/0x60
 <c010d5ea> smp_apic_timer_interrupt+0x52/0x58  <c0103320> apic_timer_interrupt+0x1c/0x24
 <c010c192> flush_tlb_others+0x7e/0xab  <c010c364> flush_tlb_page+0x85/0xa6
 <c013b7f7> do_wp_page+0x223/0x283  <c013ca3f> __handle_mm_fault+0x6aa/0x70d
 <c0110f99> do_page_fault+0x20f/0x532  <c0110d8a> do_page_fault+0x0/0x532
 <c01033eb> error_code+0x4f/0x54 
BUG: soft lockup detected on CPU#2!
 <c0130b5f> softlockup_tick+0x9c/0xb1  <c011fae8> update_process_times+0x3d/0x60
 <c010d5ea> smp_apic_timer_interrupt+0x52/0x58  <c0103320> apic_timer_interrupt+0x1c/0x24
 <c010c192> flush_tlb_others+0x7e/0xab  <c010c364> flush_tlb_page+0x85/0xa6
 <c013b7f7> do_wp_page+0x223/0x283  <c013ca3f> __handle_mm_fault+0x6aa/0x70d
 <c0110f99> do_page_fault+0x20f/0x532  <c0110d8a> do_page_fault+0x0/0x532
 <c01033eb> error_code+0x4f/0x54 
BUG: soft lockup detected on CPU#2!
 <c0130b5f> softlockup_tick+0x9c/0xb1  <c011fae8> update_process_times+0x3d/0x60
 <c010d5ea> smp_apic_timer_interrupt+0x52/0x58  <c0103320> apic_timer_interrupt+0x1c/0x24
 <c010c192> flush_tlb_others+0x7e/0xab  <c010c364> flush_tlb_page+0x85/0xa6
 <c013b7f7> do_wp_page+0x223/0x283  <c013ca3f> __handle_mm_fault+0x6aa/0x70d
 <c0110f99> do_page_fault+0x20f/0x532  <c0110d8a> do_page_fault+0x0/0x532
 <c01033eb> error_code+0x4f/0x54 
BUG: soft lockup detected on CPU#2!
 <c0130b5f> softlockup_tick+0x9c/0xb1  <c011fae8> update_process_times+0x3d/0x60
 <c010d5ea> smp_apic_timer_interrupt+0x52/0x58  <c0103320> apic_timer_interrupt+0x1c/0x24
 <c010c192> flush_tlb_others+0x7e/0xab  <c010c364> flush_tlb_page+0x85/0xa6
 <c013b7f7> do_wp_page+0x223/0x283  <c013ca3f> __handle_mm_fault+0x6aa/0x70d
 <c0110f99> do_page_fault+0x20f/0x532  <c0110d8a> do_page_fault+0x0/0x532
 <c01033eb> error_code+0x4f/0x54 
BUG: soft lockup detected on CPU#2!
 <c0130b5f> softlockup_tick+0x9c/0xb1  <c011fae8> update_process_times+0x3d/0x60
 <c010d5ea> smp_apic_timer_interrupt+0x52/0x58  <c0103320> apic_timer_interrupt+0x1c/0x24
 <c010c192> flush_tlb_others+0x7e/0xab  <c010c364> flush_tlb_page+0x85/0xa6
 <c013b7f7> do_wp_page+0x223/0x283  <c013ca3f> __handle_mm_fault+0x6aa/0x70d
 <c0110f99> do_page_fault+0x20f/0x532  <c0110d8a> do_page_fault+0x0/0x532
 <c01033eb> error_code+0x4f/0x54 
BUG: soft lockup detected on CPU#2!
 <c0130b5f> softlockup_tick+0x9c/0xb1  <c011fae8> update_process_times+0x3d/0x60
 <c010d5ea> smp_apic_timer_interrupt+0x52/0x58  <c0103320> apic_timer_interrupt+0x1c/0x24
 <c010c192> flush_tlb_others+0x7e/0xab  <c010c364> flush_tlb_page+0x85/0xa6
 <c013b7f7> do_wp_page+0x223/0x283  <c013ca3f> __handle_mm_fault+0x6aa/0x70d
 <c0110f99> do_page_fault+0x20f/0x532  <c0110d8a> do_page_fault+0x0/0x532
 <c01033eb> error_code+0x4f/0x54 
BUG: soft lockup detected on CPU#2!
 <c0130b5f> softlockup_tick+0x9c/0xb1  <c011fae8> update_process_times+0x3d/0x60
 <c010d5ea> smp_apic_timer_interrupt+0x52/0x58  <c0103320> apic_timer_interrupt+0x1c/0x24
 <c010c192> flush_tlb_others+0x7e/0xab  <c010c364> flush_tlb_page+0x85/0xa6
 <c013b7f7> do_wp_page+0x223/0x283  <c013ca3f> __handle_mm_fault+0x6aa/0x70d
 <c0110f99> do_page_fault+0x20f/0x532  <c0110d8a> do_page_fault+0x0/0x532
 <c01033eb> error_code+0x4f/0x54 
BUG: soft lockup detected on CPU#2!
 <c0130b5f> softlockup_tick+0x9c/0xb1  <c011fae8> update_process_times+0x3d/0x60
 <c010d5ea> smp_apic_timer_interrupt+0x52/0x58  <c0103320> apic_timer_interrupt+0x1c/0x24
 <c010c192> flush_tlb_others+0x7e/0xab  <c010c364> flush_tlb_page+0x85/0xa6
 <c013b7f7> do_wp_page+0x223/0x283  <c013ca3f> __handle_mm_fault+0x6aa/0x70d
 <c0110f99> do_page_fault+0x20f/0x532  <c0110d8a> do_page_fault+0x0/0x532
 <c01033eb> error_code+0x4f/0x54 
BUG: soft lockup detected on CPU#2!
 <c0130b5f> softlockup_tick+0x9c/0xb1  <c011fae8> update_process_times+0x3d/0x60
 <c010d5ea> smp_apic_timer_interrupt+0x52/0x58  <c0103320> apic_timer_interrupt+0x1c/0x24
 <c010c192> flush_tlb_others+0x7e/0xab  <c010c364> flush_tlb_page+0x85/0xa6
 <c013b7f7> do_wp_page+0x223/0x283  <c013ca3f> __handle_mm_fault+0x6aa/0x70d
 <c0110f99> do_page_fault+0x20f/0x532  <c0110d8a> do_page_fault+0x0/0x532
 <c01033eb> error_code+0x4f/0x54 
BUG: soft lockup detected on CPU#2!
 <c0130b5f> softlockup_tick+0x9c/0xb1  <c011fae8> update_process_times+0x3d/0x60
 <c010d5ea> smp_apic_timer_interrupt+0x52/0x58  <c0103320> apic_timer_interrupt+0x1c/0x24
 <c010c192> flush_tlb_others+0x7e/0xab  <c010c364> flush_tlb_page+0x85/0xa6
 <c013b7f7> do_wp_page+0x223/0x283  <c013ca3f> __handle_mm_fault+0x6aa/0x70d
 <c0110f99> do_page_fault+0x20f/0x532  <c0110d8a> do_page_fault+0x0/0x532
 <c01033eb> error_code+0x4f/0x54 
BUG: soft lockup detected on CPU#2!
 <c0130b5f> softlockup_tick+0x9c/0xb1  <c011fae8> update_process_times+0x3d/0x60
 <c010d5ea> smp_apic_timer_interrupt+0x52/0x58  <c0103320> apic_timer_interrupt+0x1c/0x24
 <c010c192> flush_tlb_others+0x7e/0xab  <c010c364> flush_tlb_page+0x85/0xa6
 <c013b7f7> do_wp_page+0x223/0x283  <c013ca3f> __handle_mm_fault+0x6aa/0x70d
 <c0110f99> do_page_fault+0x20f/0x532  <c0110d8a> do_page_fault+0x0/0x532
 <c01033eb> error_code+0x4f/0x54 

I was trying to run World of Warcraft under Wine, while simultaneously compiling MESA, and so I
suspect that a lot of my RAM was active at the time.

Cheers,
Chris



		
___________________________________________________________ 
The all-new Yahoo! Mail goes wherever you go - free your email address from your Internet provider. http://uk.docs.yahoo.com/nowyoucan.html

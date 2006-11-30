Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936177AbWK3DNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936177AbWK3DNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 22:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936178AbWK3DNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 22:13:12 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:25867 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S936177AbWK3DNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 22:13:11 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200611300313.kAU3D9J7007005@clem.clem-digital.net>
Subject: 2.6.19 panic on boot -- i386
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Wed, 29 Nov 2006 22:13:09 -0500 (EST)
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.19 panics at boot. Good up through rc6-git11.
Hand copied screen below.
-- 
Pete Clements 


Call Trace:
[<f894cda0>] ndisc_send_rs+0x420/0x460 [ipv6]
[<f894cdac>] ndisc_send_rs+0x42c/0x460 [ipv6]
[<f894cda0>] ndisc_send rs+0x420/0x460 [ipv6]
[<f8940ac3>] addrconf_dad_completed+0x93/0xe0 [ipv6]
[<f89437e9>] addrconf_dad_timer+0x119/0x120 [ipv6]
[<c0115e31>] rebalance_tick+0x131/0x350
[<f89436d0>] addrconf_dad_timer+0x0/0x120 [ipv6]
[<c01255f3>] run_timer_softirq+0x113/0x190
[<c01209e5>] __do_softirq+0x75/0xf0
[<c0120a9b>] do_softirq+03b/0x50
[<c010ea05>] smp_apic_timer_interrupt+0xa5/0xc0
[<c0103ba7>] apic_timer_interrupt+0x1f/0x24
[<c0101d20>] default_idle+0x0/0x60
[<c0101d51>] default_idle+031/0x60
[<c0101dec>] cpu_idle+0x6c/0x90
[<c03d386e>] start_kernel+0x34e/0x3d0
[<c03d3290>] unknown_bootoption+0x0/0x290
========================
Code: 8c 00 00 00 89 44 24 10 8b 44 24 2c 89 44 24 0c 8b 41 60 c7 04 24 e4 ac 36
 c0 89 44 24 08 8b 44 24 30 89 44 24 04 e8 9d 51 e6 ff <0f> 0b 5d 00 1a 84 36 c0
 83 c4 24 c3 90 55 57 56 53 83 ec 2c 8b
EIP: [<c02b7283>] skb_over_panic+0x63/0x70 SS:ESP 0068:c03cfe08
 <0>Kernel panic - not syncing: Fatal exception in interrupt

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbVIUNLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbVIUNLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 09:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbVIUNLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 09:11:19 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:60113 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S1750897AbVIUNLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 09:11:18 -0400
Message-ID: <43315BEB.3010909@ens-lyon.org>
Date: Wed, 21 Sep 2005 15:11:07 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Kernel panic during SysRq-b on Alpha
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get the following panic each time I try SysRq-b on my
Alpha EV56. This is a home-compiled 2.6.13.1 kernel.
I don't see anything interesting in 2.6.13.2 changelog.

This one was actually caught through a serial line,
but I see the same behavior when sysrq-b is passed
through the main console.

Regards,
Brice



SysRq : Resetting
Kernel bug at kernel/printk.c:683
swapper(0): Kernel Bug 1
pc = [<fffffc000032706c>]  ra = [<fffffc00004352d4>]  ps = 0007    Not
tainted
pc is at acquire_console_sem+0x2c/0x90
ra is at take_over_console+0x74/0x500
v0 = 0000000000000007  t0 = 000000000fffff00  t1 = 0000000000010000
t2 = fffffc0000002240  t3 = 0000000000000000  t4 = 000000000000000d
t5 = 000000000000000e  t6 = ffffffffffffe051  t7 = fffffc000059c000
a0 = fffffc00005022c0  a1 = 0000000000000000  a2 = 000000000000003e
a3 = 0000000000000001  a4 = 0000000000000001  a5 = 0000000000000005
t8 = 000000000000001f  t9 = fffffc00004038d0  t10= 0000000000000000
t11= 000000000000000a  pv = fffffc0000327040  at = 0000000000000000
gp = fffffc0000648e00  sp = fffffc000059fbc0
Trace:
[<fffffc00004352d4>] take_over_console+0x74/0x500
[<fffffc0000312de8>] common_shutdown_1+0x78/0x130
[<fffffc0000312ec0>] common_shutdown+0x20/0x30
[<fffffc00004372f4>] __handle_sysrq+0xd4/0x200
[<fffffc0000441398>] receive_chars+0x1e8/0x330
[<fffffc000044197c>] serial8250_interrupt+0x12c/0x130
[<fffffc0000315dfc>] handle_IRQ_event+0x6c/0xf0
[<fffffc00003167a0>] handle_irq+0xd0/0x180
[<fffffc000031f530>] miata_srm_device_interrupt+0x30/0x50
[<fffffc0000316d64>] do_entInt+0xf4/0x140
[<fffffc0000311140>] ret_from_sys_call+0x0/0x10
[<fffffc0000312ce0>] default_idle+0x0/0x10
[<fffffc0000312d48>] cpu_idle+0x58/0x80
[<fffffc0000312ce0>] default_idle+0x0/0x10
[<fffffc0000312ce0>] default_idle+0x0/0x10
[<fffffc00003100a4>] rest_init+0x44/0x60
[<fffffc000031001c>] __start+0x1c/0x20

Code: 2021ff00  b53e0008  a0480064  44410002  e4400004  00000081
<000002ab> 0050944f
Kernel panic - not syncing: Aiee, killing interrupt handler!

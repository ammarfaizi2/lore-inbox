Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbTJTUPz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 16:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbTJTUPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 16:15:55 -0400
Received: from k1.dinoex.de ([80.237.200.94]:39439 "EHLO k1.dinoex.de")
	by vger.kernel.org with ESMTP id S262781AbTJTUPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 16:15:53 -0400
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test8] might sleep
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
From: Jochen Hein <jochen@jochen.org>
X-No-Archive: yes
Date: Mon, 20 Oct 2003 21:53:55 +0200
Message-ID: <87ekx78z3g.fsf@echidna.jochen.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From the kernel log:

Oct 20 21:28:54 gswi1164 kernel: PID hash table entries: 512 (order 9:
4096 bytes)
Oct 20 21:28:54 gswi1164 kernel: Detected 232.193 MHz processor.
Oct 20 21:28:54 gswi1164 kernel: Console: colour dummy device 80x25
Oct 20 21:28:54 gswi1164 kernel: in_atomic():1, irqs_disabled():1
Oct 20 21:28:54 gswi1164 kernel: Call Trace:
Oct 20 21:28:54 gswi1164 kernel:  [__might_sleep+160/208] __might_sleep+0xa0/0xd0
Oct 20 21:28:54 gswi1164 kernel:  [acquire_console_sem+59/96] acquire_console_sem+0x3b/0x60
Oct 20 21:28:54 gswi1164 kernel:  [register_console+149/480] register_console+0x95/0x1e0
Oct 20 21:28:54 gswi1164 kernel:  [con_init+514/576] con_init+0x202/0x240
Oct 20 21:28:54 gswi1164 kernel:  [_stext+0/96] rest_init+0x0/0x60
Oct 20 21:28:54 gswi1164 kernel:  [console_init+52/80] console_init+0x34/0x50
Oct 20 21:28:54 gswi1164 kernel:  [start_kernel+190/368] start_kernel+0xbe/0x170
Oct 20 21:28:54 gswi1164 kernel:  [unknown_bootoption+0/272] unknown_bootoption+0x0/0x110
Oct 20 21:28:54 gswi1164 kernel:
Oct 20 21:28:54 gswi1164 kernel: Memory: 93728k/98112k available (1877k kernel code, 3876k reserved, 713k data, 140k init, 0k highmem)
Oct 20 21:28:55 gswi1164 default.hotplug[142]: invoke /etc/hotplug/usb.agent ()
Oct 20 21:28:55 gswi1164 default.hotplug[143]: invoke /etc/hotplug/usb.agent ()
Oct 20 21:28:55 gswi1164 kernel: in_atomic():1, irqs_disabled():0
Oct 20 21:28:55 gswi1164 kernel: Call Trace:
Oct 20 21:28:55 gswi1164 kernel:  [__might_sleep+160/208] __might_sleep+0xa0/0xd0
Oct 20 21:28:55 gswi1164 kernel:  [kmem_cache_alloc+474/480] kmem_cache_alloc+0x1da/0x1e0
Oct 20 21:28:55 gswi1164 kernel:  [printk+294/384] printk+0x126/0x180
Oct 20 21:28:55 gswi1164 kernel:  [kmem_cache_create+362/1696] kmem_cache_create+0x16a/0x6a0
Oct 20 21:28:55 gswi1164 kernel:  [mem_init+405/512] mem_init+0x195/0x200
Oct 20 21:28:55 gswi1164 kernel:  [_stext+0/96] rest_init+0x0/0x60
Oct 20 21:28:55 gswi1164 kernel:  [kmem_cache_init+281/704] kmem_cache_init+0x119/0x2c0
Oct 20 21:28:55 gswi1164 kernel:  [start_kernel+206/368] start_kernel+0xce/0x170
Oct 20 21:28:55 gswi1164 kernel:  [unknown_bootoption+0/272] unknown_bootoption+0x0/0x110
Oct 20 21:28:55 gswi1164 kernel:
Oct 20 21:28:55 gswi1164 kernel: Calibrating delay loop... 455.68 BogoMIPS
Oct 20 21:28:55 gswi1164 kernel: Security Scaffold v1.0.0 initialized

Jochen

-- 
#include <~/.signature>: permission denied

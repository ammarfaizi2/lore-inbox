Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbTJTUXH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 16:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbTJTUXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 16:23:07 -0400
Received: from mcomail03.maxtor.com ([134.6.76.14]:51213 "EHLO
	mcomail03.maxtor.com") by vger.kernel.org with ESMTP
	id S262769AbTJTUXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 16:23:01 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB31A@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'Jochen Hein'" <jochen@jochen.org>, linux-kernel@vger.kernel.org
Subject: RE: [2.6.0-test8] might sleep
Date: Mon, 20 Oct 2003 14:23:00 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess the obvious question is "what boot options are you passing your
kernel?"

> -----Original Message-----
> From: Jochen Hein [mailto:jochen@jochen.org]
> Sent: Monday, October 20, 2003 1:54 PM
> To: linux-kernel@vger.kernel.org
> Subject: [2.6.0-test8] might sleep
> 
> 
> 
> From the kernel log:
> 
> Oct 20 21:28:54 gswi1164 kernel: PID hash table entries: 512 (order 9:
> 4096 bytes)
> Oct 20 21:28:54 gswi1164 kernel: Detected 232.193 MHz processor.
> Oct 20 21:28:54 gswi1164 kernel: Console: colour dummy device 80x25
> Oct 20 21:28:54 gswi1164 kernel: in_atomic():1, irqs_disabled():1
> Oct 20 21:28:54 gswi1164 kernel: Call Trace:
> Oct 20 21:28:54 gswi1164 kernel:  [__might_sleep+160/208] 
> __might_sleep+0xa0/0xd0
> Oct 20 21:28:54 gswi1164 kernel:  [acquire_console_sem+59/96] 
> acquire_console_sem+0x3b/0x60
> Oct 20 21:28:54 gswi1164 kernel:  [register_console+149/480] 
> register_console+0x95/0x1e0
> Oct 20 21:28:54 gswi1164 kernel:  [con_init+514/576] 
> con_init+0x202/0x240
> Oct 20 21:28:54 gswi1164 kernel:  [_stext+0/96] rest_init+0x0/0x60
> Oct 20 21:28:54 gswi1164 kernel:  [console_init+52/80] 
> console_init+0x34/0x50
> Oct 20 21:28:54 gswi1164 kernel:  [start_kernel+190/368] 
> start_kernel+0xbe/0x170
> Oct 20 21:28:54 gswi1164 kernel:  [unknown_bootoption+0/272] 
> unknown_bootoption+0x0/0x110
> Oct 20 21:28:54 gswi1164 kernel:
> Oct 20 21:28:54 gswi1164 kernel: Memory: 93728k/98112k 
> available (1877k kernel code, 3876k reserved, 713k data, 140k 
> init, 0k highmem)
> Oct 20 21:28:55 gswi1164 default.hotplug[142]: invoke 
> /etc/hotplug/usb.agent ()
> Oct 20 21:28:55 gswi1164 default.hotplug[143]: invoke 
> /etc/hotplug/usb.agent ()
> Oct 20 21:28:55 gswi1164 kernel: in_atomic():1, irqs_disabled():0
> Oct 20 21:28:55 gswi1164 kernel: Call Trace:
> Oct 20 21:28:55 gswi1164 kernel:  [__might_sleep+160/208] 
> __might_sleep+0xa0/0xd0
> Oct 20 21:28:55 gswi1164 kernel:  [kmem_cache_alloc+474/480] 
> kmem_cache_alloc+0x1da/0x1e0
> Oct 20 21:28:55 gswi1164 kernel:  [printk+294/384] printk+0x126/0x180
> Oct 20 21:28:55 gswi1164 kernel:  
> [kmem_cache_create+362/1696] kmem_cache_create+0x16a/0x6a0
> Oct 20 21:28:55 gswi1164 kernel:  [mem_init+405/512] 
> mem_init+0x195/0x200
> Oct 20 21:28:55 gswi1164 kernel:  [_stext+0/96] rest_init+0x0/0x60
> Oct 20 21:28:55 gswi1164 kernel:  [kmem_cache_init+281/704] 
> kmem_cache_init+0x119/0x2c0
> Oct 20 21:28:55 gswi1164 kernel:  [start_kernel+206/368] 
> start_kernel+0xce/0x170
> Oct 20 21:28:55 gswi1164 kernel:  [unknown_bootoption+0/272] 
> unknown_bootoption+0x0/0x110
> Oct 20 21:28:55 gswi1164 kernel:
> Oct 20 21:28:55 gswi1164 kernel: Calibrating delay loop... 
> 455.68 BogoMIPS
> Oct 20 21:28:55 gswi1164 kernel: Security Scaffold v1.0.0 initialized
> 
> Jochen
> 
> -- 
> #include <~/.signature>: permission denied
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

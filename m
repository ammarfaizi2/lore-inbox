Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262658AbSI1Aj3>; Fri, 27 Sep 2002 20:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262659AbSI1Aj3>; Fri, 27 Sep 2002 20:39:29 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:4992 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S262658AbSI1Aj2>; Fri, 27 Sep 2002 20:39:28 -0400
Date: Fri, 27 Sep 2002 17:44:48 -0700
To: linux-kernel@vger.kernel.org
Cc: "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Assert failure, IDE ?
Message-ID: <20020928004448.GA764@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

In 2.5.39, I get at boot time:

Sep 27 17:37:38 gnuppy kernel: Sleeping function called from illegal context at slab.c:1374
Sep 27 17:37:38 gnuppy kernel: c15d3ed8 c0113856 c02b8300 c02ba607 0000055e c15750c0 c012f3e3 c02ba607 
Sep 27 17:37:38 gnuppy kernel:        0000055e c03b3aac 00033d82 4a320068 00000068 d7d7c200 c0223a40 20000000 
Sep 27 17:37:38 gnuppy kernel:        c03b1e10 c010898c 00000018 000001d0 d7d7c200 c03b1e00 0000000e 00000008 
Sep 27 17:37:38 gnuppy kernel: Call Trace:
Sep 27 17:37:38 gnuppy kernel:  [__might_sleep+86/96]__might_sleep+0x56/0x60
Sep 27 17:37:38 gnuppy kernel:  [kmalloc+99/336]kmalloc+0x63/0x150
Sep 27 17:37:38 gnuppy kernel:  [ide_intr+0/464]ide_intr+0x0/0x1d0
Sep 27 17:37:38 gnuppy kernel:  [request_irq+60/160]request_irq+0x3c/0xa0
Sep 27 17:37:38 gnuppy kernel:  [init_irq+325/880]init_irq+0x145/0x370
Sep 27 17:37:38 gnuppy kernel:  [ide_intr+0/464]ide_intr+0x0/0x1d0
Sep 27 17:37:38 gnuppy kernel:  [hwif_init+118/624]hwif_init+0x76/0x270
Sep 27 17:37:38 gnuppy kernel:  [ideprobe_init+140/272]ideprobe_init+0x8c/0x110
Sep 27 17:37:38 gnuppy kernel:  [init+50/432]init+0x32/0x1b0
Sep 27 17:37:38 gnuppy kernel:  [init+0/432]init+0x0/0x1b0
Sep 27 17:37:38 gnuppy kernel:  [kernel_thread_helper+5/16]kernel_thread_helper+0x5/0x10
Sep 27 17:37:38 gnuppy kernel: 
Sep 27 17:37:38 gnuppy kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

bill


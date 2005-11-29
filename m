Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbVK2U3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbVK2U3G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 15:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVK2U3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 15:29:06 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:45896 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932381AbVK2U3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 15:29:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:reply-to:x-priority:message-id:to:subject:mime-version:content-type:content-transfer-encoding;
        b=CwslQx9zwgfZymwrDu/JqAUK4CiXvIdXHiU+4x7KY5fQII7IOJqNL7GI5axqi4eLntAg0Mq2f21KL+UU/2rCqIZUzytH4LS7Tqnj3TTUmuGWpDTGrWtY01M/qcek8cGDsiZwPIMexTbLy+sE8GjncDqNaStj6VVE4oFKOT962XI=
Date: Tue, 29 Nov 2005 21:28:51 +0100
From: Mateusz Berezecki <mateuszb@gmail.com>
Reply-To: Mateusz Berezecki <mateuszb@gmail.com>
X-Priority: 3 (Normal)
Message-ID: <745843498.20051129212851@gmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       <kernel-mentors@selenic.com>
Subject: NIC irq nobody cared ? virtual to  physical  and DMA questions
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,

This time the questions are different.

Given the following output could anyone please tell me what is wrong ?
In explicit what does that mysterious "nobody cared" message mean?
And another stupid question: should DMA for a network card be enabled before or maybe
_after_ interrupts get enabled? And... how to convert virtual address
to physical one?

Nov 29 21:25:47 debian kernel: atheros: receive init routine called
Nov 29 21:25:47 debian kernel: atheros: physical address of RX head is 00000000
Nov 29 21:25:47 debian kernel: atheros: enabling DMA receive. this can crash things supposedly.
Nov 29 21:25:47 debian kernel: irq 11: nobody cared (try booting with the "irqpoll" option)
Nov 29 21:25:47 debian kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Nov 29 21:25:47 debian kernel:  [__report_bad_irq+39/144] __report_bad_irq+0x27/0x90
Nov 29 21:25:47 debian kernel:  [note_interrupt+114/192] note_interrupt+0x72/0xc0
Nov 29 21:25:47 debian kernel:  [__do_IRQ+200/224] __do_IRQ+0xc8/0xe0
Nov 29 21:25:47 debian kernel:  [do_IRQ+80/128] do_IRQ+0x50/0x80
Nov 29 21:25:47 debian kernel:  =======================
Nov 29 21:25:47 debian kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
Nov 29 21:25:47 debian kernel:  [do_softirq+115/128] do_softirq+0x73/0x80
Nov 29 21:25:47 debian kernel:  =======================
Nov 29 21:25:47 debian kernel:  [irq_exit+67/80] irq_exit+0x43/0x50
Nov 29 21:25:47 debian kernel:  [do_IRQ+87/128] do_IRQ+0x57/0x80
Nov 29 21:25:47 debian kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
Nov 29 21:25:47 debian kernel:  [pg0+260065664/1065075712] ath_init+0x30/0x80 [atheros]
Nov 29 21:25:47 debian kernel:  [dev_open+70/144] dev_open+0x46/0x90
Nov 29 21:25:47 debian kernel:  [dev_change_flags+83/288] dev_change_flags+0x53/0x120
Nov 29 21:25:47 debian kernel:  [devinet_ioctl+1437/1472] devinet_ioctl+0x59d/0x5c0
Nov 29 21:25:47 debian kernel:  [inet_ioctl+166/208] inet_ioctl+0xa6/0xd0
Nov 29 21:25:47 debian kernel:  [sock_ioctl+248/592] sock_ioctl+0xf8/0x250
Nov 29 21:25:47 debian kernel:  [do_ioctl+40/144] do_ioctl+0x28/0x90
Nov 29 21:25:47 debian kernel:  [vfs_ioctl+87/496] vfs_ioctl+0x57/0x1f0
Nov 29 21:25:47 debian kernel:  [sys_ioctl+57/96] sys_ioctl+0x39/0x60
Nov 29 21:25:47 debian kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 29 21:25:47 debian kernel: handlers:
Nov 29 21:25:47 debian kernel: [usb_hcd_irq+0/80] (usb_hcd_irq+0x0/0x50)
Nov 29 21:25:47 debian last message repeated 3 times
Nov 29 21:25:47 debian kernel: [yenta_interrupt+0/192] (yenta_interrupt+0x0/0xc0)
Nov 29 21:25:47 debian kernel: [pg0+260075488/1065075712] (ath_intr+0x0/0x150 [atheros])
Nov 29 21:25:47 debian kernel: Disabling IRQ #11
Nov 29 21:25:47 debian kernel: atheros: interrupts enabled
Nov 29 21:25:47 debian kernel: atheros: device up and running

-- 
kind regards,
 Mateusz Berezecki


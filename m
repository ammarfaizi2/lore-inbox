Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268733AbUIXWfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268733AbUIXWfk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 18:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269023AbUIXWfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 18:35:40 -0400
Received: from smtp08.auna.com ([62.81.186.18]:58538 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S268733AbUIXWfh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 18:35:37 -0400
Date: Fri, 24 Sep 2004 22:35:36 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.9-rc2-mm3, e100 oops
To: linux-kernel@vger.kernel.org
References: <20040924014643.484470b1.akpm@osdl.org>
In-Reply-To: <20040924014643.484470b1.akpm@osdl.org> (from akpm@osdl.org on
	Fri Sep 24 10:46:43 2004)
X-Mailer: Balsa 2.2.4
Message-Id: <1096065336l.13335l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.09.24, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm3/
> 
> - This is a quick not-very-well-tested release - it can't be worse than
>   2.6.9-rc2-mm2, which had a few networking problems.
> 

I get this on boot:

Sep 24 12:41:41 nada kernel: e100: Intel(R) PRO/100 Network Driver, 3.1.4-NAPI
Sep 24 12:41:41 nada kernel: e100: Copyright(c) 1999-2004 Intel Corporation
Sep 24 12:41:41 nada kernel: ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 185
Sep 24 12:41:41 nada kernel: e100: eth0: e100_probe: addr 0xf7161000, irq 185, MAC addr 00:30:48:41:22:9F
Sep 24 12:41:41 nada kernel: ip_tables: (C) 2000-2002 Netfilter core team Sep 24 12:41:41 nada kernel: ip_conntrack version 2.1 (8191 buckets, 65528 max) - 336 bytes per conntrack
Sep 24 12:41:41 nada kernel: enable_irq(185) unbalanced from f89b3e25
Sep 24 12:41:41 nada kernel:  [enable_irq+163/240] enable_irq+0xa3/0xf0
Sep 24 12:41:41 nada kernel:  [<c0108a13>] enable_irq+0xa3/0xf0
Sep 24 12:41:41 nada kernel:  [pg0+943935013/1067971584] e100_up+0xd5/0x1e0 [e100]
Sep 24 12:41:41 nada kernel:  [<f89b3e25>] e100_up+0xd5/0x1e0 [e100]
Sep 24 12:41:41 nada kernel:  [pg0+943935013/1067971584] e100_up+0xd5/0x1e0 [e100]
Sep 24 12:41:41 nada kernel:  [<f89b3e25>] e100_up+0xd5/0x1e0 [e100]
Sep 24 12:41:41 nada kernel:  [pg0+943939226/1067971584] e100_open+0x2a/0x90 [e100]
Sep 24 12:41:41 nada kernel:  [<f89b4e9a>] e100_open+0x2a/0x90 [e100]
Sep 24 12:41:41 nada kernel:  [dev_open+116/144] dev_open+0x74/0x90
Sep 24 12:41:41 nada kernel:  [<c036b864>] dev_open+0x74/0x90
Sep 24 12:41:41 nada kernel:  [dev_change_flags+86/304] dev_change_flags+0x56/0x130
Sep 24 12:41:41 nada kernel:  [<c036cda6>] dev_change_flags+0x56/0x130
Sep 24 12:41:41 nada kernel:  [devinet_ioctl+1522/1696] devinet_ioctl+0x5f2/0x6a0
Sep 24 12:41:41 nada kernel:  [<c03a5d72>] devinet_ioctl+0x5f2/0x6a0
Sep 24 12:41:41 nada kernel:  [inet_ioctl+223/256] inet_ioctl+0xdf/0x100
Sep 24 12:41:41 nada kernel:  [<c03a7c8f>] inet_ioctl+0xdf/0x100
Sep 24 12:41:41 nada kernel:  [sock_ioctl+478/672] sock_ioctl+0x1de/0x2a0
Sep 24 12:41:41 nada kernel:  [<c036338e>] sock_ioctl+0x1de/0x2a0
Sep 24 12:41:41 nada kernel:  [fget+73/96] fget+0x49/0x60
Sep 24 12:41:41 nada kernel:  [<c015aa69>] fget+0x49/0x60
Sep 24 12:41:41 nada kernel:  [sys_ioctl+366/672] sys_ioctl+0x16e/0x2a0
Sep 24 12:41:41 nada kernel:  [<c016be2e>] sys_ioctl+0x16e/0x2a0
Sep 24 12:41:41 nada kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Sep 24 12:41:41 nada kernel:  [<c0105bad>] sysenter_past_esp+0x52/0x71
Sep 24 12:41:41 nada kernel: e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc2-mm3 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #1



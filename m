Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbUBXWTO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 17:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbUBXWTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 17:19:14 -0500
Received: from palrel10.hp.com ([156.153.255.245]:36559 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262496AbUBXWTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 17:19:02 -0500
Date: Tue, 24 Feb 2004 14:19:01 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>,
       Manuel Estrada Sainz <ranty@debian.org>
Subject: firmware.agent Opps
Message-ID: <20040224221900.GA5954@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	Using 2.6.3 (SMP), prism54 driver and firmware.agent from
Debian unstable. I got the following nice Ooops :

-----------------------------------------
/etc/hotplug/pci.agent: Setup prism54 for PCI slot 0000:03:00.0
kernel: Loaded prism54 driver, version 1.0.2.2
kernel: PCI: Enabling device 0000:03:00.0 (0000 -> 0002)
/etc/hotplug/net.agent: invoke nameif for eth0
/etc/hotplug/net.agent: iface eth0 is remapped to prism0
/etc/hotplug/net.agent: invoke ifup prism0
/etc/hotplug/pci.agent: missing kernel or user mode driver prism54 
/etc/hotplug/firmware.agent: comming for /class/firmware/0000:03:00.0
/etc/hotplug/firmware.agent: doing echo 1
/etc/hotplug/firmware.agent: doing cp
/etc/hotplug/firmware.agent: doing echo 0
kernel:  printing eip:
kernel: c016519d
kernel: Oops: 0000 [#1]
kernel: CPU:    0
kernel: EIP:    0060:[dnotify_flush+17/120]    Not tainted
kernel: EFLAGS: 00010246
kernel: EIP is at dnotify_flush+0x11/0x78
kernel: eax: cde870c0   ebx: cde79440   ecx: 00000000   edx: cdddfc60
kernel: esi: cde79440   edi: cdddfc60   ebp: cdd8a000   esp: cdd8bf8c
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process firmware.agent (pid: 480, threadinfo=cdd8a000 task=cde29350)
kernel: Stack: cde79440 00000000 cdddfc60 c014c7d0 cde79440 cdddfc60 cde79440 00000000 
kernel:        00000001 c014c83c cde79440 cdddfc60 00000001 c0108c33 00000001 401706a0 
kernel:        080cd648 00000000 00000001 bffff79c 00000006 0000007b 0000007b 00000006 
kernel: Call Trace:
kernel:  [filp_close+84/108] filp_close+0x54/0x6c
kernel:  [sys_close+84/108] sys_close+0x54/0x6c
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: Code: 0f b7 41 20 25 00 f0 ff ff 66 3d 00 40 75 54 b8 a4 06 29 c0 
-----------------------------------------

	If you think the driver is at fault, please tell me and I'll
forward that to the prism54 guys. If you need more info, just yell at
me.

	Thanks...

	Jean

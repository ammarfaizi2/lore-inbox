Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUDSFAJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 01:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbUDSFAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 01:00:09 -0400
Received: from ns1.server262.com ([64.14.68.15]:36011 "HELO server262.com")
	by vger.kernel.org with SMTP id S262434AbUDSFAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 01:00:02 -0400
Date: Mon, 19 Apr 2004 01:00:01 -0400
From: Adam Goode <adam@evdebs.org>
To: linux-kernel@vger.kernel.org
Subject: ifplugd/e1000 oops
Message-ID: <20040419050001.GE4288@evdebs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using ifplugd to monitor the link beat and automatically bring up
or down the network interfaces on my laptop.

When I unplugged my cable today, I got an oops. When I plugged it back
in, nothing happened. (Normally it should beep and bring the interface
back up.) When I removed and inserted the e1000 module, I got a freeze.



Thanks,

Adam




e1000: eth0 NIC Link is Down
Unable to handle kernel paging request at virtual address 00050052
 printing eip:
c02923c4
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c02923c4>]    Tainted: PF
EFLAGS: 00210202   (2.6.6-rc1)
EIP is at rtnetlink_fill_ifinfo+0x284/0x450
eax: 00050046   ebx: db2ee098   ecx: 00000ee0   edx: db2ee0a0
esi: dee2f000   edi: db2ee090   ebp: 00000000   esp: d6f56e90
ds: 007b   es: 007b   ss: 0068
Process ifplugd (pid: 3549, threadinfo=d6f56000 task=cce1b3b0)
Stack: dee2f038 00000127 00000ee0 db2ee000 caad9380 0000003f caad9380 ffffffff
       00000011 dee2f000 c0292828 00000000 00000000 ffffffff c03759a0 dee2f000
       00000006 d6f56000 c0292cd5 c0128278 dee2f000 000152cd c0375840 c028c796
Call Trace:
 [<c0292828>] rtmsg_ifinfo+0x48/0xc0
 [<c0292cd5>] rtnetlink_event+0x25/0x4b
 [<c0128278>] notifier_call_chain+0x18/0x40
 [<c028c796>] netdev_wait_allrefs+0xc6/0x110
 [<c021053a>] class_device_del+0x8a/0xb0
 [<c028c8eb>] netdev_run_todo+0x10b/0x200
 [<c028bd2e>] dev_ifsioc+0x1e/0x3e0
 [<c028c208>] dev_ioctl+0x118/0x2d0
 [<c02c3e29>] inet_ioctl+0xb9/0xd0
 [<c0283c4e>] sock_ioctl+0xee/0x280
 [<c015efc6>] sys_ioctl+0xf6/0x240
 [<c014dd7f>] filp_close+0x4f/0x80
 [<c0105f2b>] syscall_call+0x7/0xb

Code: 8b 40 0c 31 db ba ff ff ff ff 89 d1 83 c0 08 89 c7 89 44 24
 <6>Intel(R) PRO/1000 Network Driver - version 5.2.39-k2
Copyright (c) 1999-2004 Intel Corporation.
PCI: Found IRQ 5 for device 0000:02:01.0
SysRq : Resetting


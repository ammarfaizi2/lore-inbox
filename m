Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVAVXgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVAVXgv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 18:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVAVXgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 18:36:51 -0500
Received: from s2.home.ro ([193.231.236.41]:45524 "EHLO s2.home.ro")
	by vger.kernel.org with ESMTP id S261161AbVAVXgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 18:36:43 -0500
Subject: kernel oops!
From: ierdnah <ierdnah@go.ro>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 23 Jan 2005 01:36:50 +0200
Message-Id: <1106437010.32072.0.camel@ierdnac>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jan 22 13:27:59 warsheep Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jan 22 13:27:59 warsheep printing eip:
Jan 22 13:27:59 warsheep 00000000
Jan 22 13:27:59 warsheep *pgd = cde9ddb400000000
Jan 22 13:27:59 warsheep *pmd = cde9ddb400000000
Jan 22 13:27:59 warsheep Oops: 0000 [#1]
Jan 22 13:27:59 warsheep SMP
Jan 22 13:27:59 warsheep CPU:    0
Jan 22 13:27:59 warsheep EIP:    0060:[<00000000>]    Not tainted VLI
Jan 22 13:27:59 warsheep EFLAGS: 00010282   (2.6.10-hardened-r2-warsheep62)
Jan 22 13:27:59 warsheep EIP is at 0x0
Jan 22 13:27:59 warsheep eax: 00000000   ebx: de455000   ecx: c02c60e0   edx: c6b41000
Jan 22 13:27:59 warsheep esi: de455000   edi: 00000000   ebp: dd0a2680   esp: cde9de9c
Jan 22 13:27:59 warsheep ds: 007b   es: 007b   ss: 0068
Jan 22 13:27:59 warsheep Process pptpctrl (pid: 16689, threadinfo=cde9c000 task=d112ca20)
Jan 22 13:27:59 warsheep Stack: c02c97bc c6b41000 00000000 c02c895c de455000 04949168 c03d0106 de455000
Jan 22 13:27:59 warsheep de45500c dd0a2680 00000000 c02c4141 de455000 dd0a2680 00000000 c01c7d49
Jan 22 13:27:59 warsheep dd0a2680 00000020 00000005 00000005 c01da72f dd0a2680 00000000 00000000
Jan 22 13:27:59 warsheep Call Trace:
Jan 22 13:27:59 warsheep [<c02c97bc>] pty_chars_in_buffer+0x2c/0x50
Jan 22 13:27:59 warsheep [<c02c895c>] normal_poll+0xfc/0x16b
Jan 22 13:27:59 warsheep [<c03d0106>] schedule_timeout+0x76/0xc0
Jan 22 13:27:59 warsheep [<c02c4141>] tty_poll+0xa1/0xc0
Jan 22 13:27:59 warsheep [<c01c7d49>] fget+0x49/0x60
Jan 22 13:27:59 warsheep [<c01da72f>] do_select+0x26f/0x2e0
Jan 22 13:27:59 warsheep [<c01da2f0>] __pollwait+0x0/0xd0
Jan 22 13:27:59 warsheep [<c01daabb>] sys_select+0x2db/0x4f0
Jan 22 13:27:59 warsheep [<c0173049>] sysenter_past_esp+0x52/0x79
Jan 22 13:27:59 warsheep Code:  Bad EIP value.



The oops ocures only when the kernel is build with SMP and HT support, in UP mode the oops doesn't occur!
I have a 2.6.10 kernel with SMP and HT compiled kernel, I have a P4 3GHz with HT
a have a VPN server with pppd and pptpd(poptop) and and average of 130
simultanious connections, the oops doesn't occur at a particular number
of simulationus VPN connection.I can build a kernel with debugging enabled or something to help to track th
source of the problem. Please CC as I am not subscribed to this mailing list.

-- 
ierdnah <ierdnah@go.ro>


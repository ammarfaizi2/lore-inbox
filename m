Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271764AbTGRPGk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271806AbTGRPFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:05:06 -0400
Received: from 157.Red-80-32-159.pooles.rima-tde.net ([80.32.159.157]:41223
	"EHLO oxo") by vger.kernel.org with ESMTP id S271778AbTGROj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:39:58 -0400
Message-ID: <3F1808AB.2040408@iquis.com>
Date: Fri, 18 Jul 2003 16:48:11 +0200
From: Juan Pedro Paredes <juampe@iquis.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; es-AR; rv:1.4b) Gecko/20030507
X-Accept-Language: es, en-us
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_oxo-11997-1058540011-0001-2"
To: kernel <linux-kernel@vger.kernel.org>
Subject: [BUG REPORT 2.6.0-test1]  airo & workqueue
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_oxo-11997-1058540011-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--=_oxo-11997-1058540011-0001-2
Content-Type: text/plain; name=workqueue; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="workqueue"

Fri Jul 18 16:33:10 CEST 2003
airo:  Probing for PCI adapters
airo:  Finished probing for PCI adapters
airo: MAC enabled eth1 0:7:eb:31:1:e6
eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
------------[ cut here ]------------
kernel BUG at kernel/workqueue.c:77!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c012f0bd>]    Not tainted
EFLAGS: 00010213
EIP is at queue_work+0x6d/0x80
eax: 00000000   ebx: dcad037c   ecx: dcad2bc8   edx: 00000000
esi: dcad2bcc   edi: dffd0c20   ebp: dca3fce0   esp: dca3fcd4
ds: 007b   es: 007b   ss: 0068
Process ifconfig (pid: 424, threadinfo=dca3e000 task=dca2d9c0)
Stack: dcad037c dcad0220 00000000 dca3fd30 e097f85c c0339b81 df7479a0 00000001
       00000000 dffb4e20 dca3fd24 c0348596 df7479a0 c03398b8 00000000 00000000
       00000000 df7479a0 df2bd4c0 dca3fe2c dca3fd30 dcad0220 04000001 dca3fdbc
Call Trace:
 [<e097f85c>] airo_read_mic+0x8c/0x90 [airo]
 [<c0339b81>] __kfree_skb+0x81/0x110
 [<c0348596>] netlink_broadcast+0x156/0x280
 [<c03398b8>] alloc_skb+0x48/0xf0
 [<e09800a0>] airo_interrupt+0x840/0x8e0 [airo]
 [<e098099d>] issuecommand+0x6d/0x90 [airo]
 [<c011e5c6>] scheduler_tick+0x116/0x300
 [<c0128c76>] update_process_times+0x46/0x50
 [<c0128ae6>] update_wall_time+0x16/0x40
 [<c0128f00>] do_timer+0xe0/0xf0
 [<c010d20b>] handle_IRQ_event+0x3b/0x70
 [<c010d4fe>] do_IRQ+0x8e/0x120
 [<c010ba7c>] common_interrupt+0x18/0x20
 [<e098019e>] IN4500+0x1e/0x40 [airo]
 [<e0980976>] issuecommand+0x46/0x90 [airo]
 [<e098023c>] enable_MAC+0x7c/0xb0 [airo]
 [<e097e660>] airo_open+0x50/0x80 [airo]
 [<c037d3fc>] fib_inetaddr_event+0x4c/0x80
 [<c033d74c>] dev_open+0x7c/0x90
 [<c033ec68>] dev_change_flags+0x58/0x130
 [<c0375d43>] devinet_ioctl+0x2a3/0x660
 [<c03782c0>] inet_ioctl+0xc0/0x110
 [<c0336834>] sock_ioctl+0xc4/0x270
 [<c0165881>] sys_ioctl+0xb1/0x230
 [<c010b10f>] syscall_call+0x7/0xb

Code: 0f 0b 4d 00 0b f5 3c c0 eb b2 89 f6 8d bc 27 00 00 00 00 55
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing


--=_oxo-11997-1058540011-0001-2--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUBJXMY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 18:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUBJXMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 18:12:24 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:32529 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S261928AbUBJXMW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 18:12:22 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: selinux related oops on 2.6.3rc1+bk
Date: Wed, 11 Feb 2004 00:12:18 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402110012.18473.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.6.3rc1+bunch of patches from bitkeeper tree (so it's almost rc2)

I have selinux compiled in but not using it there. It's Dual PIII 1GHz 
machine.

Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01b07f0>]    Not tainted
EFLAGS: 00010286
EIP is at selinux_socket_sock_rcv_skb+0x70/0x220
eax: f64f27c0   ebx: f736c000   ecx: f736c000   edx: f64f27cc
esi: 00000000   edi: f64f27c0   ebp: c2ba5d80   esp: c2ba5d1c
ds: 007b   es: 007b   ss: 0068
Process exim (pid: 31250, threadinfo=c2ba4000 task=e324ace0)
Stack: f736c000 00000020 f58de844 c02608ce f58de844 00000020 00000000 f64f27cc
       f64f27c0 00000000 c2ba5d88 00000000 00000000 0cc6f5c3 06c6f5c3 00000020
       c2ba5d80 c029b0cb df9cdb80 00000000 1254ea0c 00001254 00000002 cb204000
Call Trace:
 [<c02608ce>] skb_checksum+0x4e/0x2c0
 [<c029b0cb>] tcp_v4_checksum_init+0x9b/0x160
 [<c029b75d>] tcp_v4_rcv+0x49d/0x750
 [<f8e74035>] ipt_hook+0x35/0x40 [iptable_filter]
 [<c027f005>] ip_local_deliver_finish+0xd5/0x200
 [<c027ef30>] ip_local_deliver_finish+0x0/0x200
 [<c026f525>] nf_hook_slow+0xd5/0x120
 [<c027ef30>] ip_local_deliver_finish+0x0/0x200
 [<c027ea12>] ip_local_deliver+0x252/0x270
 [<c027ef30>] ip_local_deliver_finish+0x0/0x200
 [<c027f369>] ip_rcv_finish+0x239/0x2bc
 [<c026f525>] nf_hook_slow+0xd5/0x120
 [<c027f130>] ip_rcv_finish+0x0/0x2bc
 [<c027ee69>] ip_rcv+0x439/0x500
 [<c027f130>] ip_rcv_finish+0x0/0x2bc
 [<c02649c5>] netif_receive_skb+0x195/0x200
 [<c0264ab9>] process_backlog+0x89/0x120
 [<c0264be5>] net_rx_action+0x95/0x130
 [<c012a80b>] do_softirq+0xcb/0xd0
 [<c010dad5>] do_IRQ+0x105/0x130
 [<c010bda8>] common_interrupt+0x18/0x20

Code: 0f b7 46 18 83 f8 0f 0f 84 8c 01 00 00 83 f8 10 0f 84 69 01
 <0>Kernel panic: Fatal exception i38  4 131120   4732 203216 49392n0   96    
0   68 0  1872  971   7i90 36 64  0  0
nterrupt
In interrupt handler - not syncing

CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
# CONFIG_SECURITY_SELINUX_MLS is not set

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux

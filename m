Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270411AbTGNQ3q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270449AbTGNQ3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:29:46 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:37760 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S270411AbTGNQ3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:29:45 -0400
From: Nicolas <linux@1g6.biz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1 oops mm/slab.c:1631
Date: Mon, 14 Jul 2003 18:44:31 +0200
User-Agent: KMail/1.5
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307141844.31869.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

Always don't know exactly how to reproduce this oops,
it occurs randomsly...
I don't know if it is hardware related,
or if I am doing something nasty ... :(,
however never hanged on XP.

Regards

Nicolas.


Jul 14 18:35:05 hal9003 kernel: ------------[ cut here ]------------
Jul 14 18:35:05 hal9003 kernel: kernel BUG at mm/slab.c:1631!
Jul 14 18:35:05 hal9003 kernel: invalid operand: 0000 [#1]
Jul 14 18:35:05 hal9003 kernel: CPU:    0
Jul 14 18:35:05 hal9003 kernel: EIP:    0060:[kmem_cache_free+662/752]    Not 
tainted
Jul 14 18:35:05 hal9003 kernel: EIP:    0060:[<c01361a5>]    Not tainted
Jul 14 18:35:05 hal9003 kernel: EFLAGS: 00010087
Jul 14 18:35:05 hal9003 kernel: EIP is at kmem_cache_free+0x296/0x2f0
Jul 14 18:35:05 hal9003 kernel: eax: c17668a8   ebx: 007668a8   ecx: f7ffd580   
edx: f7ffd580
Jul 14 18:35:05 hal9003 kernel: esi: 00001000   edi: ef5d1000   ebp: cc719f9c   
esp: cc719f74
Jul 14 18:35:05 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
Jul 14 18:35:05 hal9003 kernel: Process sh (pid: 21061, threadinfo=cc718000 
task=d3df5000)
Jul 14 18:35:05 hal9003 kernel: Stack: fffffff4 00000003 00000101 00000001 
c01477ca f7ffb794 00000296 00000003
Jul 14 18:35:05 hal9003 kernel:        e0295708 ef5d1000 cc719fbc c01477ca 
f7ffd580 ef5d1000 00000000 0810d848
Jul 14 18:35:05 hal9003 kernel:        0810d7a0 4003de9f cc718000 c0108fe3 
0810d848 00000000 00000000 0810d7a0
Jul 14 18:35:05 hal9003 kernel: Call Trace:
Jul 14 18:35:05 hal9003 kernel:  [sys_open+120/133] sys_open+0x78/0x85
Jul 14 18:35:05 hal9003 kernel:  [<c01477ca>] sys_open+0x78/0x85
Jul 14 18:35:05 hal9003 kernel:  [sys_open+120/133] sys_open+0x78/0x85
Jul 14 18:35:05 hal9003 kernel:  [<c01477ca>] sys_open+0x78/0x85
Jul 14 18:35:05 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 14 18:35:05 hal9003 kernel:  [<c0108fe3>] syscall_call+0x7/0xb
Jul 14 18:35:05 hal9003 kernel:
Jul 14 18:35:05 hal9003 kernel: Code: 0f 0b 5f 06 d3 fa 2a c0 e9 cc fd ff ff 
89 7c 24 04 c7 04 24


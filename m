Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271511AbTGQRQa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 13:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271514AbTGQRQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 13:16:30 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:15493 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S271511AbTGQRQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 13:16:26 -0400
From: Nicolas <linux@1g6.biz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: spinlock already locked oops net/unix/af_unix.c:1757
Date: Thu, 17 Jul 2003 19:31:19 +0200
User-Agent: KMail/1.5
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307171931.19434.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.6.0-test1,
At this time don't know how to reproduce.

Nicolas.


Jul 17 18:45:42 hal9003 kernel: net/unix/af_unix.c:1757: 
spin_lock(<NULL>:d2a56084) already locked by <NULL>/1079457668
Jul 17 18:45:42 hal9003 kernel:  printing eip:
Jul 17 18:45:42 hal9003 kernel: c02ee755
Jul 17 18:45:42 hal9003 kernel: Oops: 0000 [#1]
Jul 17 18:45:42 hal9003 kernel: CPU:    0
Jul 17 18:45:42 hal9003 kernel: EIP:    0060:[unix_ioctl+216/540]    Not 
tainted
Jul 17 18:45:42 hal9003 kernel: EIP:    0060:[<c02ee755>]    Not tainted
Jul 17 18:45:42 hal9003 kernel: EFLAGS: 00010202
Jul 17 18:45:42 hal9003 kernel: EIP is at unix_ioctl+0xd8/0x21c
Jul 17 18:45:42 hal9003 kernel: eax: 00000000   ebx: d2a56004   ecx: 00000001   
edx: 00000001
Jul 17 18:45:42 hal9003 kernel: esi: bfffe16c   edi: 00000000   ebp: d31a1f70   
esp: d31a1f48
Jul 17 18:45:42 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
Jul 17 18:45:42 hal9003 kernel: Process kdeinit (pid: 8691, 
threadinfo=d31a0000 task=d34bb000)
Jul 17 18:45:42 hal9003 kernel: Stack: c02fb0a0 c0330bee 000006dd 00000000 
d2a56084 00000000 40573784 0000541b
Jul 17 18:45:42 hal9003 kernel:        0000541b ffffffe7 d31a1f90 c0281d3e 
d3600004 0000541b bfffe16c 0000541b
Jul 17 18:45:42 hal9003 kernel:        d3401004 ffffffe7 d31a1fbc c01807f8 
d3600040 d3401004 0000541b bfffe16c
Jul 17 18:45:42 hal9003 kernel: Call Trace:
Jul 17 18:45:42 hal9003 kernel:  [sock_ioctl+167/620] sock_ioctl+0xa7/0x26c
Jul 17 18:45:42 hal9003 kernel:  [<c0281d3e>] sock_ioctl+0xa7/0x26c
Jul 17 18:45:42 hal9003 kernel:  [sys_ioctl+172/536] sys_ioctl+0xac/0x218
Jul 17 18:45:42 hal9003 kernel:  [<c01807f8>] sys_ioctl+0xac/0x218
Jul 17 18:45:42 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 17 18:45:42 hal9003 kernel:  [<c0109ddb>] syscall_call+0x7/0xb
Jul 17 18:45:42 hal9003 kernel:
Jul 17 18:45:42 hal9003 kernel: Code: 8b 7a 64 81 bb 80 00 00 00 3c 4b 24 1d 
74 26 8d 83 80 00 00


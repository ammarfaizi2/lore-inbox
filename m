Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbTEAUVT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 16:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbTEAUVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 16:21:19 -0400
Received: from customer-mpls-23.cpinternet.com ([209.240.253.23]:19239 "EHLO
	mharnois.mdharnois.net") by vger.kernel.org with ESMTP
	id S262341AbTEAUVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 16:21:18 -0400
Subject: kernel BUG at net/socket.c:147
From: "Michael D. Harnois" <mharnois@cpinternet.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1051821220.4440.1.camel@mharnois.mdharnois.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 01 May 2003 15:33:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is with 2.5.68-bk11 but happened also with bk10.

May  1 15:30:20 mharnois kernel: ------------[ cut here ]------------
May  1 15:30:20 mharnois kernel: kernel BUG at net/socket.c:147!
May  1 15:30:20 mharnois kernel: invalid operand: 0000 [#1]
May  1 15:30:20 mharnois kernel: CPU:    0
May  1 15:30:20 mharnois kernel: EIP:   
0060:[net_family_get+110/128]    Tainted: PF 
May  1 15:30:20 mharnois kernel: EFLAGS: 00010282
May  1 15:30:20 mharnois kernel: eax: 00000021   ebx: 00000001   ecx:
00000002   edx: 00000001
May  1 15:30:20 mharnois kernel: esi: 00000000   edi: 00000001   ebp:
00000000   esp: d3965e9c
May  1 15:30:20 mharnois kernel: ds: 007b   es: 007b   ss: 0068
May  1 15:30:20 mharnois kernel: Process vmnet-bridge (pid: 9886,
threadinfo=d3964000 task=d8173380)
May  1 15:30:20 mharnois kernel: Stack: c0300360 00000000 00000000
c0261489 00000000 c038c8b1 effb6084 c011c648 
May  1 15:30:20 mharnois kernel:        0000000a ec0d9c00 cf000400
d3964000 eb79ea00 00000000 d3965f5c f8e23594 
May  1 15:30:20 mharnois kernel:        00000000 00000020 00000001
00000000 fffffff4 eb79ea00 eb79eb58 f8e22e88 
May  1 15:30:20 mharnois kernel: Call Trace: [sk_alloc+41/208] 
[printk+280/384]  [__crc_pm_idle+5322517/8946372] 
[__crc_pm_idle+5320713/8946372]  [do_page_fault+572/1118] 
[__crc_pm_idle+5310266/8946372]  [dentry_open+511/560] 
[filp_open+104/112]  [sys_ioctl+256/656]  [do_page_fault+0/1118] 
[syscall_call+7/11] 
May  1 15:30:20 mharnois kernel: Code: 0f 0b 93 00 8d 4c 30 c0 eb d1 90
8d b4 26 00 00 00 00 83 ec 
May  1 15:30:20 mharnois kernel:  <6>note: vmnet-bridge[9886] exited
with preempt_count 2




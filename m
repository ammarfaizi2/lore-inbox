Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbUCDMTY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 07:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbUCDMTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 07:19:24 -0500
Received: from www.mymail.ro ([193.231.233.154]:9424 "HELO mail.mymail.ro")
	by vger.kernel.org with SMTP id S261860AbUCDMTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 07:19:21 -0500
Message-ID: <40471EA9.6000701@mymail.ro>
Date: Thu, 04 Mar 2004 14:18:49 +0200
From: DragonK <dragonk@mymail.ro>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.3 Oops
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-BannersAdded2: 2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, I've done a brief search on the list's archive and I haven't 
found anything
that looks like this, sorry if it has been posted before:

While running Linux Test Project (ltp-20040206) on a 2.6.3 kernel (with 
Suse 9.0)
(Linux frozen 2.6.3 #4 Thu Feb 26 15:02:20 EET 2004 i686 athlon i386 
GNU/Linux),
I got the following OOPS message, without leading to system crash:

Mar  4 14:02:55 frozen kernel: Unable to handle kernel paging request at 
virtual address fffffff2
Mar  4 14:02:55 frozen kernel:  printing eip:
Mar  4 14:02:55 frozen kernel: c01edbd2
Mar  4 14:02:55 frozen kernel: *pde = 00002067
Mar  4 14:02:55 frozen kernel: *pte = 00000000
Mar  4 14:02:55 frozen kernel: Oops: 0002 [#1]
Mar  4 14:02:55 frozen kernel: CPU:    0
Mar  4 14:02:55 frozen kernel: EIP:    
0060:[strncpy_from_user+66/112]    Tainted: P  
Mar  4 14:02:55 frozen kernel: EIP:    0060:[<c01edbd2>]    Tainted: P  
Mar  4 14:02:55 frozen kernel: EFLAGS: 00010206
Mar  4 14:02:55 frozen kernel: EIP is at strncpy_from_user+0x42/0x70
Mar  4 14:02:55 frozen kernel: eax: d175a000   ebx: fffffff2   ecx: 
00001000   edx: 00001000
Mar  4 14:02:55 frozen kernel: esi: 41e20a66   edi: fffffff2   ebp: 
00000000   esp: d175bedc
Mar  4 14:02:55 frozen kernel: ds: 007b   es: 007b   ss: 0068
Mar  4 14:02:55 frozen kernel: Process crash02 (pid: 29476, 
threadinfo=d175a000 task=ddaba100)
Mar  4 14:02:55 frozen kernel: Stack: d175bf7c 00001000 fffffff2 
41e20a65 c0168321 fffffff2 41e20a65 00001000
Mar  4 14:02:55 frozen kernel:        d175bf7c d175bf38 f7a17e18 
00000000 c01698ef 41e20a65 c01698ef d175bf7c
Mar  4 14:02:55 frozen kernel:        d175bf38 f7a17e18 d175a000 
c01643ac d175a000 c01581ed 00000008 00000000
Mar  4 14:02:55 frozen kernel: Call Trace:
Mar  4 14:02:55 frozen kernel:  [getname+145/208] getname+0x91/0xd0
Mar  4 14:02:55 frozen kernel:  [<c0168321>] getname+0x91/0xd0
Mar  4 14:02:55 frozen kernel:  [__user_walk+31/128] __user_walk+0x1f/0x80
Mar  4 14:02:55 frozen kernel:  [<c01698ef>] __user_walk+0x1f/0x80
Mar  4 14:02:55 frozen kernel:  [__user_walk+31/128] __user_walk+0x1f/0x80
Mar  4 14:02:55 frozen kernel:  [<c01698ef>] __user_walk+0x1f/0x80
Mar  4 14:02:55 frozen kernel:  [vfs_lstat+28/112] vfs_lstat+0x1c/0x70
Mar  4 14:02:55 frozen kernel:  [<c01643ac>] vfs_lstat+0x1c/0x70
Mar  4 14:02:55 frozen kernel:  [sys_statfs+61/240] sys_statfs+0x3d/0xf0
Mar  4 14:02:55 frozen kernel:  [<c01581ed>] sys_statfs+0x3d/0xf0
Mar  4 14:02:55 frozen kernel:  [do_page_fault+0/1411] 
do_page_fault+0x0/0x583
Mar  4 14:02:55 frozen kernel:  [<c011eac0>] do_page_fault+0x0/0x583
Mar  4 14:02:55 frozen kernel:  [sys_lstat+24/64] sys_lstat+0x18/0x40
Mar  4 14:02:55 frozen kernel:  [<c0164658>] sys_lstat+0x18/0x40
Mar  4 14:02:55 frozen kernel:  [sys_alarm+63/96] sys_alarm+0x3f/0x60
Mar  4 14:02:55 frozen kernel:  [<c012ccbf>] sys_alarm+0x3f/0x60
Mar  4 14:02:55 frozen kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar  4 14:02:55 frozen kernel:  [<c010b49b>] syscall_call+0x7/0xb
Mar  4 14:02:55 frozen kernel:
Mar  4 14:02:55 frozen kernel: Code: aa 84 c0 74 03 49 75 f7 29 ca 89 d3 
89 d8 8b 74 24 04 8b 7c



---------------------------------------------------------------
Martisoare virtuale prin http://felicitari.acasa.ro


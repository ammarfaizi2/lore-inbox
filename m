Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbTDSSkD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 14:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263428AbTDSSkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 14:40:03 -0400
Received: from smtp.terra.es ([213.4.129.129]:63793 "EHLO tsmtp9.mail.isp")
	by vger.kernel.org with ESMTP id S263427AbTDSSkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 14:40:02 -0400
Date: Sat, 19 Apr 2003 20:28:02 +0200
From: Arador <diegocg@teleline.es>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm4
Message-Id: <20030419202802.15d79547.diegocg@teleline.es>
In-Reply-To: <20030418014536.79d16076.akpm@digeo.com>
References: <20030418014536.79d16076.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Apr 2003 01:45:36 -0700
Andrew Morton <akpm@digeo.com> wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.67/2.5.67-mm4/


I got this oops while loading xchat2:
Unable to handle kernel paging request at virtual address 6b6b6bf7
 printing eip:
c0107643
*pde = 00000000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<c0107643>]    Not tainted VLI
EFLAGS: 00210202
EIP is at release_thread+0x13/0x60
eax: 6b6b6b6b   ebx: ce9a2060   ecx: 00000000   edx: 00200296
esi: c2a90000   edi: ce9a265c   ebp: c2a91efc   esp: c2a91ee8
ds: 007b   es: 007b   ss: 0068
Process xchat (pid: 1389, threadinfo=c2a90000 task=ca36b310)
Stack: cffe77e8 c03573a0 ce9a2060 c2a90000 ce9a2060 c2a91f1c c012400a ce9a2060 
       00000000 c68a7df4 ce9a2060 00000586 bfffdc14 c2a91f48 c0125fe0 ce9a2060 
       fffffe00 ca36b310 00000000 c03571c0 c2a9007b ce9a2104 ce9a2060 ca36b310 
Call Trace:
 [<c012400a>] release_task+0x1ba/0x270
 [<c0125fe0>] wait_task_zombie+0x170/0x1d0
 [<c01264f7>] sys_wait4+0x267/0x2b0
 [<c0131011>] sys_rt_sigaction+0xd1/0x100
 [<c011d590>] default_wake_function+0x0/0x20
 [<c011d590>] default_wake_function+0x0/0x20
 [<c0109a5f>] syscall_call+0x7/0xb

Code: 66 89 ba f4 02 00 00 5f 5d c3 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 55 89 e5 83 ec 14 89 5d fc 8b 5d 08 8b 43 5c 85 c0 74 0a <8b> 90 8c 00 00 00 85 d2 75 13 89 5d 08 8b 5d fc 89 ec 5d e9 f5 

Those where the last steps of xchat it seems:
Apr 19 18:08:18 estel modprobe: FATAL: Module ipv6 not found. 
Apr 19 18:08:18 estel last message repeated 3 times
Apr 19 18:08:20 estel identd[1404]: started
Apr 19 18:08:21 estel kernel: Unable to handle kernel paging request at virtual 
address 6b6b6bf7

I can't reproduce it again...machine is p3 smp

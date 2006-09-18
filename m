Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWIRVFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWIRVFN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 17:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWIRVFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 17:05:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:40093 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751092AbWIRVFM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 17:05:12 -0400
Subject: Re: [ckrm-tech] [patch 0/5]-Containers: Introduction
From: Badari Pulavarty <pbadari@gmail.com>
To: rohitseth@google.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       devel@openvz.org, CKRM-Tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <1158284264.5408.144.camel@galaxy.corp.google.com>
References: <1158284264.5408.144.camel@galaxy.corp.google.com>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 14:08:42 -0700
Message-Id: <1158613722.18300.3.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 18:37 -0700, Rohit Seth wrote:
> Containers:
> 

I was just trying out your patches and ran into
following Oops.

(Created a container, assigned a pid (shell) to it,
set page limit and started a kernel compile in the shell).

Thanks,
Badari

elm3b29 login: ----------- [cut here ] --------- [please bite here ]
---------
Kernel BUG at include/linux/list.h:173
invalid opcode: 0000 [1] SMP
last sysfs file: /devices/pci0000:00/0000:00:06.0/irq
CPU 3
Modules linked in: acpi_cpufreq ipv6 thermal processor fan button
battery ac dm_mod floppy parport_pc lp parport
Pid: 4780, comm: sh Not tainted 2.6.18-rc6-mm2 #3
RIP: 0010:[<ffffffff802807b1>]  [<ffffffff802807b1>]
container_remove_task+0xd1/0x150
RSP: 0018:ffff8101de5d9e98  EFLAGS: 00010283
RAX: ffff8101de410ea8 RBX: ffff81019f624450 RCX: ffff8101de410ea8
RDX: ffff8101de5f0e68 RSI: 0000000000000000 RDI: ffff8101de410dac
RBP: ffff8101de5d9eb8 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000012ac R11: 0000000000000246 R12: ffff8101de4107a0
R13: ffff81019f6244b8 R14: ffff8101de410dac R15: ffff8101de4108c8
FS:  00002b1d43e3fae0(0000) GS:ffff8101c00c9f40(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000424613 CR3: 0000000000201000 CR4: 00000000000006e0
Process sh (pid: 4780, threadinfo ffff8101de5d8000, task
ffff8101de4107a0)
Stack:  ffff8101de5d9ee8 ffff8101de4107a0 0000000000000010
ffff8101de410850
 ffff8101de5d9f38 ffffffff802337d9 ffff8101de5d9f08 ffff8101de5d9ee8
 ffff8101de410938 ffff8101dd91a680 ffff8101de5d9ee8 ffff8101de5d9ee8
Call Trace:
 [<ffffffff802337d9>] do_exit+0x8d9/0x900
 [<ffffffff80233898>] do_group_exit+0x98/0xa0
DWARF2 unwinder stuck at do_group_exit+0x98/0xa0

Leftover inexact backtrace:

 [<ffffffff802338b2>] sys_exit_group+0x12/0x20
 [<ffffffff80209c4e>] system_call+0x7e/0x83


Code: 0f 0b 68 d1 f8 50 80 c2 ad 00 48 89 50 08 48 89 02 48 c7 41
RIP  [<ffffffff802807b1>] container_remove_task+0xd1/0x150
 RSP <ffff8101de5d9e98>
 <1>Fixing recursive fault but reboot is needed!





Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262570AbVCSNy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbVCSNy5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVCSNyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:54:31 -0500
Received: from outbound.mailhop.org ([63.208.196.171]:33299 "EHLO
	outbound.mailhop.org") by vger.kernel.org with ESMTP
	id S262590AbVCSNvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:51:12 -0500
Subject: Kernel BUG at rmap:482
From: hib2743 <hib2743@log1.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 19 Mar 2005 14:51:04 +0100
Message-Id: <1111240264.31141.13.camel@mxmail.log1.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-Mail-Handler: MailHop Outbound by DynDNS.org
X-Originating-IP: 151.37.149.188
X-Report-Abuse-To: abuse@dyndns.org (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: comp112
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,
 I have seen discussion about this in recent months on the list, and
unfortunately I am experiencing the same problem myself now on a new
machine. I have run memtest86 for some hours and there seems to be no
problem. The machine has 1GB DDR PC3200 RAM/AMD Athlon(tm) 64 Processor
3500+/ASUS A8V motherboard/120GB Seagate SATA HDD. If you have a patch
you would like me to try I am willing to have a go, this is a new
machine which I waiting to deploy, so there is no production data on it
at all yet. I can reproduce the problem fairly regularly, just set the
machine to compile something big like glibc, and I get it within an hour
usually...

Thanks a lot!
Regards,


Kernel: Linux newlog 2.6.11.4 #1 Sat Mar 19 15:10:16 CET 2005 x86_64 AMD
Athlon(tm) 64 Processor 3500+ AuthenticAMD GNU/Linux

Report in log:
Kernel BUG at rmap:482
invalid operand: 0000 [1] 
CPU 0 
Modules linked in: usb_storage ohci_hcd uhci_hcd ehci_hcd
Pid: 16405, comm: sh Not tainted 2.6.11.4
RIP: 0010:[<ffffffff80162e25>] <ffffffff80162e25>{page_remove_rmap+37}
RSP: 0018:ffff810035fa3de0  EFLAGS: 00010296
RAX: 00000000ff000000 RBX: 0000000000006000 RCX: ffffffff804af3a0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff810001a7a928
RBP: ffff81003622f030 R08: ffff810001a7a928 R09: ffff810035fa3f00
R10: ffff81003196d7b8 R11: ffff81003196d7a8 R12: 0000000000041000
R13: 0000000000000020 R14: 0000000000000000 R15: 0000000000600000
FS:  00002aaaaaff36d0(0000) GS:ffffffff804eeb00(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000006367d8 CR3: 000000002ecb8000 CR4: 00000000000006e0
Process sh (pid: 16405, threadinfo ffff810035fa2000, task
ffff81003f3cf680)
Stack: ffffffff8015bc86 0000000000000001 ffff810001a7a928
0000000000640fff 
       00000000405eb000 0000000000641000 ffff810035223018
ffff810035222000 
       000000008015f21c ffff81002ecb8000 
Call Trace:<ffffffff8015bc86>{unmap_vmas+1542}
<ffffffff8015fe51>{do_munmap+465} 
       <ffffffff80160b6f>{sys_brk+143} <ffffffff8010e1fa>{system_call
+126} 
       

Code: 0f 0b 95 5e 39 80 ff ff ff ff e2 01 48 c7 c6 ff ff ff ff bf 
RIP <ffffffff80162e25>{page_remove_rmap+37} RSP <ffff810035fa3de0>
 




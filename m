Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbVHDUti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbVHDUti (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVHDUru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:47:50 -0400
Received: from news.cistron.nl ([62.216.30.38]:56732 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262680AbVHDUrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:47:24 -0400
From: dth@picard.cistron.nl (Danny ter Haar)
Subject: 2.6.13-rc5-git2 does not boot on (my) amd64
Date: Thu, 4 Aug 2005 20:47:21 +0000 (UTC)
Organization: Cistron
Message-ID: <dctuso$tl$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1123188441 949 62.216.30.70 (4 Aug 2005 20:47:21 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@picard.cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is as far as it comes:


Freeing unused kernel memory: 248k freed
VM: killing process hotplug
VM: killing process hotplug
VM: killing process hotplug
VM: killing process hotplug
Unable to handle kernel paging request at fffffff28017b5be RIP:
[<fffffff28017b5be>]
PGD 103027 PUD 0
Oops: 0010 [1]
CPU 0
Modules linked in:
Pid: 1, comm: init Not tainted 2.6.13-rc5-git2
RIP: 0010:[<fffffff28017b5be>] [<fffffff28017b5be>]
RSP: 0000:ffff81007ffa3d38  EFLAGS: 00010296
RAX: 0000000000000000 RBX: ffff81007f450005 RCX: 0000000000000013
RDX: ffff81007ffe0ec0 RSI: ffff81007f42e560 RDI: ffff81007ffa3d48
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffff81007f463a90 R11: ffff81007f454130 R12: ffff81007fc639e8
R13: ffff81007ffa3ed8 R14: fffffff27f450000 R15: 0000000000000310
FS:  00002aaaaae00640(0000) GS:ffffffff80485800(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: fffffff28017b5be CR3: 000000007fc77000 CR4: 00000000000006e0
Process init (pid: 1, threadinfo ffff81007ffa2000, task ffff81007ffa14a0)
Stack: 000000030029ab98 ffff81007f450001 ffff81007ffe0ec0 ffff81007f42e560
       0000000000000001 ffff81007ffe0ec0 ffff81007f450000 ffff8100033a8900
       ffff81007ffa3ed8 ffff81007f450000
Call Trace:<ffffffff8017bff7>{link_path_walk+135} <ffffffff8016bd2a>{get_unused_ fd+90}
       <ffffffff8017c57c>{path_lookup+380} <ffffffff8017d7ed>{open_namei+205}
       <ffffffff8015f68b>{__vma_link+75} <ffffffff8016cb1d>{filp_open+45}
       <ffffffff8016bd2a>{get_unused_fd+90} <ffffffff8016cbd4>{sys_open+84}
       <ffffffff8010d91e>{system_call+126}

Code:  Bad RIP value.
RIP [<fffffff28017b5be>] RSP <ffff81007ffa3d38>
CR2: fffffff28017b5be
 <0>Kernel panic - not syncing: Attempted to kill init!
 <0>Rebooting in 30 seconds..

2.6.13-rc5 (vanilla) does work/boot but gave me scsi error after 24+ hours 
(log/config file is @ http://newsgate.newsserver.nl/kernel  )

Danny


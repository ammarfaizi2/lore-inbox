Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268726AbUJMPFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268726AbUJMPFc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 11:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268778AbUJMPFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 11:05:32 -0400
Received: from bos-gate3.raytheon.com ([199.46.198.232]:53450 "EHLO
	bos-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S268726AbUJMPFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 11:05:14 -0400
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T9
To: Ingo Molnar <mingo@elte.hu>
Cc: Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF6FC0BAD1.621FA144-ON86256F2C.0050C870@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Wed, 13 Oct 2004 10:03:05 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/13/2004 10:03:07 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i've uploaded the -T9 VP patch:
>
>
http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T9


I may have been lucky with -T8 where it made it through a complete boot and
shutdown cycle (spewing lots of messages), but -T9 appeared to start OK but
died
with the following messages displayed. [my back was turned, so I am not
sure the
step in the init sequence that was active, trying again...]

[<c0114b60>] mcount+0x14/0x18
[<c011d0a1>] __wake_up_common+0x51/0x80
[<c011d113>] __wake_up+0x43/0x60
[<c0313d54>] __up_wakeup+0x8/0xc
[<c0139685>] .text.lock.mutex+0x2d/0x148
[<c01c50cb>] avc_has_perm_noaudit+0xab/0x1d0
[<c01c5204>] avc_has_perm+0x14/0x80
[<c01c67c4>] inode_has_perm+0x64/0x90
[<c0114b60>] mcount+0x14/0x18
[<c01c5233>] avc_has_perm+0x43/0x80
[<c01c97f7>] file_map_prot_check+0x117/0x120
[<c0114b60>] mcount+0x14/0x18
[<c01c67c4>] inode_has_perm+0x64/0x90
[<c01c8a6e>] selinux_inode_getattr+0x5e/0x70
[<c0114b60>] mcount+0x14/0x18
[<c01398ed>] __mcount+0x1d/0x30
[<c01c96ee>] file_map_prot_check+0xe/0x120
[<c0159635>] do_mmap_pgoff+0x205/0x790
[<c0114b60>] mcount+0x14/0x18
[<c01c97f7>] file_map_prot_check+0x117/0x120
[<c0159635>] do_mmap_pgoff+0x205/0x790
[<c0107b5b>] syscall_call+0x7/0xb
Code: 00 55 89 e5 83 ec 0c 89 5d f8 89 75 fc e8 6b f7 df ff c7 04 24 01 00
00 00
 89 c3 e8 e1 4d e2 ff be 00 e0 ff ff 21 e6 31 c0 86 03

Had to cycle power to get system to reboot; watching more closely this
time.
Of course, the second time it boots all the way but was spewing some (not a
lot)
of messages related to the network interface I have (8139too). I tried to
login
but the system hung before displaying anything interesting. Rebooted with
-T3
again to get some work done. Will send the boot messages separately.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>


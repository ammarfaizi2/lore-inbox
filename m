Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277085AbRJDCNr>; Wed, 3 Oct 2001 22:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277084AbRJDCNh>; Wed, 3 Oct 2001 22:13:37 -0400
Received: from cogito.cam.org ([198.168.100.2]:19781 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S277083AbRJDCNa>;
	Wed, 3 Oct 2001 22:13:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@CAM.ORG>
Organization: me
To: reiserfs-list@namesys.com
Subject: [BUG] opps in 2.4.11-pre2 + prempt patch
Date: Wed, 3 Oct 2001 19:03:29 -0400
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011003230330.508E91104F@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Does this point at anything?  This happened running dbench with 2.4.11-pre2 working
on a reiserfs on an LVM (1.01-rc2) volume.  The prempt patch is also applied.

Oct  3 17:41:56 oscar kernel:   printing eip:
Oct  3 17:41:56 oscar kernel: d680a49c
Oct  3 17:41:56 oscar kernel: Oops: 0000
Oct  3 17:41:56 oscar kernel: CPU:    0
Oct  3 17:41:56 oscar kernel: EIP:    0010:[softdog:__insmod_softdog_O/lib/modules/2.4.11-pre2/kernel/drivers/c+-4221796/96]    Tainted: P
Oct  3 17:41:56 oscar kernel: EFLAGS: 00010246
Oct  3 17:41:56 oscar kernel: eax: 00001fff   ebx: 00004c18   ecx: d36e8a00   edx: 00000000
Oct  3 17:41:56 oscar kernel: esi: 01044170   edi: 00002101   ebp: 00000000   esp: c2e55d4c
Oct  3 17:41:56 oscar kernel: ds: 0018   es: 0018   ss: 0018
Oct  3 17:41:56 oscar kernel: Process dbench (pid: 2102, stackpage=c2e55000)
Oct  3 17:41:56 oscar kernel: Stack: d36e8a00 d36e8b70 d36e8570 00e00000 00e00000 00000983 00000000 00000000
Oct  3 17:41:56 oscar kernel:        d6807650 c2e55daa c2e55dac 01042470 d36e8a00 00003a01 c7b340e0 00f43d00
Oct  3 17:41:56 oscar kernel:        00e00000 c02b1f08 d36e8c00 d36e8400 d36df000 01042470 00007a10 2101dc80
Oct  3 17:41:56 oscar kernel: Call Trace: [softdog:__insmod_softdog_O/lib/modules/2.4.11-pre2/kernel/drivers/c+-4233648/96] [softdog:__insmod_softdog_O/lib/modules/2.4.11-pre2/kernel/drivers/c+-4233435/96] [generic_make_request+300/316] [submit_bh+85/112] [write_locked_buffers+31/40]
Oct  3 17:41:56 oscar kernel:    [write_some_buffers+199/340] [balance_dirty+30/64] [__block_commit_write+163/192] [generic_commit_write+51/92] [reiserfs_commit_write+49/252] [reiserfs_get_block+0/3584]
Oct  3 17:41:56 oscar kernel:    [generic_file_write+1190/1452] [sys_write+142/196] [system_call+51/64]
Oct  3 17:41:56 oscar kernel:
Oct  3 17:41:56 oscar kernel: Code: 8b 0b eb 03 45 8b 09 39 d9 74 27 39 71 08 75 f4 66 39 79 0c

Ed Tomlinson

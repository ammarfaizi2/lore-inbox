Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264617AbSKVLtu>; Fri, 22 Nov 2002 06:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264625AbSKVLtu>; Fri, 22 Nov 2002 06:49:50 -0500
Received: from news.cistron.nl ([62.216.30.38]:26894 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S264617AbSKVLtt>;
	Fri, 22 Nov 2002 06:49:49 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: 2.5.48bk3: OOPS: Unable to handle kernel paging request
Date: Fri, 22 Nov 2002 11:56:58 +0000 (UTC)
Organization: Cistron
Message-ID: <arl62a$m5a$1@ncc1701.cistron.net>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1037966218 22698 62.216.29.67 (22 Nov 2002 11:56:58 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is still the same NNTP news server. I've loaded 2.5.48bk3,
since it died with 2.5.46bk3 during my vacation and crashes of
a few releases ago are probably not that interesting.


Unable to handle kernel paging request at virtual address 1a3e7d69
 printing eip:
c17d007f
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c17d007f>]    Not tainted
EFLAGS: 00010212
EIP is at 0xc17d007f
eax: c17d0069   ebx: f7d11cc8   ecx: f7692000   edx: f7693d2c
esi: f7693dcc   edi: 0039db67   ebp: f7693e0c   esp: f7693db8
ds: 0068   es: 0068   ss: 0068
Process innfeed (pid: 224, threadinfo=f7692000 task=f79c5940)
Stack: 02010010 c01dc170 f7693d2c f7692000 000003d0 f76975cc f7693dcc c013d580 
       f778fed0 f773d3a0 f7693e04 00000020 f773d3ec 00000020 f773d3a0 00000020 
       f778fee0 00000020 0043cf44 f7693e04 f7693e04 f778fed0 c013d698 f778fed0 
Call Trace:
 [<c01dc170>] blk_run_queues+0xb0/0xc0
 [<c013d580>] do_page_cache_readahead+0x158/0x178
 [<c013d698>] page_cache_readahead+0xf8/0x124
 [<c012f7ed>] do_generic_mapping_read+0x51/0x378
 [<c012fdcd>] __generic_file_aio_read+0x1b9/0x1d4
 [<c012fb54>] file_read_actor+0x0/0xc0
 [<c012feb3>] generic_file_read+0x7b/0x98
 [<c012d341>] handle_mm_fault+0x85/0x130
 [<c01144c0>] do_page_fault+0x0/0x434
 [<c010eaa2>] old_mmap+0xda/0x114
 [<c0143c72>] vfs_read+0xc6/0x17c
 [<c014400c>] sys_pread64+0x3c/0x50
 [<c0108b4b>] syscall_call+0x7/0xb

Code: 00 a8 00 7d c1 58 00 7d c1 30 ec 97 f7 ba 79 3e 00 b8 00 7d 
 



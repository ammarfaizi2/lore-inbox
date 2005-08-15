Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932631AbVHOCDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631AbVHOCDu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 22:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbVHOCDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 22:03:50 -0400
Received: from outbound3.mail.tds.net ([216.170.230.93]:50346 "EHLO
	outbound3.mail.tds.net") by vger.kernel.org with ESMTP
	id S932631AbVHOCDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 22:03:50 -0400
Date: Sun, 14 Aug 2005 21:03:31 -0500
From: Phil Dier <phil@icglink.com>
To: Sonny Rao <sonny@burdell.org>
Cc: neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org, ziggy@icglink.com,
       scott@icglink.com, jack@icglink.com
Subject: Re: 2.6.13-rc6 Oops with Software RAID, LVM, JFS, NFS
Message-Id: <20050814210331.102e005c.phil@icglink.com>
In-Reply-To: <20050812183548.GA2255@kevlar.burdell.org>
References: <20050811105954.31f25407.phil@icglink.com>
	<17148.1113.664829.360594@cse.unsw.edu.au>
	<20050812123505.1515634c.phil@icglink.com>
	<20050812183548.GA2255@kevlar.burdell.org>
Organization: ICGLInk
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got this:

Unable to handle kernel paging request at virtual address eeafefc0
 printing eip:
c0188487
*pde = 00681067
*pte = 2eafe000
Oops: 0000 [#1]
SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    1
EIP:    0060:[<c0188487>]    Not tainted VLI
EFLAGS: 00010296   (2.6.13-rc6)
EIP is at inotify_inode_queue_event+0x17/0x130
eax: eeafefc0   ebx: 00000000   ecx: 00000200   edx: eeafee9c
esi: 00000000   edi: ef4cbe9c   ebp: f66e1eac   esp: f66e1e84
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 6259, threadinfo=f66e0000 task=f6307b00)
Stack: eeafee9c c0536a34 ee900f6c f66e1eac c0179949 eeafefc0 23644d80 00000000
       00000000 ef4cbe9c f66e1ed4 c01713ad eeafee9c 00000400 00000000 00000000
       eeafee9c ee900f6c f0940f6c f6f0adf8 f66e1f00 c020caa1 ef4cbe9c ee900f6c
Call Trace:
 [<c0103e7f>] show_stack+0x7f/0xa0
 [<c0104030>] show_registers+0x160/0x1d0
 [<c0104260>] die+0x100/0x180
 [<c0116199>] do_page_fault+0x369/0x6ed
 [<c0103aa3>] error_code+0x4f/0x54
 [<c01713ad>] vfs_unlink+0x17d/0x210
 [<c020caa1>] nfsd_unlink+0x161/0x240
 [<c0207c64>] nfsd_proc_remove+0x44/0x90
 [<c0206747>] nfsd_dispatch+0xd7/0x200
 [<c0491b13>] svc_process+0x533/0x670
 [<c02064dd>] nfsd+0x1bd/0x350
 [<c01011e5>] kernel_thread_helper+0x5/0x10
Code: ff ff ff 8b 5d f8 8b 75 fc 89 ec 5d c3 8d b4 26 00 00 00 00 55 89 e5 57 56 53 83 ec 1c 8b 45 08 8b 55 08 05 24 01 00 00 89 45 ec <39> 82 24 01 00 00 74 5d f0 ff 8a 2c 01 00 00 0f 88 d1 0b 00 00



-- 

Phil Dier <phil@dier.us>

/* vim:set ts=8 sw=8 nocindent noai: */

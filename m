Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263185AbTDBXU1>; Wed, 2 Apr 2003 18:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263187AbTDBXU1>; Wed, 2 Apr 2003 18:20:27 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:11019
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263186AbTDBXU0>; Wed, 2 Apr 2003 18:20:26 -0500
Subject: back-trace on mounting ide cd-rom
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Content-Type: text/plain
Organization: 
Message-Id: <1049326318.2872.36.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 02 Apr 2003 18:31:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following errors and back-trace upon mounting my IDE CD-ROM
(hdc).  It seems to be a normal ISO9660... its the Red Hat 9 CD.

I haven't looked into it yet.  Not sure why there is ext3 stuff in
there... maybe the CD-ROM mount is unrelated?  Mounting the CD
subsequent times is OK.

Kernel is 2.5.66-mm2.  UP, preempt, no highmem, i686.

Here we go:

        buffer layer error at fs/buffer.c:127
        Call Trace:
         [<c0149d80>] __wait_on_buffer+0xe0/0xf0
         [<c0117b10>] autoremove_wake_function+0x0/0x50
         [<c0117b10>] autoremove_wake_function+0x0/0x50
         [<c014bcff>] __block_prepare_write+0x11f/0x460
         [<c0187d9a>] start_this_handle+0xaa/0x1f0
         [<c014c874>] block_prepare_write+0x34/0x50
         [<c017d760>] ext3_get_block+0x0/0xa0
         [<c017dd41>] ext3_prepare_write+0x71/0x130
         [<c017d760>] ext3_get_block+0x0/0xa0
         [<c012eeb9>] generic_file_aio_write_nolock+0x369/0xa50
         [<c012da90>] file_read_actor+0x0/0x130
         [<c012dd84>] __generic_file_aio_read+0x1c4/0x210
         [<c012f6c5>] generic_file_aio_write+0x85/0xb0
         [<c017b5b4>] ext3_file_write+0x44/0xe0
         [<c0148a0b>] do_sync_write+0x8b/0xc0
         [<c015aa11>] __pollwait+0x41/0xd0
         [<c015a9d0>] __pollwait+0x0/0xd0
         [<c015b07e>] sys_select+0x26e/0x560
         [<c0147b78>] filp_open+0x68/0x70
         [<c0148afe>] vfs_write+0xbe/0x130
         [<c0148c0e>] sys_write+0x3e/0x60
         [<c0109259>] sysenter_past_esp+0x52/0x71
         
        end_request: I/O error, dev hdc, sector 0
        end_request: I/O error, dev hdc, sector 0
        ISO 9660 Extensions: RRIP_1991A

Ideas?

	Robert Love


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270444AbTHGTyX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 15:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270316AbTHGTyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 15:54:23 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:33664 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S270497AbTHGTyR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 15:54:17 -0400
Date: Thu, 07 Aug 2003 12:53:54 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: slpratt@us.ibm.com
Subject: [Bug 1056] New: oops during hwscan in 2.6.0-test2-bk7
Message-ID: <43230000.1060286034@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1056

           Summary: oops during hwscan in 2.6.0-test2-bk7
    Kernel Version: 2.6.0-test2-bk7
            Status: NEW
          Severity: blocking
             Owner: axboe@suse.de
         Submitter: slpratt@us.ibm.com


Distribution:SLES 8
Hardware Environment:8way PIII, 8GB mem, aic7xxx
Software Environment:
Problem Description: Get the following oops during hwscan init script at boot time.


Starting service at daemondone
Starting hardware scan on boot200xxø200200200200Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<c02fed1e>]    Not tainted
EFLAGS: 00010007
EIP is at as_find_arq_hash+0x1e/0xa0
eax: 00000027   ebx: e3d973a0   ecx: c6728a80   edx: 20323178
esi: c6724a00   edi: 00000010   ebp: 203232b0   esp: f72d5c00
ds: 007b   es: 007b   ss: 0068
Process hwscan (pid: 815, threadinfo=f72d4000 task=dedbad40)
Stack: e3d973a0 c6724a00 00000010 00000000 c0300334 c6728a80 00000008 00000101
       ded470a0 c6728a80 00000000 c6724a00 00000008 00000000 c02f7809 c6724a00
       f72d5c6c e3d973a0 c02fa9a8 c6724a00 f72d5c6c e3d973a0 00000008 00000000
Call Trace:
 [<c0300334>] as_merge+0xe4/0x170
 [<c02f7809>] elv_merge+0x29/0x30
 [<c02fa9a8>] __make_request+0x2d8/0x4f0
 [<c02faced>] generic_make_request+0x12d/0x1b0
 [<c015bff7>] bio_alloc+0xd7/0x1c0
 [<c02fadc4>] submit_bio+0x54/0xa0
 [<c015a5b7>] block_read_full_page+0x227/0x2f0
 [<c0139161>] add_to_page_cache+0x71/0x110
 [<c013f254>] read_pages+0xf4/0x150
 [<c015e2e0>] blkdev_get_block+0x0/0x60
 [<c013d311>] __alloc_pages+0xa1/0x330
 [<c013f6a0>] __do_page_cache_readahead+0xf0/0x143
 [<c013f3e5>] page_cache_readahead+0x75/0x180
 [<c01399d3>] do_generic_mapping_read+0xf3/0x420
 [<c0139d00>] file_read_actor+0x0/0xf0
 [<c0139fe4>] __generic_file_aio_read+0x1f4/0x240
 [<c0139d00>] file_read_actor+0x0/0xf0
 [<c01478ee>] do_wp_page+0x37e/0x3a0
 [<c013a13e>] generic_file_read+0x8e/0xb0
 [<c01694e0>] __pollwait+0x0/0xd0
 [<c0169bfe>] sys_select+0x24e/0x520
 [<c01569ee>] vfs_read+0xbe/0x130
 [<c0156c92>] sys_read+0x42/0x70
 [<c010afef>] syscall_call+0x7/0xb

Code: 8b 5d 00 39 eb 89 d9 74 3f 89 f6 8d bc 27 00 00 00 00 8d 53


Steps to reproduce:
Boot machine.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266538AbUFQPWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUFQPWY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 11:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266537AbUFQPWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 11:22:24 -0400
Received: from holomorphy.com ([207.189.100.168]:49845 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266540AbUFQPVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 11:21:36 -0400
Date: Thu, 17 Jun 2004 08:21:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [oops] 2.6.7-rc2-mm2 iput()
Message-ID: <20040617152134.GR1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't quite gotten around to checking this out since I'm still
doing a wee bit of disaster recovery.


-- wli

 Unable to handle kernel paging request at virtual address 00007900
  printing eip:
 c0155ee1
 *pde = 2a3e8067
 *pte = 00000000
 Oops: 0002 [#1]
 Modules linked in:
 CPU:    0
 EIP:    0060:[<c0155ee1>]    Not tainted VLI
 EFLAGS: 00013246   (2.6.7-rc2-mm2-holomorphy-1) 
 EIP is at generic_delete_inode+0x91/0x100
 eax: 00000000   ebx: d75df9b0   ecx: 00000000   edx: 00007900
 esi: c01691f0   edi: 00000026   ebp: effeea48   esp: eb754cb0
 ds: 007b   es: 007b   ss: 0068
 Process XFree86 (pid: 1290, threadinfo=eb754000 task=eb7682b0)
 Stack: d75df9b0 d75df9b0 c01560cc c4f0c868 c0153e62 00000080 00000000 eb754000 
        c01541d2 c01312f7 00212380 00000000 0002b43d 0000000c 00000000 000000d2 
        00000040 0000000c eb754e8c c04c05ec 00000000 c0132229 00000000 000000d2 
 Call Trace:
  [<c01560cc>] iput+0x4c/0x60
  [<c0153e62>] prune_dcache+0x102/0x140
  [<c01541d2>] shrink_dcache_memory+0x12/0x20
  [<c01312f7>] shrink_slab+0x137/0x170
  [<c0132229>] try_to_free_pages+0x99/0x150
  [<c010f3f4>] do_page_fault+0x134/0x506
  [<c011021b>] recalc_task_prio+0x8b/0x180
  [<c012b4a6>] buffered_rmqueue+0xd6/0x180
  [<c012b701>] __alloc_pages+0x1b1/0x300
  [<c0105698>] common_interrupt+0x18/0x20
  [<c0134c4e>] do_anonymous_page+0x6e/0x140
  [<c0134d79>] do_no_page+0x59/0x290
  [<c013515e>] handle_mm_fault+0xbe/0x120
  [<c010f3f4>] do_page_fault+0x134/0x506
  [<c01041a3>] __switch_to+0xd3/0x140
  [<c042a75c>] schedule+0x25c/0x410
  [<c010b664>] restore_i387+0x44/0x70
  [<c0106fd3>] do_IRQ+0x113/0x150
  [<c010f2c0>] do_page_fault+0x0/0x506
  [<c01056d5>] error_code+0x2d/0x38
 
 Code: 8b 83 94 00 00 00 85 c0 74 64 f6 80 a0 00 00 00 03 74 09 f6 83 18 01 00 00 40 74 44 89 d8 ff d6 8b 53 04 85 d2 74 18 8b 03 85 c0 <89> 02 74 03 89 50 04 c7 03 00 00 00 00 c7 43 04 00 00 00 00 89 

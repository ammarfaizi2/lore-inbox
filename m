Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUBRDSV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 22:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUBRDSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 22:18:21 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:61088 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262050AbUBRDSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 22:18:16 -0500
Date: Wed, 18 Feb 2004 03:15:44 +0000
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: greg@kroah.com
Subject: 2.6.3rc4 ali1535 i2c driver rmmod oops.
Message-ID: <20040218031544.GB26304@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erk, whats going on here ?

		Dave

kfree_debugcheck: bad ptr c0317600h.
------------[ cut here ]------------
kernel BUG at mm/slab.c:1655!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0146d69>]    Not tainted
EFLAGS: 00010086
EIP is at kfree+0x5c/0x298
eax: c02dd380   ebx: 00007b98   ecx: 00000000   edx: c0317600
esi: c0317600   edi: c031a7d8   ebp: 00000000   esp: c2587f54
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 1349, threadinfo=c2586000 task=c22b7940)
Stack: 00000000 00000286 c78a0980 00000000 c031a7d8 00000000 c013a805 5f633269
       31696c61 00353335 c4e4c2d8 b8079000 c014ff4d c29bc104 b807a000 c01503f9
       c4e4c314 c31fa318 c49e98f4 00000246 c4e4c2d8 00e4c300 00000000 bff32ff8
Call Trace:
 [<c013a805>] sys_delete_module+0x168/0x18a
 [<c014ff4d>] unmap_vma_list+0xe/0x17
 [<c01503f9>] do_munmap+0x17d/0x189
 [<c010b697>] syscall_call+0x7/0xb
 
Code: 0f 0b 77 06 1b c6 2d c0 a1 4c 81 3d c0 8b 5c 18 08 b8 00 e0


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266630AbUBQVhJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUBQVdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:33:53 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:7576 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266630AbUBQVai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:30:38 -0500
Date: Tue, 17 Feb 2004 21:28:07 +0000
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: perex@suse.cz
Subject: alsa gus driver blows up on modprobe.
Message-ID: <20040217212807.GC6242@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, perex@suse.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple modprobe snd-interwave is enough to trigger this here..
(Actual card for this driver isn't in this box), but it still
shouldn't oops.

		Dave

Unable to handle kernel paging request at virtual address c7a401c0
 printing eip:
c01fa8fd
*pde = 06f3d067
*pte = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c01fa8fd>]    Not tainted
EFLAGS: 00010246
EIP is at pnp_register_card_driver+0x6d/0xd7
eax: c7a401c0   ebx: c7b83460   ecx: c031acf8   edx: 00000001
esi: 00000000   edi: 00000000   ebp: c2d4e000   esp: c2d4ff88
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2273, threadinfo=c2d4e000 task=c2806000)
Stack: 00000001 00000001 00000008 00000000 c031acd8 c780706c c031acf8 c7b83580
       c013c0c0 000427b2 000427b2 b7f72008 00000002 080573a0 c010b697 b7f72008
       000427b2 08b2c088 00000002 080573a0 bff3d7b8 00000080 0000007b 0000007b
Call Trace:
 [<c780706c>] alsa_card_interwave_init+0x6c/0x91 [snd_interwave_stb]
 [<c013c0c0>] sys_init_module+0x14e/0x25e
 [<c010b697>] syscall_call+0x7/0xb
                                                                                
Code: 89 18 89 43 04 81 3d 74 ff 34 c0 ad 4e ad de 74 08 0f 0b 4a


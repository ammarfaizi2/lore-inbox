Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263757AbTJ0EmK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 23:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263758AbTJ0EmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 23:42:10 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:1482 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263757AbTJ0EmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 23:42:07 -0500
Date: Mon, 27 Oct 2003 05:42:05 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: cat /proc/bus/pnp/escd -> kernel segfault (2.6 BK)
Message-ID: <20031027044204.GA23976@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doing cat /proc/bus/pnp/escd on my Linux 2.6 (BK) crashes:

Unable to handle kernel paging request at virtual address ffffa00a
 printing eip:
00007228
*pde = 00002067
*pte = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0098:[<00007228>]    Not tainted
EFLAGS: 00010086
EIP is at 0x7228
eax: 000022ff   ebx: 00b06196   ecx: 000000a0   edx: 00000000
esi: 0000000a   edi: d1e70000   ebp: d1e773cf   esp: d1e79e64
ds: 00b0   es: 00a8   ss: 0068
Process cat (pid: 23647, threadinfo=d1e78000 task=c43f6c80)
Stack: 000a0002 00b00000 000600a8 73d9720a 00000000 5f0a00a0 61af9e98 007b0000 
       8000007b 60040000 008200a8 d1e79eec 0090000b 00000042 00b000a8 000000a0 
       00000000 c0220c50 00000060 00000082 00000000 00000000 0000007b 0000007b 
Call Trace:
 [<c0220c50>] __pnp_bios_read_escd+0x110/0x1a0
 [<c0222080>] proc_read_escd+0x0/0x130
 [<c0220cf9>] pnp_bios_read_escd+0x19/0x50
 [<c0222080>] proc_read_escd+0x0/0x130
 [<c02220ea>] proc_read_escd+0x6a/0x130
 [<c0222080>] proc_read_escd+0x0/0x130
 [<c018896e>] proc_file_read+0x16e/0x290
 [<c0157e63>] vfs_read+0xd3/0x140
 [<c015811f>] sys_read+0x3f/0x60
 [<c010a41b>] syscall_call+0x7/0xb

Willing to provide further debug info, please send directions. This is
an old Gigabyte 7ZX-R board (AMIBIOS).

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95

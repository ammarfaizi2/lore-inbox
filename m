Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVJQMxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVJQMxi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 08:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVJQMxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 08:53:38 -0400
Received: from mail-in3.spymac.net ([195.225.149.153]:37328 "EHLO
	mail-in3.spymac.lan") by vger.kernel.org with ESMTP id S932302AbVJQMxi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 08:53:38 -0400
From: =?utf-8?q?Jes=C3=BAs_Malo_Poyatos?= <jesusmalo@gmail.com>
Reply-To: jesusmalo@gmail.com
To: linux-kernel@vger.kernel.org
Subject: Bug in reiserfs
Date: Mon, 17 Oct 2005 14:53:20 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510171453.22267.jesusmalo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have receive the next message when I was trying to remove an archive. I hope this information is useful for you.



kernel BUG at fs/reiserfs/journal.c:3098!
invalid operand: 0000 [#1]
Modules linked in: reiserfs dm_mod ne2k_pci 8390 via82cxxx fan thermal processor usb_storage usbhid uhci_hcd usbcore ide_disk ide_cd ide_core sg sr_mod sd_mod scsi_mod cdrom cramfs vfat fat nls_iso8859_1 nls_cp437 af_packet nvram
CPU:    0
EIP:    0060:[<c8f0b575>]    Not tainted VLI
EFLAGS: 00010246   (2.6.13-15-default) 
EIP is at journal_begin+0xe5/0xf0 [reiserfs]
eax: 00000000   ebx: c7069ed4   ecx: 00000012   edx: c7099400
esi: c7069f1c   edi: c7068000   ebp: c7099400   esp: c7069ebc
ds: 007b   es: 007b   ss: 0068
Process rm (pid: 2137, threadinfo=c7068000 task=c7e49590)
Stack: 00000012 c40df208 c40df208 c7069f68 00000000 c8ef9bbd 00000000 00000000 
       000a0f61 000a118d 00000000 00000000 00000000 00000000 c7069f1c c7099400 
       00000024 c767b84c c8f0b89d c40df208 00000024 c7069f68 c767b84c c8eedae4 
Call Trace:
 [<c8ef9bbd>] remove_save_link+0x1d/0xc0 [reiserfs]
 [<c8f0b89d>] journal_end+0x8d/0xc0 [reiserfs]
 [<c8eedae4>] reiserfs_delete_inode+0xe4/0x100 [reiserfs]
 [<c8eeda00>] reiserfs_delete_inode+0x0/0x100 [reiserfs]
 [<c01707ab>] generic_delete_inode+0x7b/0x120
 [<c0170a0a>] iput+0x5a/0x70
 [<c0167bd4>] sys_unlink+0xd4/0x130
 [<c0102d79>] syscall_call+0x7/0xb
Code: 00 00 00 89 46 04 89 df f3 a5 83 7b 04 01 7f cd 68 f0 6c f1 c8 55 e8 eb 1c ff ff 31 c9 5b 5e eb ab 0f 0b 38 0c 86 30 f1 c8 eb a1 <0f> 0b 1a 0c 86 30 f1 c8 eb c8 90 55 57 56 53 83 ec 10 89 cf 89 
 Badness in do_exit at kernel/exit.c:790
 [<c011e9e8>] do_exit+0x338/0x340
 [<c010468e>] die+0x13e/0x140
 [<c0104940>] do_invalid_op+0x0/0xa0
 [<c01049d1>] do_invalid_op+0x91/0xa0
 [<c8f0b575>] journal_begin+0xe5/0xf0 [reiserfs]
 [<c0103f0f>] error_code+0x4f/0x60
 [<c8f0b575>] journal_begin+0xe5/0xf0 [reiserfs]
 [<c8ef9bbd>] remove_save_link+0x1d/0xc0 [reiserfs]
 [<c8f0b89d>] journal_end+0x8d/0xc0 [reiserfs]
 [<c8eedae4>] reiserfs_delete_inode+0xe4/0x100 [reiserfs]
 [<c8eeda00>] reiserfs_delete_inode+0x0/0x100 [reiserfs]
 [<c01707ab>] generic_delete_inode+0x7b/0x120
 [<c0170a0a>] iput+0x5a/0x70
 [<c0167bd4>] sys_unlink+0xd4/0x130
 [<c0102d79>] syscall_call+0x7/0xb

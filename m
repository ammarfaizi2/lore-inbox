Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTIGJuQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 05:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbTIGJuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 05:50:16 -0400
Received: from mx0.gmx.de ([213.165.64.100]:4607 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id S263077AbTIGJuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 05:50:10 -0400
Date: Sun, 7 Sep 2003 11:50:09 +0200 (MEST)
From: Daniel Blueman <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: [2.6.0-test4] [BUG] reiserfs_writepage()
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0008973862@gmx.net
X-Authenticated-IP: [81.107.233.135]
Message-ID: <14963.1062928209@www51.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me know if any more info would help on this!

---

kernel BUG at mm/filemap.c:336!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0140df3>]    Not tainted
EFLAGS: 00010246
EIP is at end_page_writeback+0x6a/0x82
eax: 00000000   ebx: c123cad0   ecx: 00000017   edx: c038ab60
esi: c14f9260   edi: c777bf58   ebp: df689d64   esp: df689d58
ds: 007b   es: 007b   ss: 0068
Process pdflush (pid: 6, threadinfo=df688000 task=df6af000)
Stack: c123cad0 00000000 c777bf58 df689d94 c01df812 c123cad0 c123cad0
df689edc
       00000000 00000000 00000000 d02a503c c123cad0 d02a50f8 df688000
df689de4
       c0196b8e c123cad0 df689edc d4f5803c d4f580f8 d4f5803c df689df8
c010ac1c
Call Trace:
 [<c01df812>] reiserfs_write_full_page+0xe1/0x314
 [<c0196b8e>] mpage_writepages+0x3de/0x538
 [<c010ac1c>] common_interrupt+0x18/0x20
 [<c01dfa5b>] reiserfs_writepage+0x0/0x39
 [<c0147501>] do_writepages+0x37/0x39
 [<c0194242>] __sync_single_inode+0x1cd/0x4a7
 [<c019491e>] sync_sb_inodes+0x1ed/0x409
 [<c0194cd1>] writeback_inodes+0x197/0x4b3
 [<c0147361>] wb_kupdate+0xdb/0x15a
 [<c0147cfc>] __pdflush+0x258/0x65b
 [<c011a221>] schedule_tail+0x10e/0x14f
 [<c01480ff>] pdflush+0x0/0x15
 [<c0148110>] pdflush+0x11/0x15
 [<c0147286>] wb_kupdate+0x0/0x15a
 [<c01074b1>] kernel_thread_helper+0x5/0xb

Code: 0f 0b 50 01 a8 e7 35 c0 eb cd 89 1c 24 e8 03 c8 00 00 85 c0

-- 
Daniel J Blueman

COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post


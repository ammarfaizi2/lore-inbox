Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbTAMC7J>; Sun, 12 Jan 2003 21:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbTAMC7I>; Sun, 12 Jan 2003 21:59:08 -0500
Received: from topic-gw2.topic.com.au ([203.37.31.2]:24310 "EHLO
	mailhost.topic.com.au") by vger.kernel.org with ESMTP
	id <S261371AbTAMC7H>; Sun, 12 Jan 2003 21:59:07 -0500
Date: Mon, 13 Jan 2003 14:07:49 +1100
From: Jason Thomas <jason@topic.com.au>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ide-scsi bug hard locks machine
Message-ID: <20030113030749.GC626@topic.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, heres the kernel logs from my machine which hard locks.

If you need more info email me directly I'm not subscribed.

Thanks.

ptelnet log 1: 13 Jan 2003  1:51 pm
ide-scsi: abort called for 2
bad: scheduling while atomic!
Call Trace: [<c0116941>]  [<c0109b76>]  [<c01169b0>]  [<c011a5db>]  [<c0109d8c>]  [<c0263100>]  [<c0262730>]  [<c026848c>]  [<c0268390>]  [<c0261e63>]  [<c0261cc0>]  [<c0261c80>]  [<c026225d>]  [<c02622d7>]  [<c0262b65>]  [<c0109d97>]  [<c0262c89>]  [<c0262bb0>]  [<c0108be9>] 
hde: lost interrupt
ide-scsi: CoD != 0 in idescsi_pc_intr
hde: ATAPI reset complete
hde: irq timeout: status=0xc0 { Busy }
hde: ATAPI reset complete
hde: irq timeout: status=0xc0 { Busy }
hde: ATAPI reset complete
hde: irq timeout: status=0xc0 { Busy }
ide-scsi: reset called for 2
------------[ cut here ]------------
kernel BUG at drivers/scsi/ide-scsi.c:483!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c0267845>]    Not tainted
EFLAGS: 00010286
eax: c024ab50   ebx: c0448d84   ecx: edae15ed   edx: 0000d002
esi: d7c96800   edi: d7c93bc0   ebp: 00000000   esp: d7c4be5c
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_0 (pid: 11, threadinfo=d7c4a000 task=d7c498c0)
Stack: 0000d002 c0448d84 00000008 00000080 0000001e c0448d84 c0448d84 00000000 
       d7d023c0 c0246bd9 c0448d84 d7c93bc0 00000000 00000088 0000001e d7c4a000 
       d7d023c0 c0448d84 d7d7eb80 c0246dd9 c0448d84 d7d023c0 c0448e2c d7c4a000 
Call Trace: [<c0246bd9>]  [<c0246dd9>]  [<c02474ff>]  [<c0247443>]  [<c026825b>]  [<c0261dbc>]  [<c0261cc0>]  [<c0261c80>]  [<c026225d>]  [<c0262417>]  [<c02622d7>]  [<c0262b79>]  [<c0109d97>]  [<c0262c89>]  [<c0262bb0>]  [<c0108be9>] 
Code: 0f 0b e3 01 2b 07 38 c0 8b 57 38 a1 c8 d0 42 c0 89 d1 29 c1 
 hde: ATAPI reset complete
hde: status error: status=0x48 { DriveReady DataRequest }
hde: drive not ready for command
hde: lost interrupt
ide-scsi: CoD != 0 in idescsi_pc_intr
hde: ATAPI reset complete
hde: irq timeout: status=0xc0 { Busy }
hde: ATAPI reset complete
hde: irq timeout: status=0xc0 { Busy }
hde: ATAPI reset complete
hde: irq timeout: status=0xc0 { Busy }

-- 
Jason Thomas                           Phone:  +61 2 6257 7111
Unix System Administrator              Fax:    +61 2 6257 7311
tSA Consulting Group Pty. Ltd.         Mobile: 0418 29 66 81
1 Hall Street Lyneham ACT 2602         http://www.topic.com.au/

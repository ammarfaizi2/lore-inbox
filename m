Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267371AbTALJvW>; Sun, 12 Jan 2003 04:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267369AbTALJvV>; Sun, 12 Jan 2003 04:51:21 -0500
Received: from tmailb1.svr.pol.co.uk ([195.92.168.141]:11302 "EHLO
	tmailb1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267357AbTALJvO>; Sun, 12 Jan 2003 04:51:14 -0500
Subject: oops on ISN load in 2.5.56
From: Voltan <voltan89@yahoo.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1042365592.1622.2.camel@snifter>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 12 Jan 2003 09:59:53 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I've been trying out 2.5.X, and I get an error on loading the drivers
for my passive HFC-PCI card.

Any thoughts?



Unable to handle kernel NULL pointer dereference at virtual address
00000028
 printing eip:
cc867c91
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<cc867c91>]    Not tainted
EFLAGS: 00010002
EIP is at get_drv_by_nr+0x31/0x337983a0 [isdn]
eax: 00000000   ebx: 00000010   ecx: 00000007   edx: 00000023
esi: c7d00000   edi: 00000202   ebp: cc890f87   esp: c7d01ef8
ds: 007b   es: 007b   ss: 0068
Process perl (pid: 1002, threadinfo=c7d00000 task=c7cff940)
Stack: 00000001 00000538 cb963ec0 cb963ea0 00000000 00000000 00000023
cc868904
       00000023 cc873136 c7d01f40 c01afddf cb963ec0 cb963ea0 cc890f88
cc8689cc
       00000000 cc87312f 00000000 00000000 00000000 cb963ec0 cb963ea0
cb963ea0
Call Trace:
 [<cc868904>] get_slot_by_minor+0x14/0x33797710 [isdn]
 [<cc873136>] +0xd2a/0x3378dbf4 [isdn]
 [<c01afddf>] sprintf+0x1f/0x30
 [<cc890f88>] istatbuf.3+0x8/0x3376f080 [isdn]
 [<cc8689cc>] isdn_statstr+0x4c/0x33797680 [isdn]
 [<cc87312f>] +0xd23/0x3378dbf4 [isdn]
 [<cc869069>] isdn_status_read+0x79/0x33797010 [isdn]
 [<c014b08e>] vfs_read+0xbe/0x130
 [<c014b32e>] sys_read+0x3e/0x60
 [<c010b20b>] syscall_call+0x7/0xb

Code: 8b 43 18 40 89 44 24 0c 8b 43 18 89 44 24 08 8b 03 c7 04 24





Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313848AbSDJV0B>; Wed, 10 Apr 2002 17:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313850AbSDJV0A>; Wed, 10 Apr 2002 17:26:00 -0400
Received: from air-2.osdl.org ([65.201.151.6]:51217 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S313848AbSDJVZ4>;
	Wed, 10 Apr 2002 17:25:56 -0400
Date: Wed, 10 Apr 2002 14:22:02 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: scsi_merge oops (2.5.8-pre2)
Message-ID: <Pine.LNX.4.33L2.0204101416350.25409-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


with much paging, swapping, memory pressure...


[root@dev8-003 root]# kernel BUG at scsi_merge.c:82!
invalid operand: 0000
CPU:    5
EIP:    0010:[<c025297f>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: 00000001   ecx: 00000020   edx: f75ff800
esi: f75ff800   edi: f75ff8b4   ebp: f75ff800   esp: f6ecdbc4
ds: 0018   es: 0018   ss: 0018
Process bash-shared-map (pid: 1640, threadinfo=f6ecc000 task=f70d2960)
Stack: c035ba80 f764fa40 f75ff918 c0252770 f75ff800 c035ba80 cd2ccb00 f769a600
       00000000 f75f8600 f75f86b4 f769a618 00000202 c0251d6b f769a618 f75f8600
       f75f86b4 f769a618 f76a6920 c0251eb4 f769a618 00000000 f75f8600 00000000
Call Trace: [<c0252770>] [<c0251d6b>] [<c0251eb4>] [<c02521e5>] [<c0132230>]
   [<c026a351>] [<c02588f6>] [<c024c337>] [<c024c060>] [<c011e42b>] [<c011e2d1>]
   [<c011e05b>] [<c0108ded>] [<c013473b>] [<c01343c4>] [<c013442c>] [<c0134f18>]
   [<c01351cd>] [<c012cc26>] [<c012cc99>] [<c012e34d>] [<c012a071>] [<c012a585>]
   [<c0112d27>] [<c0114c9e>] [<c06a351>] [<c0121596>] [<c0121776>] [<c011e42b>]
   [<c011e2d1>


so, does this mean that it's a BUG() not to be able to allocate
with <gfp_nowait> ?

sounds odd to me.

-- 
~Randy


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319741AbSIMTDV>; Fri, 13 Sep 2002 15:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319749AbSIMTDV>; Fri, 13 Sep 2002 15:03:21 -0400
Received: from gw-ipex.infonet.cz ([212.71.128.102]:41973 "EHLO
	cimice.maxinet.cz") by vger.kernel.org with ESMTP
	id <S319741AbSIMTDT>; Fri, 13 Sep 2002 15:03:19 -0400
Message-ID: <001101c25b58$e2b09c30$4500a8c0@cybernet.cz>
From: "=?iso-8859-2?B?VmxhZGlt7XIgVPhlYmlja/0=?=" <druid@mail.cz>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with swap
Date: Fri, 13 Sep 2002 21:08:03 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-2.4.20-pre5-ac4

Every access to swap causes:

Sep 13 19:50:34 shunka kernel: kernel BUG at page_alloc.c:117!
Sep 13 19:50:34 shunka kernel: invalid operand: 0000
Sep 13 19:50:34 shunka kernel: CPU:    0
Sep 13 19:50:34 shunka kernel: EIP:    0010:[<c012ab39>]    Not tainted
Sep 13 19:50:34 shunka kernel: EFLAGS: 00010282
Sep 13 19:50:34 shunka kernel: eax: 01000010   ebx: c10b8504   ecx: c028a39c
edx: c1237088
Sep 13 19:50:34 shunka kernel: esi: 00000000   edi: 00040000   ebp: 085e5000
esp: c48f7e30
Sep 13 19:50:34 shunka kernel: ds: 0018   es: 0018   ss: 0018
Sep 13 19:50:34 shunka kernel: Process cc1 (pid: 12341, stackpage=c48f7000)
Sep 13 19:50:34 shunka kernel: Stack: c10b8504 00173000 00040000 085e5000
0000b000 c100000c c10f8b44 c028a39c
Sep 13 19:50:34 shunka kernel:        c103400c c028a3d8 00000217 ffffffff
00004f3c c012b389 c012b807 c10b8504
Sep 13 19:50:34 shunka kernel:        c011f5f9 c10b8504 c1f20894 c011fa2b
038b6067 cbb02f20 ca2a30a0 00173000
Sep 13 19:50:34 shunka kernel: Call Trace:    [<c012b389>] [<c012b807>]
[<c011f5f9>] [<c011fa2b>] [<c0122192>]
Sep 13 19:50:34 shunka kernel:   [<c0112212>] [<c0116265>] [<c011b21a>]
[<c01085cf>] [<c010fd34>] [<c0117696>]
Sep 13 19:50:34 shunka kernel:   [<c01175d6>] [<c01173ea>] [<c0109c0d>]
[<c0108844>] [<c0108774>]
Sep 13 19:50:34 shunka kernel:
Sep 13 19:50:34 shunka kernel: Code: 0f 0b 75 00 cc 3d 24 c0 8b 43 18 24 eb
89 43 18 c6 43 24 05

There is also some warning on console. Something like "trying to access
place outside partition".

--
Vladimir Trebicky
druid@mail.cz


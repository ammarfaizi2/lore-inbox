Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135419AbRAJXdV>; Wed, 10 Jan 2001 18:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135565AbRAJXdM>; Wed, 10 Jan 2001 18:33:12 -0500
Received: from uucp.gnuu.de ([151.189.0.84]:2055 "EHLO uucp.gnuu.de")
	by vger.kernel.org with ESMTP id <S135419AbRAJXcv>;
	Wed, 10 Jan 2001 18:32:51 -0500
Date: Thu, 11 Jan 2001 00:31:32 +0100
From: Ulrich Schwarz <uschwarz@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 vm BUG
Message-ID: <20010111003132.A2134@fruli.2y.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.4.0 (final i386) patched with reiserfs 3.6.25 produced the following BUG:

the console reported:
kernel BUG at vmscan.c:452!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01260fd>]
EFLAGS: 00010282
eax: 0000001c   ebx: c101322c   ecx: c0274608   edx: 00000000
esi: c23acc24   edi: c1013210   ebp: 000000ef   esp: c23d9c80
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 340, stackpage=c23d9000)
Stack: c0225a73 c0225c12 000001c4 c02757a0 c0275a0c 00000001 00000000 c0127a28
       c02757a0 00000000 c0275a10 00000000 00008038 c0127b9d c0275a04 00000000
       00000001 00000001 00000000 00001000 00000000 00008038 00000003 00000001
Call Trace: [<c0127a28>] [<c0127b9d>] [<c012f8e2>] [<c012da24>] [<c012da31>] [<c012de12>] [<c012e022>]
       [<c0184a5b>] [<c0180b2d>] [<c01748d9>] [<c013eacb>] [<c013ecf6>] [<c0174950>] [<c0171351>] [<c0135dcb>]
       [<c0136199>] [<c0136acc>] [<c0133786>] [<c0108e73>]

Code: 0f 0b 83 c4 0c 31 c0 0f b3 47 18 19 c0 85 c0 75 19 68 c5 01

However, in /var/log/kernlog, this incident was reported as follows:
Jan 10 22:14:54 kernel: kernel BUG at page_alloc.c:74!
Jan 10 22:14:54 kernel: invalid operand: 0000


So long.
Ulrich

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129613AbRB0RNA>; Tue, 27 Feb 2001 12:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129623AbRB0RMu>; Tue, 27 Feb 2001 12:12:50 -0500
Received: from cr793392-a.pr1.on.wave.home.com ([24.112.97.56]:3844 "EHLO
	prophit.maincube.net") by vger.kernel.org with ESMTP
	id <S129613AbRB0RMg>; Tue, 27 Feb 2001 12:12:36 -0500
From: "David Priban" <david2@maincube.net>
To: <linux-kernel@vger.kernel.org>
Subject: i2o & Promise SuperTrak100
Date: Tue, 27 Feb 2001 12:14:14 -0500
Message-ID: <MPBBILLJAONHMANIJOPDIEBIFMAA.david2@maincube.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can somebody comment on usability of current i2o drivers
from 2.4.2 kernel with Promise SuperTrak100 controller?
There seems to be some interrupt issue causing kernel
to panic when i2o_block is loaded. Transcript as follows:

Scheduling in interrupt
kernel BUG at sched.c:707!
invalid operand: 0000
CPU:		0
EIP:		0010:[<c01110e4>]
EFLAGS:	00010086
eax: 0000001b  ebx: c7f99760  ecx: 00000001  edx: c0246b08
esi: 00001cc6  edi: c0258000  ebp: c0259eac  esp: c0259e7c
Process swapper(pid:0, stackpage=c0259000)
Stack:
c01f9acb  c01f9c36  000002c3  c7f99760  00001cc6  c1272a78  00000044
00000082
00000000  c7f99760  00000000  c01b33fe  c1272a20  c01b349c  c7f99760
c7f99760
00000001  00000056  c01b308f  c7f99760  c7f99760  c02548a0  00000001
c029072a
Call Trace:
[<c01b33fe>] [<c01b349c>] [<c01b308f>] [<c01b4774>]
[<c01b47a6>] [<c011b0fe>] [<c011b4bf>] [<c018969d>]
[<c0189731>] [<c018918e>] [<c018a12d>] [<c018a19f>]
[<c0109f6d>] [<c010a0ce>] [<c0107120>] [<c0107120>]
[<c0108e00>] [<c0107120>] [<c0107120>] [<c0100018>]
[<c0107143>] [<c01071a9>] [<c0105000>] [<c0100191>]
Code:
0f 0b 8d 65 dc 5b 5e 5f 89 ec 5d c3 55 89 e5 83 ec 10 57 56
Kernel panic: Aiee, killing interrupt handler !
In interrupt handler - not syncing

It is hand written so errors are possible...

This doesn't happen if I compile drivers as modules a load them
by hand.

Thanks   David


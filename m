Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265942AbUBCVwq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 16:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266051AbUBCVwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 16:52:46 -0500
Received: from atchoum.afturgurluk.org ([62.4.18.28]:36077 "EHLO
	daghoba.afturgurluk.org") by vger.kernel.org with ESMTP
	id S265942AbUBCVwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 16:52:45 -0500
Date: Tue, 3 Feb 2004 22:52:50 +0100 (CET)
From: Mourn <mourn@daghoba.afturgurluk.org>
To: linux-kernel@vger.kernel.org
Subject: Mounting hfs cdrom
Message-ID: <Pine.NEB.4.44.0402032248530.20342-100000@daghoba.afturgurluk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

As I received the same error with different kernel version and
compilation, I thought I had to send you this report.

For information, my kernel is a 2.4.22-grsec with pax enabled.
When I try to mount in loopback mode an iso of an hfs cdrom, it works
well, but when I try to mount directly the cdrom, I obtain a kernel BUG
message. If I re-use mount after that, my kernel finally panics.

Here is the message I obtain when I try to mount an HFS cdrom :
--------------------------------------------------------------------
Feb  3 22:27:48 cath kernel: kernel BUG at buffer.c:2557!
Feb  3 22:27:48 cath kernel: invalid operand: 0000
Feb  3 22:27:48 cath kernel: CPU:    0
Feb  3 22:27:48 cath kernel: EIP:    0010:[<c021c4f2>]    Tainted: P
Feb  3 22:27:48 cath kernel: EFLAGS: 00010206
Feb  3 22:27:48 cath kernel: eax: 000007ff   ebx: 0000000b   ecx: 00000800
edx: d6d46600
Feb  3 22:27:48 cath kernel: esi: 00000000   edi: 00000b00   ebp: 00000000
esp: d61cbda0
Feb  3 22:27:48 cath kernel: ds: 0018   es: 0018   ss: 0018
Feb  3 22:27:48 cath kernel: Process mount (pid: 393, stackpage=d61cb000)
Feb  3 22:27:48 cath kernel: Stack: 00000000 00000b00 00000200 00000000
00004000 c021a509 00000b00 00000000
Feb  3 22:27:48 cath kernel:        00000200 00000b00 c17a4800 00000000
00000001 c021a728 00000b00 00000000
Feb  3 22:27:48 cath kernel:        00000200 d61cbdf4 c027b883 00000b00
00000000 00000200 00000b00 00000001
Feb  3 22:27:48 cath kernel: Call Trace:    [<c021a509>] [<c021a728>]
[<c027b883>] [<c027aa91>] [<c027b6a2>]
Feb  3 22:27:48 cath kernel:   [<c0313b85>] [<c021dce7>] [<c022f6a6>]
[<c021decd>] [<c0230787>] [<c0230a5b>]
Feb  3 22:27:48 cath kernel:   [<c02308a4>] [<c0230ea7>] [<c01e61e7>]
Feb  3 22:27:48 cath kernel:
Feb  3 22:27:48 cath kernel: Code: 0f 0b fd 09 7f 75 3d c0 8b 44 24 20 05
00 fe ff ff 3d 00 0e
-----------------------------------------------------------------------

Thanks for your work :)

++
Damien


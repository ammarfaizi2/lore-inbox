Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbSLaX4X>; Tue, 31 Dec 2002 18:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265108AbSLaX4X>; Tue, 31 Dec 2002 18:56:23 -0500
Received: from mail.ithnet.com ([217.64.64.8]:41489 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S264984AbSLaX4W>;
	Tue, 31 Dec 2002 18:56:22 -0500
Date: Wed, 1 Jan 2003 01:04:50 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: BUG REPORT: 2.4.20 System freeze at 00:00:00 Jan 1 2003
Message-Id: <20030101010450.17895f47.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I am really unsure what to think about the system freeze I just experienced on a very low loaded system:

Jan  1 00:00:00 core-2 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000008
Jan  1 00:00:00 core-2 kernel:  printing eip:
Jan  1 00:00:00 core-2 kernel: c0136a7b
Jan  1 00:00:00 core-2 kernel: *pde = 00000000
Jan  1 00:00:00 core-2 kernel: Oops: 0000
Jan  1 00:00:00 core-2 kernel: CPU:    0
Jan  1 00:00:00 core-2 kernel: EIP:    0010:[fput+27/304]    Not tainted
Jan  1 00:00:00 core-2 kernel: EIP:    0010:[<c0136a7b>]    Not tainted
Jan  1 00:00:00 core-2 kernel: EFLAGS: 00010292
Jan  1 00:00:00 core-2 kernel: eax: f675fee0   ebx: f675fee0   ecx: f62333c0   edx: f600bf4c
Jan  1 00:00:00 core-2 kernel: esi: 00000000   edi: fffffe00   ebp: 00000000   esp: f600bf7c
Jan  1 00:00:00 core-2 kernel: ds: 0018   es: 0018   ss: 0018
Jan  1 00:00:00 core-2 kernel: Process run-crons (pid: 859, stackpage=f600b000)
Jan  1 00:00:00 core-2 kernel: Stack: f6233428 00000000 00000000 f675fee0 fffffe00 00000080 c0135be1 f675eee0
Jan  1 00:00:00 core-2 kernel:        bffff9e0 00000080 f675ef00 00000000 00000000 f600a000 00000080 bffff9e0
Jan  1 00:00:00 core-2 kernel:        bffff9b8 c010741f 00000003 bffff9e0 00000080 00000080 bffff9e0 bffff9b8
Jan  1 00:00:00 core-2 kernel: Call Trace:    [sys_read+241/320] [system_call+51/56]
Jan  1 00:00:00 core-2 kernel: Call Trace:    [<c0135be1>] [<c010741f>]
Jan  1 00:00:00 core-2 kernel:
Jan  1 00:00:00 core-2 kernel: Code: 8b 7d 08 ff 48 14 0f 94 c0 84 c0 75 18 8b 5c 24 08 8b 74 24

After this the system was just frozen, I did not see any additional info. Just plain dead.
This is kernel 2.4.20. FS is reiser. Distro used is SuSE 8.1. It is a do-nothing system (no load, no plan).
Stood there for about 2 months, now crashed on new year wrap...

-- 
Regards,
Stephan


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVAMSta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVAMSta (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 13:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVAMSpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 13:45:47 -0500
Received: from mail.nrlssc.navy.mil ([128.160.25.4]:9153 "EHLO
	mail2.nrlssc.navy.mil") by vger.kernel.org with ESMTP
	id S261290AbVAMSoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 13:44:24 -0500
Date: Thu, 13 Jan 2005 12:44:23 -0600 (CST)
From: "Roy Keene (Contractor)" <keene@nrlssc.navy.mil>
To: linux-kernel@vger.kernel.org
Subject: 2.4.28 crashes with BUG at page_alloc.c:144
Message-ID: <Pine.LNX.4.58.0501131241230.6797@opt-riedlinger.nrlssc.navy.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having problems with a stock 2.4.28 kernel occasionally giving
BUGs and then the system becoming unstable.

Has anyone else seen this ?

Example:

Jan 13 10:24:30 x kernel: kernel BUG at page_alloc.c:144!
Jan 13 10:24:30 x kernel: invalid operand: 0000
Jan 13 10:24:30 x kernel: CPU:    0
Jan 13 10:24:30 x kernel: EIP:    0010:[<c013a3d2>]    Tainted: P
Jan 13 10:24:30 x kernel: EFLAGS: 00013282
Jan 13 10:24:30 x kernel: eax: 00000000   ebx: c28c1760   ecx: c02f32d4   edx: c02f3040
Jan 13 10:24:30 x kernel: esi: c28c1760   edi: 00000000   ebp: ea01fbc4   esp: f47fbdd0
Jan 13 10:24:30 x kernel: ds: 0018   es: 0018   ss: 0018
Jan 13 10:24:30 x kernel: Process X (pid: 2412, stackpage=f47fb000)
Jan 13 10:24:30 x kernel: Stack: 00000001 00003286 00000003 cb6eca00 cb6eca00 cb6eca00 c28c1760 c01479d3
Jan 13 10:24:30 x kernel:        cb6eca00 00000000 c28c1760 c02f31f8 000200a6 c0139a1c c28c1760 000001d2
Jan 13 10:24:30 x kernel:        00000b54 000001d2 00000018 0000001d 000001d2 c02f31f8 c02f31f8 c0139c6a
Jan 13 10:24:30 x kernel: Call Trace:    [<c01479d3>] [<c0139a1c>] [<c0139c6a>] [<c0139ce2>] [<c012688a>]
Jan 13 10:24:30 x kernel:   [<c013a93d>] [<c013ac58>] [<c012e117>] [<c012e4c5>] [<c0119648>] [<c0108cba>]
Jan 13 10:24:30 x kernel:   [<c0122e25>] [<c012688a>] [<c0117588>] [<c01192d0>] [<c0108fbc>]
Jan 13 10:24:30 x kernel:
Jan 13 10:24:30 x kernel: Code: 0f 0b 90 00 57 d0 2a c0 8b 35 d0 27 37 c0 89 d8 29 f0 c1 f8


	Roy Keene
	Roy.Keene@nrlssc.navy.mil

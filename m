Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbTCTRns>; Thu, 20 Mar 2003 12:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261549AbTCTRns>; Thu, 20 Mar 2003 12:43:48 -0500
Received: from p508EEB97.dip.t-dialin.net ([80.142.235.151]:30695 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id <S261476AbTCTRnq>;
	Thu, 20 Mar 2003 12:43:46 -0500
Date: Thu, 20 Mar 2003 18:54:57 +0100
From: Patrick Mau <mau@oscar.ping.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Process stuck with 2.5 bk current
Message-ID: <20030320175457.GA3171@oscar.ping.de>
Reply-To: Patrick Mau <mau@oscar.ping.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo list,

"kded", the KDE desktop daemon, always gets stuck in
D state with kernel 2.5 (BK from today). I used Sysreq-T
to get a call trace. Maybe someone has a clue what's
going on.

The NFS mounts on this machine are from a remote
2.4.20 nfs server with reiserfs partitions, if
that matters. NFS still works, BTW.

cheers,
Patrick

Here's the call trace:

Mar 20 18:47:13 tony kernel: kdeinit       D 00000046 4292898224   636
635
                  (NOTLB)
Mar 20 18:47:13 tony kernel: Call Trace:
Mar 20 18:47:13 tony kernel: [<c011ef29>] schedule_timeout+0x5f/0xb3
Mar 20 18:47:13 tony kernel: [<c011eec1>] process_timeout+0x0/0x9
Mar 20 18:47:13 tony kernel: [<c011589b>] sleep_on_timeout+0x4a/0x66
Mar 20 18:47:13 tony kernel: [<c011556c>] default_wake_function+0x0/0x12
Mar 20 18:47:13 tony kernel: [<c018fb5c>] nlmclnt_block+0x4c/0xc6
Mar 20 18:47:13 tony kernel: [<c01904e0>] nlmclnt_call+0xcf/0x204
Mar 20 18:47:13 tony kernel: [<c01908c3>] nlmclnt_lock+0x59/0xc9
Mar 20 18:47:13 tony kernel: [<c01902b5>] nlmclnt_proc+0x2d9/0x3a7
Mar 20 18:47:13 tony kernel: [<c0183bdd>] nfs_lock+0x1e2/0x263
Mar 20 18:47:13 tony kernel: [<c01839fb>] nfs_lock+0x0/0x263
Mar 20 18:47:13 tony kernel: [<c0154638>] fcntl_setlk64+0x215/0x296
Mar 20 18:47:13 tony kernel: [<c01411d7>] dentry_open+0x1a7/0x1c4
Mar 20 18:47:13 tony kernel: [<c0150462>] sys_fcntl64+0x4e/0x95
Mar 20 18:47:13 tony kernel: [<c0108d5b>] syscall_call+0x7/0xb


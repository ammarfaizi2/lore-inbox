Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTLUAVT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 19:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTLUAVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 19:21:19 -0500
Received: from [65.39.167.249] ([65.39.167.249]:36747 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S261837AbTLUAVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 19:21:17 -0500
Message-Id: <S261837AbTLUAVR/20031221002117Z+12080@vger.kernel.org>
From: <gmack@innerfire.net>
To: unlisted-recipients:; (no To-header on input)
Date: Sat, 20 Dec 2003 19:21:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From gmack@innerfire.net  Sat Dec 20 19:21:16 2003
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Dec 2003 00:21:16 -0000
Date: Sat, 20 Dec 2003 19:21:16 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 Badness in local_bh_enable at kernel/softirq.c:121
Message-ID: <Pine.LNX.4.58.0312201916330.23092@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-100.0 required=4.0 tests=USER_IN_WHITELIST version=2.20
X-Spam-Level: 

After about a day running 2.6.0. I lost my ppp connection and it wouldn't
come back.
When I checked the logs I found this:

Badness in local_bh_enable at kernel/softirq.c:121
Call Trace:
 [<c0128203>] local_bh_enable+0x93/0xa0
 [<c0264e0d>] ppp_async_push+0xbd/0x1b0
 [<c02646ae>] ppp_asynctty_wakeup+0x2e/0x70
 [<c0211c09>] pty_unthrottle+0x59/0x60
 [<c020e00b>] check_unthrottle+0x3b/0x40
 [<c020e0c3>] n_tty_flush_buffer+0x13/0x60
 [<c021201d>] pty_flush_buffer+0x6d/0x70
 [<c0211fb0>] pty_flush_buffer+0x0/0x70
 [<c020a489>] do_tty_hangup+0x499/0x530
 [<c020bb4a>] release_dev+0x69a/0x6d0
 [<c014574e>] release_pages+0x7e/0x1a0
 [<c0173311>] dput+0x31/0x270
 [<c020bf6b>] tty_release+0x3b/0x90
 [<c015bedf>] __fput+0xaf/0xc0
 [<c015a449>] filp_close+0x59/0x90
 [<c0125724>] put_files_struct+0x64/0xd0
 [<c01264bf>] do_exit+0x19f/0x400
 [<c01267f2>] do_group_exit+0x42/0xe0
 [<c010959b>] syscall_call+0x7/0xb

System is a dual 800 with 1 gig ram.  Motherboard is an ASUS CUR-DLS with
a ServerWorks chipset.

	Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

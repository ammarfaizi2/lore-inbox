Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264128AbTKZKoq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 05:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbTKZKoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 05:44:46 -0500
Received: from gwyn.kn-bremen.de ([212.63.36.242]:38121 "EHLO
	gwyn.kn-bremen.de") by vger.kernel.org with ESMTP id S264128AbTKZKop
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 05:44:45 -0500
Date: Wed, 26 Nov 2003 11:42:43 +0100
From: Christian Schlittchen <corwin@amber.kn-bremen.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test10: Badness in local_bh_enable at kernel/softirq.c:121
Message-ID: <20031126104243.GA1395@amber.kn-bremen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When trying to establish a ppp/pppoe connection I get the following
and the connection fails:

Badness in local_bh_enable at kernel/softirq.c:121
Call Trace:
[<c011feac>] local_bh_enable+0x8c/0x90
[<e096ccae>] ppp_sync_push+0x6e/0x1a0 [ppp_synctty]
[<c015cdc0>] __lookup_hash+0x70/0xd0
[<e096c651>] ppp_sync_wakeup+0x31/0x70 [ppp_synctty]
[<c0207b79>] pty_unthrottle+0x59/0x60
[<c02043ba>] check_unthrottle+0x3a/0x40
[<c0204463>] n_tty_flush_buffer+0x13/0x60
[<c0207f6d>] pty_flush_buffer+0x6d/0x70
[<c0200c0e>] do_tty_hangup+0x3fe/0x460
[<c0202246>] release_dev+0x656/0x6b0
[<c014010b>] zap_pmd_range+0x4b/0x70
[<c0140173>] unmap_page_range+0x43/0x70
[<c01656a2>] dput+0x22/0x220
[<c0202600>] tty_release+0x0/0x70
[<c020262a>] tty_release+0x2a/0x70
[<c014f468>] __fput+0x118/0x130
[<c014d9d9>] filp_close+0x59/0x90
[<c011d70c>] put_files_struct+0x5c/0xd0
[<c011e33f>] do_exit+0x15f/0x3b0
[<c011e66b>] do_group_exit+0x7b/0xc0
[<c010935b>] syscall_call+0x7/0xb

This is 100% reproducible with any kernel version since at least 2.5.71
I tried. I tried to recompile the kernel with different settings and
compilers, but the error stays the same.

I can provide more information if needed.

Regards, Christian


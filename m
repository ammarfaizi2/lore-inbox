Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268650AbUIGVHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268650AbUIGVHn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268261AbUIGVHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:07:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:64435 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268602AbUIGVCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:02:19 -0400
Date: Tue, 7 Sep 2004 23:02:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: 2.6.9-rc1-mm4 breaks OpenOffice
Message-ID: <20040907210216.GB17555@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Are there some futex-related changes in -mm4? [Hmm, does not seem
so]. OpenOffice seems to be pretty unhappy... (read "crashes with
segmentation fault after some futex operations).

Anyone else see the problems?

open("/home/pavel/.user60.rdb", O_RDWR) = 6
fcntl64(6, F_GETFD)                     = 0
fcntl64(6, F_SETFD, FD_CLOEXEC)         = 0
lseek(6, 0, SEEK_END)                   = 2048
mmap2(NULL, 2048, PROT_READ|PROT_WRITE, MAP_SHARED, 6, 0) = 0xb6c46000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6c45000
mmap2(NULL, 8388608, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6445000
mprotect(0xb6445000, 4096, PROT_NONE)   = 0
clone(child_stack=0xb6c44b48, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, parent_tidptr=0xb6c44bf8, {entry_number:6, base_addr:0xb6c44bb0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}, child_tidptr=0xb6c44bf8) = 1112
futex(0x808cd98, FUTEX_WAKE, 1)         = 1
futex(0x808ce10, FUTEX_WAIT, 0, NULL)   = -1 EINTR (Interrupted system call)
+++ killed by SIGSEGV (core dumped) +++

								Pavel


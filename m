Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262111AbSI3Psv>; Mon, 30 Sep 2002 11:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262113AbSI3Psv>; Mon, 30 Sep 2002 11:48:51 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:26342 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S262111AbSI3Psu>; Mon, 30 Sep 2002 11:48:50 -0400
Subject: 2.5.39-bk2 compile failure with CONFIG_XFS_FS=y
From: Steven Cole <elenstev@mesatop.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 30 Sep 2002 09:50:02 -0600
Message-Id: <1033401002.32409.62.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error building 2.5.39-bk2 with CONFIG_XFS_FS=y:

fs/xfs/pagebuf/page_buf.c: In function `pagebuf_queue_task':
fs/xfs/pagebuf/page_buf.c:1164: warning: implicit declaration of function `queue_task'
fs/xfs/pagebuf/page_buf.c: In function `pagebuf_iodone_daemon':
fs/xfs/pagebuf/page_buf.c:1709: warning: implicit declaration of function `TQ_ACTIVE'
fs/xfs/pagebuf/page_buf.c:1714: warning: implicit declaration of function `run_task_queue'
[snip]
fs/built-in.o: In function `pagebuf_queue_task':
fs/built-in.o(.text+0xcdee5): undefined reference to `queue_task'
fs/built-in.o: In function `pagebuf_iodone':
fs/built-in.o(.text+0xcdfb4): undefined reference to `queue_task'
fs/built-in.o: In function `pagebuf_iodone_daemon':
fs/built-in.o(.text+0xcea90): undefined reference to `TQ_ACTIVE'
fs/built-in.o(.text+0xceab6): undefined reference to `run_task_queue'
make: *** [.tmp_vmlinux] Error 1

Without CONFIG_XFS_FS=y or m, 2.5.39-bk2 compiles fine.
Plain vanilla 2.5.39 builds with CONFIG_XFS_FS=m.

Steven


